#include <stdio.h>

// Local includes
#include "functions.h"
#include "state_machine.h"


typedef struct {
    const char * name;
    void (*func)(void);
} stateFunctionRow_t;

/// \brief  Maps a state to it's state transition function, which should be called
///         when the state transitions into this state.
/// \warning    This has to stay in sync with the state_t enum!
static stateFunctionRow_t stateFunctionA[] = {
      // NAME         // FUNC
    { "ST_IDLE",      		&idle 			},
    { "ST_CAR_PASS",    	&car_pass 		}, 
    { "ST_WALK_REQUEST",   	&walk_request 		}, 
    { "ST_STOP_WARNING_CAR",   	&stop_warning_car 	}, 
    { "ST_CAR_STOP",   		&car_stop 		}, 
    { "ST_PEOPLE_PASS",   	&people_pass 		}, 
    { "ST_STOP_WARNING_PEOPLE", &stop_warning_people 	}, 
    { "ST_PEOPLE_STOP", 	&people_stop 		}, 
};

typedef struct {
    state_t current_state;
    event_t event;
    state_t nextState;
} stateTransMatrixRow_t;

static stateTransMatrixRow_t stateTransMatrix[] = {
    // CURRENT STATE    	// EVENT              // NEXT STATE
    { ST_IDLE, 			EV_NONE,     	 	ST_CAR_PASS  		},
    { ST_CAR_PASS, 		EV_NONE,     	 	ST_CAR_PASS 		},
    { ST_CAR_PASS, 		EV_BUTTON_PUSHED,     	ST_WALK_REQUEST    	},
    { ST_WALK_REQUEST,  	EV_TIME_OUT_10,         ST_STOP_WARNING_CAR  	},
    { ST_STOP_WARNING_CAR,  	EV_TIME_OUT_3,     	ST_CAR_STOP    		},
    { ST_CAR_STOP,  		EV_TIME_OUT_1,     	ST_PEOPLE_PASS        	},
    { ST_PEOPLE_PASS,  		EV_TIME_OUT_10,     	ST_STOP_WARNING_PEOPLE	},
    { ST_STOP_WARNING_PEOPLE,  	EV_TIME_OUT_3,     	ST_PEOPLE_STOP		},
    { ST_PEOPLE_STOP,  		EV_TIME_OUT_1,     	ST_CAR_PASS		},
};

void state_machine_Init(state_machine_t * state_machine) {
    printf("Initialising state machine.\r\n");
    state_machine->current_state = ST_IDLE;
}

void state_machine_Run(state_machine_t *state_machine, event_t event) {

    // Iterate through the state transition matrix, checking if there is both a match with the current state
    // and the event
    for(int i = 0; i < sizeof(stateTransMatrix)/sizeof(stateTransMatrix[0]); i++) {
        if(stateTransMatrix[i].current_state == state_machine->current_state) {
            if((stateTransMatrix[i].event == event)) {

                // Transition to the next state
                state_machine->current_state =  stateTransMatrix[i].nextState;

                // Call the function associated with transition
                (stateFunctionA[state_machine->current_state].func)();
                break;
            }
        }
    }
}

const char * state_machine_GetStateName(state_t state) {
    return stateFunctionA[state].name;
}
