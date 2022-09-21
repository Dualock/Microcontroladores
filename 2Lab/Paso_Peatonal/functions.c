#include <stdio.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "functions.h"




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
	//printf("Blinking cars led during...");
	//timer(3);
}
void walk_request(){
   PORTB |= (1<<P_RED_LED);
   OCR0A = TICKETS_PER_SECOND;
   sei();
	//printf("walk_requested by pressing button");
	//timer(10);
}

void car_pass(){
	//printf(" Green light ");
	PORTB &= (1<<INTERRUPT_INPUT); // saves only the interrupt input state
	PORTB |= (1 << C_GREEN_LED); // turns on green car trafic light
	//_delay_ms(1000);
}

void car_stop() {
	//printf("Car stop/ red led turned on...");
	//timer(1);
}

void people_pass() {
	//printf("People green led turned on");
	//timer(10);
}

void stop_warning_people() {
	//printf("Blinking peoples led during...");
	//timer(3);
}

void people_stop() {
	//printf("People red led turned on");
	//timer 1

}

