#include <pic14/pic12f675.h>
#include <stdlib.h>
#include <stdio.h>

#define PRIMITIVE 0x03 // mascara para elegir que bits realimentar en este caso 3 xor 1
#define PUSH_B GP3
#define SELECTOR GP4
#define MAX_NUMBERS 16
void delay (unsigned int tiempo);
void setup();
unsigned char masking(unsigned char number);
unsigned char lfsr(unsigned char seed);
void LED_display_switching(unsigned char led1, unsigned char led2);

void main(void)
{
	setup();
	const unsigned int time = 10000;
	unsigned char counter = 0;
	unsigned char seed = 7;
   	//delay(10);
	unsigned char led1;
	unsigned char led2;
    	while(1){
	    	if(MAX_NUMBERS>counter){
	    		GPIO |= masking(0); // Se pone en 0 
	    		delay(10); // Delay inicial
		    	if(PUSH_B){ // boton sin presionar
		    		GPIO = 0x00;
		    	}
		    	else if(!PUSH_B){ // boton presionado
				seed = lfsr(seed);
				led1 = seed;
				led2 = seed - counter;
				led2 = lfsr(led2);
				LED_display_switching(led1, led2);
				counter++; // por alguna razon este contador se resetea en 1	
			}
		}
		// si ya pasaron los 16 numeros
		else{
		GPIO&=0x08; // limpia los bits menos GP3
		LED_display_switching(7,7);
		delay(10);
		}
	}
}
void LED_display_switching(unsigned char led1, unsigned char led2){
	for(int k = 0; k<100; k++){
        	if (SELECTOR){ //Display Unidades
			GPIO |= masking(led1);				
			delay(10);
		}
		else{ // Display Decenas
			GPIO |= masking(led2);
			delay(10);
		}
		GP4 = ~GP4;
		GPIO &= 0x18; // limpia los bits menos GP3 y GP4
	}
}
void setup(){
	typedef unsigned int word;
    	TRISIO = 0b00001000; //Poner todos los pines como salidas
	GPIO = 0x00; //Poner pines en bajo
	word __at 0x207 __CONFIG = (_WDTE_OFF & _WDT_OFF & _MCLRE_OFF);
	ANSEL = 0x00;
	//CMCON = 0x07;
}

// Esta funcion retorna una mascara para activar los bits del GPIO, del 0 al 7 la mascara es el mismo numero
//unicamente cambia en los numeros 8 y 9 ya que el 4 bit es la entrada
unsigned char masking(unsigned char number){
	switch(number){
		case 8: return 0x20;
		case 9: return 0x21;
		default: return number;
	}
	//return mask;
}

unsigned char lfsr(unsigned char seed) {
	unsigned char feedback_bit;
	feedback_bit = seed & PRIMITIVE; // aplicamos la mascara para obtener los bits a realimentar
	feedback_bit = feedback_bit >>1 ^ feedback_bit;
	feedback_bit &= 0x01;
	seed>>=1;
	seed|=(feedback_bit<<3);
	seed &= 0x0F; // limpiamos el MSB para que no se pase de 15
	
	if(seed >= 10){
		seed = (seed>>1) - 1;
		return seed;
	}
	else{
		return seed;
	}
}



void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;
	//*i = 0;
	for(i=0;i<tiempo;(i)++)
	for(j = 0; j<1275; (j)++);



}


