#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "functions.h"
#include "state_machine.h"


/*C stands for car and P stands for pedestrean*/
#define C_RED_LED PB4
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB5
#define P_RED_LED PB6
#define P_GREEN_LED PB7


// Create new state machine object
state_machine_t state_machine;

/// ***************** Interrupt service routines ************************

ISR(PCINT1_vect){
	state_machine_Run(&state_machine, EV_BUTTON_PUSHED);
}
/// ************************ Setup Function *****************************

void setup(){
	// Setup pins B7, B6, B5, B4 as outputs
	DDRB = (1 << DDB7)|(1 << DDB6)|(1 << DDB5)|(1 << DDB4);
	
	//-------  Timer counter control register ---------

	// counter 0 on CTC mode
	TCCR0A = (1 << WGM01);

	// setup the the prescaler fclk/1024
	TCCR0B = (1 << CS02) | (1 << CS00);

	// Timer/counter interrupt mask setup to interrupt execute when comparing to counter 0
	TIMSK = (1 << OCIE0A);

	//-------- External interrupt setup ------
	PCMSK = (1 << PCINT1); 

	// Configure INT1 triggered by falling edge
	MCUCR = (1 << ISC11); 

	 // ---------- Initialize the FSM with IDLE state ---------
	state_machine_Init(&state_machine);
	_delay_ms(1000);
	// Set the state machine to its normal flow by passing no event
	state_machine_Run(&state_machine, EV_NONE);
	_delay_ms(1000);
}
/// ************************ Setup Function *****************************
int main(void)
{
	setup();
	// Button pushed
	state_machine_Run(&state_machine, EV_BUTTON_PUSHED);
  	while (1) {
    		PORTB &= 0x02; // preserve the bit of PORTB1
    		state_machine_Run(&state_machine, EV_NONE);
    //_delay_ms(1000);
    
  }
}

