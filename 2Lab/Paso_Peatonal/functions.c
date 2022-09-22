#include <stdio.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "functions.h"

// ********** Global variables *********************

unsigned int timer_1 = 100;
unsigned int timer_3 = 300;
unsigned int timer_10 = 1000;
unsigned int current_max_time = 0;
unsigned int current_timer = 0;

// Interruption code for timer interrupt
ISR(TIMER0_COMPA_vect){
  current_timer++;
  if(current_timer <= current_max_time){
	// do something else when timer reaches the max time
  	PORTB ^= (1<<P_GREEN_LED);
	current_timer = 0;
  }
 
}

/// ****************** Functions for each state ********************

void idle(){
	//printf("idle");
	// turns on every light
	PORTB |= (1<<C_GREEN_LED);
	PORTB |= (1<<C_RED_LED);
	PORTB |= (1<<P_GREEN_LED);
	PORTB |= (1<<P_RED_LED);
	_delay_ms(1000);
}

void stop_warning_car() {
	current_max_time = timer_3;
	PORTB ^= (1<<C_GREEN_LED); // Blinks led
	OCR0A = TICKS_PER_SECOND;
}
void walk_request(){
	current_max_time = timer_10;
   	PORTB |= (1<<P_RED_LED);
   	OCR0A = TICKS_PER_SECOND;
   	sei();
	//printf("walk_requested by pressing button");
	//timer(10);
}

void car_pass(){
	PORTB &= (1<<INTERRUPT_INPUT); // saves only the interrupt input state
	PORTB ^= (1 << C_GREEN_LED); // turns on green car trafic light
	OCR0A = TICKS_PER_SECOND;
   	sei();
}

void car_stop() {
	PORTB |= (1<<C_RED_LED);
	OCR0A = TICKS_PER_SECOND;
	current_max_time = timer_1;
}

void people_pass() {
	PORTB |= (1<<P_GREEN_LED);
	OCR0A = TICKS_PER_SECOND;
	current_max_time = timer_10;
}

void stop_warning_people() {
	PORTB ^= (1<<P_GREEN_LED); // blinks led
	OCR0A = TICKS_PER_SECOND;
	current_max_time = timer_3;
}

void people_stop() {
	PORTB |= (1<<P_RED_LED);
	OCR0A = TICKS_PER_SECOND;
	current_max_time = timer_1;
}

