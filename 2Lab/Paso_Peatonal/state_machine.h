// Structure idea taken from Geoffrey Hunter (www.mbedded.ninja)
#ifndef STATE_MACHINE_H
#define STATE_MACHINE_H

// states
typedef enum {
    ST_IDLE,
    ST_CAR_PASS,
    ST_WALK_REQUEST,
    ST_STOP_WARNING_CAR,
    ST_CAR_STOP,
    ST_PEOPLE_PASS,
    ST_STOP_WARNING_PEOPLE,
    ST_PEOPLE_STOP
} state_t;

// state machine
typedef struct {
    state_t current_state;
} state_machine_t;

// Possible events
typedef enum {
    EV_NONE,
    EV_BUTTON_PUSHED,
    EV_TIME_OUT_10,
    EV_TIME_OUT_3,
    EV_TIME_OUT_1,
} event_t;

// Function prototypes
void state_machine_Init(state_machine_t * state_machine);

void state_machine_Run(state_machine_t *state_machine, event_t event);

const char * state_machine_GetStateName(state_t state);

#endif
