;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"bingo.c"
	list	p=12f675
	radix dec
	include "p12f675.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_ANSEL
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_LED_display_switching
	global	_setup
	global	_masking
	global	_lfsr
	global	_delay

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0020
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_bingo_0	udata
r0x1011	res	1
r0x1012	res	1
r0x1013	res	1
r0x100C	res	1
r0x100D	res	1
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x100B	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x1001	res	1
r0x1000	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
r0x1007	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_bingo	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _setup
;   _masking
;   _delay
;   _lfsr
;   _lfsr
;   _LED_display_switching
;   _LED_display_switching
;   _delay
;   _setup
;   _masking
;   _delay
;   _lfsr
;   _lfsr
;   _LED_display_switching
;   _LED_display_switching
;   _delay
;4 compiler assigned registers:
;   r0x1011
;   r0x1012
;   r0x1013
;   STK00
;; Starting pCode block
S_bingo__main	code
_main:
; 2 exit points
;	.line	17; "bingo.c"	setup();
	PAGESEL	_setup
	CALL	_setup
	PAGESEL	$
;	.line	20; "bingo.c"	unsigned char seed = 7;
	MOVLW	0x07
	MOVWF	r0x1011
;	.line	24; "bingo.c"	while(1){
	CLRF	r0x1012
;;unsigned compare: left < lit(0x10=16), size=1
_00114_DS_:
;	.line	25; "bingo.c"	if(MAX_NUMBERS>counter){
	MOVLW	0x10
	SUBWF	r0x1012,W
	BTFSC	STATUS,0
	GOTO	_00111_DS_
;;genSkipc:3307: created from rifx:0x7ffd74255670
;	.line	26; "bingo.c"	GPIO |= masking(0);
	MOVLW	0x00
	PAGESEL	_masking
	CALL	_masking
	PAGESEL	$
	MOVWF	r0x1013
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;	.line	27; "bingo.c"	delay(10); // Delay inicial
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	28; "bingo.c"	if(PUSH_B){ // boton sin presionar
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,3
	GOTO	_00108_DS_
;	.line	29; "bingo.c"	GPIO = 0x00;
	CLRF	_GPIO
	GOTO	_00114_DS_
_00108_DS_:
;	.line	31; "bingo.c"	else if(!PUSH_B){ // boton presionado
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,3
	GOTO	_00114_DS_
;	.line	32; "bingo.c"	seed = lfsr(seed);
	MOVF	r0x1011,W
	PAGESEL	_lfsr
	CALL	_lfsr
	PAGESEL	$
	MOVWF	r0x1011
;	.line	34; "bingo.c"	led2 = seed - counter;
	MOVF	r0x1012,W
	SUBWF	r0x1011,W
;	.line	35; "bingo.c"	led2 = lfsr(led2);
	MOVWF	r0x1013
	PAGESEL	_lfsr
	CALL	_lfsr
	PAGESEL	$
;	.line	36; "bingo.c"	LED_display_switching(led1, led2);
	MOVWF	r0x1013
	MOVWF	STK00
	MOVF	r0x1011,W
	PAGESEL	_LED_display_switching
	CALL	_LED_display_switching
	PAGESEL	$
;	.line	37; "bingo.c"	counter++; // por alguna razon este contador se resetea en 1	
	INCF	r0x1012,F
	GOTO	_00114_DS_
_00111_DS_:
;	.line	42; "bingo.c"	GPIO&=0x08; // limpia los bits menos GP3
	MOVLW	0x08
	BANKSEL	_GPIO
	ANDWF	_GPIO,F
;	.line	43; "bingo.c"	LED_display_switching(7,7);
	MOVLW	0x07
	MOVWF	STK00
	MOVLW	0x07
	PAGESEL	_LED_display_switching
	CALL	_LED_display_switching
	PAGESEL	$
;	.line	44; "bingo.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
	GOTO	_00114_DS_
;	.line	47; "bingo.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;   r0x1005
;   r0x1006
;   r0x1007
;; Starting pCode block
S_bingo__delay	code
_delay:
; 2 exit points
;	.line	102; "bingo.c"	void delay(unsigned int tiempo)
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
;	.line	107; "bingo.c"	for(i=0;i<tiempo;(i)++)
	CLRF	r0x1002
	CLRF	r0x1003
_00184_DS_:
	MOVF	r0x1000,W
	SUBWF	r0x1003,W
	BTFSS	STATUS,2
	GOTO	_00205_DS_
	MOVF	r0x1001,W
	SUBWF	r0x1002,W
_00205_DS_:
	BTFSC	STATUS,0
	GOTO	_00186_DS_
;;genSkipc:3307: created from rifx:0x7ffd74255670
;	.line	108; "bingo.c"	for(j = 0; j<1275; (j)++);
	MOVLW	0xfb
	MOVWF	r0x1004
	MOVLW	0x04
	MOVWF	r0x1005
_00182_DS_:
	MOVLW	0xff
	ADDWF	r0x1004,W
	MOVWF	r0x1006
	MOVLW	0xff
	MOVWF	r0x1007
	MOVF	r0x1005,W
	BTFSC	STATUS,0
	INCFSZ	r0x1005,W
	ADDWF	r0x1007,F
	MOVF	r0x1006,W
	MOVWF	r0x1004
	MOVF	r0x1007,W
	MOVWF	r0x1005
	MOVF	r0x1007,W
	IORWF	r0x1006,W
	BTFSS	STATUS,2
	GOTO	_00182_DS_
;	.line	107; "bingo.c"	for(i=0;i<tiempo;(i)++)
	INCF	r0x1002,F
	BTFSC	STATUS,2
	INCF	r0x1003,F
	GOTO	_00184_DS_
_00186_DS_:
;	.line	112; "bingo.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;3 compiler assigned registers:
;   r0x1008
;   r0x1009
;   r0x100A
;; Starting pCode block
S_bingo__lfsr	code
_lfsr:
; 2 exit points
;	.line	82; "bingo.c"	unsigned char lfsr(unsigned char seed) {
	MOVWF	r0x1008
;	.line	84; "bingo.c"	feedback_bit = seed & PRIMITIVE; // aplicamos la mascara para obtener los bits a realimentar
	MOVLW	0x03
	ANDWF	r0x1008,W
	MOVWF	r0x1009
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	85; "bingo.c"	feedback_bit = feedback_bit >>1 ^ feedback_bit;
	BCF	STATUS,0
	RRF	r0x1009,W
	MOVWF	r0x100A
	MOVF	r0x1009,W
	XORWF	r0x100A,F
;	.line	86; "bingo.c"	feedback_bit &= 0x01;
	MOVLW	0x01
	ANDWF	r0x100A,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	87; "bingo.c"	seed>>=1;
	BCF	STATUS,0
	RRF	r0x1008,W
	MOVWF	r0x1009
;	.line	88; "bingo.c"	seed|=(feedback_bit<<3);
	MOVF	r0x100A,W
	MOVWF	r0x1008
	BCF	STATUS,0
	RLF	r0x1008,W
	MOVWF	r0x100A
	BCF	STATUS,0
	RLF	r0x100A,F
	BCF	STATUS,0
	RLF	r0x100A,F
	MOVF	r0x100A,W
	MOVWF	r0x1008
	IORWF	r0x1009,W
	MOVWF	r0x100A
;	.line	89; "bingo.c"	seed &= 0x0F; // limpiamos el MSB para que no se pase de 15
	MOVLW	0x0f
	ANDWF	r0x100A,W
	MOVWF	r0x1008
;;unsigned compare: left < lit(0xA=10), size=1
;	.line	91; "bingo.c"	if(seed >= 10){
	MOVLW	0x0a
	SUBWF	r0x1008,W
	BTFSS	STATUS,0
	GOTO	_00171_DS_
;;genSkipc:3307: created from rifx:0x7ffd74255670
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	92; "bingo.c"	seed = (seed>>1) - 1;
	BCF	STATUS,0
	RRF	r0x1008,W
	MOVWF	r0x1009
	MOVWF	r0x100A
	DECF	r0x100A,W
;	.line	93; "bingo.c"	return seed;
	MOVWF	r0x1009
	GOTO	_00173_DS_
_00171_DS_:
;	.line	96; "bingo.c"	return seed;
	MOVF	r0x1008,W
_00173_DS_:
;	.line	98; "bingo.c"	}
	RETURN	
; exit point of _lfsr

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;1 compiler assigned register :
;   r0x100B
;; Starting pCode block
S_bingo__masking	code
_masking:
; 2 exit points
;	.line	73; "bingo.c"	unsigned char masking(unsigned char number){
	MOVWF	r0x100B
;	.line	74; "bingo.c"	switch(number){
	XORLW	0x08
	BTFSC	STATUS,2
	GOTO	_00150_DS_
	MOVF	r0x100B,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00151_DS_
	GOTO	_00152_DS_
_00150_DS_:
;	.line	75; "bingo.c"	case 8: return 0x20;
	MOVLW	0x20
	GOTO	_00154_DS_
_00151_DS_:
;	.line	76; "bingo.c"	case 9: return 0x21;
	MOVLW	0x21
	GOTO	_00154_DS_
_00152_DS_:
;	.line	77; "bingo.c"	default: return number;
	MOVF	r0x100B,W
_00154_DS_:
;	.line	80; "bingo.c"	}
	RETURN	
; exit point of _masking

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_bingo__setup	code
_setup:
; 2 exit points
;	.line	64; "bingo.c"	TRISIO = 0b00001000; //Poner todos los pines como salidas
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	65; "bingo.c"	GPIO = 0x00; //Poner pines en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	67; "bingo.c"	ANSEL = 0x00;
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	69; "bingo.c"	}
	RETURN	
; exit point of _setup

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _masking
;   _delay
;   _masking
;   _delay
;   _masking
;   _delay
;   _masking
;   _delay
;6 compiler assigned registers:
;   r0x100C
;   STK00
;   r0x100D
;   r0x100E
;   r0x100F
;   r0x1010
;; Starting pCode block
S_bingo__LED_display_switching	code
_LED_display_switching:
; 2 exit points
;	.line	48; "bingo.c"	void LED_display_switching(unsigned char led1, unsigned char led2){
	MOVWF	r0x100C
	MOVF	STK00,W
	MOVWF	r0x100D
;	.line	49; "bingo.c"	for(int k = 0; k<100; k++){
	CLRF	r0x100E
	CLRF	r0x100F
;;signed compare: left < lit(0x64=100), size=2, mask=ffff
_00124_DS_:
	MOVF	r0x100F,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00141_DS_
	MOVLW	0x64
	SUBWF	r0x100E,W
_00141_DS_:
	BTFSC	STATUS,0
	GOTO	_00126_DS_
;;genSkipc:3307: created from rifx:0x7ffd74255670
;	.line	50; "bingo.c"	if (SELECTOR){ //Display Unidades
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,4
	GOTO	_00120_DS_
;	.line	51; "bingo.c"	GPIO |= masking(led1);				
	MOVF	r0x100C,W
	PAGESEL	_masking
	CALL	_masking
	PAGESEL	$
	MOVWF	r0x1010
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;	.line	52; "bingo.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
	GOTO	_00121_DS_
_00120_DS_:
;	.line	55; "bingo.c"	GPIO |= masking(led2);
	MOVF	r0x100D,W
	PAGESEL	_masking
	CALL	_masking
	PAGESEL	$
	MOVWF	r0x1010
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;	.line	56; "bingo.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
_00121_DS_:
;	.line	58; "bingo.c"	GP4 = ~GP4;
	CLRF	r0x1010
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,4
	INCF	r0x1010,F
	COMF	r0x1010,W
	MOVWF	r0x1010
	RRF	r0x1010,W
	BTFSS	STATUS,0
	BCF	_GPIObits,4
	BTFSC	STATUS,0
	BSF	_GPIObits,4
;	.line	59; "bingo.c"	GPIO &= 0x18; // limpia los bits menos GP3 y GP4
	MOVLW	0x18
	ANDWF	_GPIO,F
;	.line	49; "bingo.c"	for(int k = 0; k<100; k++){
	INCF	r0x100E,F
	BTFSC	STATUS,2
	INCF	r0x100F,F
	GOTO	_00124_DS_
_00126_DS_:
;	.line	61; "bingo.c"	}
	RETURN	
; exit point of _LED_display_switching


;	code size estimation:
;	  199+   35 =   234 instructions (  538 byte)

	end
