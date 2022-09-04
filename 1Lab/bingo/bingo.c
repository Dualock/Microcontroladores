#include <pic14/pic12f675.h>
#include <stdlib.h>
#include <stdio.h>

#define PRIMITIVE 0x03 // mascara para elegir que bits realimentar en este caso b[1] xor b[0]
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
	    	while(counter<MAX_NUMBERS){
	    		//GPIO |= masking(0); // Se pone en 0 
	    		//delay(10); // Delay inicial
		    	if(!PUSH_B){ // boton presionado
				seed = lfsr(seed);
				led1 = seed;
				led2 = seed - counter;
				led2 = lfsr(led2);
				LED_display_switching(led1, counter);
				counter++; // por alguna razon este contador se resetea en 1
			}
		}
		// si ya pasaron los 16 numeros
		GPIO&=0x08; // limpia los bits menos GP3
		LED_display_switching(9,9);
		delay(10);
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
		SELECTOR = ~SELECTOR;
		GPIO &= 0x18; // limpia los bits menos GP3 y GP4
	}
}


void setup(){
	typedef unsigned int word;
	word __at 0x207 __CONFIG = (_WDTE_OFF & _WDT_OFF & _MCLRE_OFF);
    	TRISIO = 0b00000000; //Poner todos los pines como salidas, bit[3] siempre lee 1
	GPIO = 0x00; //Poner pines en bajo
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
	for(i=0;i<tiempo;(i)++)
	for(j = 0; j<1275; (j)++);
}


