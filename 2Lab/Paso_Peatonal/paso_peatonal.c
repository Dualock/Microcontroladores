#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "functions.h"

/*C stands for car and P stands for pedestrean*/
#define C_RED_LED PB0
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB2
#define P_RED_LED PB3
#define P_GREEN_LED PB4


/*ISR(PCINT1_vect){
  PORTB |= (1<<P_GREEN_LED);
  _delay_ms(5000);
}*/

void setup(){
	// Setup pins B0, B2, B3, B4, B5 as outputs
	DDRB = (1<<DDB5)|(1<<DDB4)|(1<<DDB3)|(1<<DDB2)|(1<<DDB0);
}
int main(void)
{
	setup();
  //DDRB = 0x08; //Configuracion del puerto
 

  //Parpadear
  while (1) {
    PORTB = 0x00; _delay_ms(5000);
    led_blink();
    /*
    PORTB |= (1<<P_GREEN_LED); // Puts high PortB4
    PORTB |= (1<<P_RED_LED); // Puts high PortB3
    PORTB |= (1<<C_GREEN_LED); // Puts high PortB2
    PORTB |= (1<<C_RED_LED); // Puts high PortB0*/
    _delay_ms(5000);
    
  }
}

