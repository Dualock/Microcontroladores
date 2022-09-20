#include <stdio.h>
#include <avr/interrupt.h>
#define C_RED_LED PB0
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB2
#define P_RED_LED PB3
#define P_GREEN_LED PB4

void led_blink() {
    PORTB |= (1<<P_GREEN_LED); // Puts high PortB4
    PORTB |= (1<<P_RED_LED); // Puts high PortB3
    PORTB |= (1<<C_GREEN_LED); // Puts high PortB2
    PORTB |= (1<<C_RED_LED); // Puts high PortB0
}
void walk_request(){
}

void people_walk(){

}

void people_stop(){

}

void car_pass(){

}

void people_led_blink(){

}

void car_led_blink(){

}
