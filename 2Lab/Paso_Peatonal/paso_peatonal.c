#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "functions.h"
#include "state_machine.h"


/*
#include <stdio.h>
#include <avr/interrupt.h>

#define C_RED_LED PB4
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB5
#define P_RED_LED PB6
#define P_GREEN_LED PB7
#define TICKETS_PER_SECOND 78
void walk_request(){
   //PORTB |= (1<<P_RED_LED);
   OCR0A = TICKETS_PER_SECOND;
   //current_timer = timer_1;
   sei();
}
*/

/*C stands for car and P stands for pedestrean*/
#define C_RED_LED PB4
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB5
#define P_RED_LED PB6
#define P_GREEN_LED PB7

unsigned int timer_1 = 100;
unsigned int timer_3 = 300;
unsigned int timer_10 = 1000;
unsigned int current_timer = 0;

// Create new state machine object
state_machine_t state_machine;

ISR(TIMER0_COMPA_vect){
  current_timer--;
  if(current_timer <= 0){
  	PORTB ^= (1<<P_GREEN_LED);
  }
 
}

void setup(){
	// Setup pins B7, B6, B5, B4, B5 as outputs
	DDRB = (1 << DDB7)|(1 << DDB6)|(1 << DDB5)|(1 << DDB4);
	
	/********  Timer counter control register ******/
	TCCR0A = (1 << WGM01); // set CTC mode for comparing counter 0
	TCCR0B = (1 << CS02) | (1 << CS00); // setup the the prescaler fclk/1024
	//Since we are using external pull down net we dont need to setup PORTB for that matter
	// For 1ms counting we need to 156 timer ticks to compare with
	// Timer/counter interrupt mask setup to interrupt execute when comparing to counter 0
	TIMSK = (1 << OCIE0A);
	 // Initialize the FSM with IDLE state
	state_machine_Init(&state_machine);
	_delay_ms(1000);
	// Set the state machine to its normal flow by passing no event
	state_machine_Run(&state_machine, EV_NONE);
	_delay_ms(1000);


	
}
int main(void)
{
	setup();


  while (1) {
  	/*PORTB|= 0x02;
  	state_machine_Run(&state_machine, EV_NONE);
  	car_pass();
  	_delay_ms(1000);*/

    PORTB &= 0x02; // preserve the bit of PORTB1
    //_delay_ms(10000);
    /*if(PINB & 0x02){ // Check if the input PORTB1 is high
    	current_timer = timer_1;
    	walk_request();
    }
    else{
        car_pass();
    }*/
    //car_pass();
    state_machine_Run(&state_machine, EV_NONE);
    _delay_ms(1000);
    state_machine_Run(&state_machine, EV_BUTTON_PUSHED);
  }
}

