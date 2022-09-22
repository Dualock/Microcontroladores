
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#define C_RED_LED PB4
#define INTERRUPT_INPUT PB1
#define C_GREEN_LED PB5
#define P_RED_LED PB6
#define P_GREEN_LED PB7
#define TICKS_PER_SECOND 157 // 157 cicles for 1 ms using prescaler

// Function prototypes for every state

void idle();

void stop_warning_car();

void walk_request();

void car_pass();

void car_stop();

void people_pass();

void stop_warning_people();

void people_stop();
#endif // #ifndef FUNCTIONS_H
