#include <pic14/pic12f675.h>

#define PRIMITIVE 0x52 // mascara para elegir que bits realimentar en este caso 6 xor 4 xor 2

void delay (unsigned int tiempo);
void setup();
unsigned char masking(unsigned char number);
unsigned char lfsr(unsigned char seed);
unsigned char get_unit(unsigned char number);


void main(void)
{
   	const unsigned int time = 10000;
   	unsigned char mask;
    	unsigned char seed = 41;
	unsigned char led1;
	unsigned char led2;
   	setup();
    //Loop forever
	while ( 1 )
    	{
    		//GP1 = 0x00;
    		if(GP3){
    			GPIO = 0x00;
    		}
    		else{
			seed = lfsr(seed);
			led1 = seed/10; 
			led2 = seed%10;		
			for(char i = 0; i<=255; i++){
				if (!GP4){
	    				mask = masking(led1);
	    				GPIO |= mask;
					GP4 = ~GP4;
					delay(10);
				}
				else{
					mask = masking(led2);
	    				GPIO |= mask;
					GP4 = ~GP4;
					delay(10);
			}
			GPIO &= 0x10;
			//delay(time);
			}		
		}
	}
}
void setup(){
	typedef unsigned int word;
    	TRISIO = 0b00001000; //Poner todos los pines como salidas
	GPIO = 0x00; //Poner pines en bajo
	word __at 0x207 __CONFIG = (_WDTE_OFF & _WDT_OFF & _MCLRE_OFF);
	ANSEL = 0x00;
	CMCON = 0x07;
}

// Esta funcion retorna una mascara para activar los bits del GPIO, del 0 al 7 la mascara es el mismo numero
//unicamente cambia en los numeros 8 y 9 ya que el 4 bit es la entrada
unsigned char masking(unsigned char number){
	unsigned char mask = number;
	switch(number){
		case 8: mask = 0x20;
		break;
		case 9: mask = 0x21;
		break;
	}
	return mask;
}

unsigned char lfsr(unsigned char seed) {
	unsigned char feedback_bit;
	feedback_bit = seed & PRIMITIVE; // aplicamos la mascara para obtener los bits a realimentar
	feedback_bit = feedback_bit >> 6 ^feedback_bit >>4 ^ feedback_bit>>1;
	feedback_bit &= 0x01; // Nos quedamos con el bit resultante de las xor anterior
	seed>>=1; // hacemos el corrimiento
	seed|=(feedback_bit<<6); // realimentamos el bit resultante en el bit #6 del seed
	seed &= 0x7F; // limpiamos el MSB para que no se pase de 100
	if(seed >= 100){
		return seed>>=1; // se divide entre 2
	}
	else{
		return seed;
	}
}



void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}


