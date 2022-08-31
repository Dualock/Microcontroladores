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
	extern	__modsint
	extern	__divsint
	extern	_ANSEL
	extern	_TRISIO
	extern	_CMCON
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
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
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x1012	res	1
r0x100C	res	1
r0x100D	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x100B	res	1
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
;   _lfsr
;   __divsint
;   __modsint
;   _masking
;   _delay
;   _masking
;   _delay
;   _setup
;   _lfsr
;   __divsint
;   __modsint
;   _masking
;   _delay
;   _masking
;   _delay
;8 compiler assigned registers:
;   r0x100E
;   r0x100F
;   r0x1010
;   STK02
;   STK01
;   STK00
;   r0x1011
;   r0x1012
;; Starting pCode block
S_bingo__main	code
_main:
; 2 exit points
;	.line	19; "bingo.c"	setup();
	PAGESEL	_setup
	CALL	_setup
	PAGESEL	$
_00113_DS_:
;	.line	24; "bingo.c"	if(GP3){
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,3
	GOTO	_00110_DS_
;	.line	25; "bingo.c"	GPIO = 0x00;
	CLRF	_GPIO
	GOTO	_00113_DS_
_00110_DS_:
;	.line	28; "bingo.c"	seed = lfsr(seed);
	MOVLW	0x29
	PAGESEL	_lfsr
	CALL	_lfsr
	PAGESEL	$
;	.line	29; "bingo.c"	led1 = seed/10; 
	MOVWF	r0x100E
	MOVWF	r0x100F
	CLRF	r0x1010
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x100F,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
;;1	MOVWF	r0x1011
	MOVF	STK00,W
	MOVWF	r0x100E
	MOVWF	r0x1012
;	.line	30; "bingo.c"	led2 = seed%10;		
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x100F,W
	MOVWF	STK00
	MOVF	r0x1010,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	MOVWF	r0x100F
	MOVF	STK00,W
	MOVWF	r0x100E
	MOVWF	r0x1010
_00115_DS_:
;	.line	32; "bingo.c"	if (!GP4){
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,4
	GOTO	_00106_DS_
;	.line	33; "bingo.c"	mask = masking(led1);
	MOVF	r0x1012,W
	PAGESEL	_masking
	CALL	_masking
	PAGESEL	$
;	.line	34; "bingo.c"	GPIO |= mask;
	MOVWF	r0x100E
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;	.line	35; "bingo.c"	GP4 = ~GP4;
	CLRF	r0x100E
	BTFSC	_GPIObits,4
	INCF	r0x100E,F
	COMF	r0x100E,W
	MOVWF	r0x100E
	RRF	r0x100E,W
	BTFSS	STATUS,0
	BCF	_GPIObits,4
	BTFSC	STATUS,0
	BSF	_GPIObits,4
;	.line	36; "bingo.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
	GOTO	_00107_DS_
_00106_DS_:
;	.line	39; "bingo.c"	mask = masking(led2);
	MOVF	r0x1010,W
	PAGESEL	_masking
	CALL	_masking
	PAGESEL	$
;	.line	40; "bingo.c"	GPIO |= mask;
	MOVWF	r0x100E
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;	.line	41; "bingo.c"	GP4 = ~GP4;
	CLRF	r0x100E
	BTFSC	_GPIObits,4
	INCF	r0x100E,F
	COMF	r0x100E,W
	MOVWF	r0x100E
	RRF	r0x100E,W
	BTFSS	STATUS,0
	BCF	_GPIObits,4
	BTFSC	STATUS,0
	BSF	_GPIObits,4
;	.line	42; "bingo.c"	delay(10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
_00107_DS_:
;	.line	44; "bingo.c"	GPIO &= 0x10;
	MOVLW	0x10
	BANKSEL	_GPIO
	ANDWF	_GPIO,F
;	.line	31; "bingo.c"	for(char i = 0; i<=255; i++){
	GOTO	_00115_DS_
;	.line	49; "bingo.c"	}
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
;	.line	90; "bingo.c"	void delay(unsigned int tiempo)
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
;	.line	95; "bingo.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1002
	CLRF	r0x1003
_00157_DS_:
	MOVF	r0x1000,W
	SUBWF	r0x1003,W
	BTFSS	STATUS,2
	GOTO	_00178_DS_
	MOVF	r0x1001,W
	SUBWF	r0x1002,W
_00178_DS_:
	BTFSC	STATUS,0
	GOTO	_00159_DS_
;;genSkipc:3307: created from rifx:0x7ffdca9a32a0
;	.line	96; "bingo.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	MOVWF	r0x1004
	MOVLW	0x04
	MOVWF	r0x1005
_00155_DS_:
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
	GOTO	_00155_DS_
;	.line	95; "bingo.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1002,F
	BTFSC	STATUS,2
	INCF	r0x1003,F
	GOTO	_00157_DS_
_00159_DS_:
;	.line	97; "bingo.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;; Starting pCode block
S_bingo__lfsr	code
_lfsr:
; 2 exit points
;	.line	72; "bingo.c"	unsigned char lfsr(unsigned char seed) {
	MOVWF	r0x1008
;	.line	74; "bingo.c"	feedback_bit = seed & PRIMITIVE; // aplicamos la mascara para obtener los bits a realimentar
	MOVLW	0x52
	ANDWF	r0x1008,W
	MOVWF	r0x1009
;	.line	75; "bingo.c"	feedback_bit = feedback_bit >> 6 ^feedback_bit >>4 ^ feedback_bit>>1;
	SWAPF	r0x1009,W
	ANDLW	0x0f
	MOVWF	r0x100A
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x100A,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x100A,F
	SWAPF	r0x1009,W
	ANDLW	0x0f
	MOVWF	r0x100B
	XORWF	r0x100A,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
	BCF	STATUS,0
	RRF	r0x1009,W
	MOVWF	r0x100B
	XORWF	r0x100A,F
;	.line	76; "bingo.c"	feedback_bit &= 0x01; // Nos quedamos con el bit resultante de las xor anterior
	MOVLW	0x01
	ANDWF	r0x100A,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	77; "bingo.c"	seed>>=1; // hacemos el corrimiento
	BCF	STATUS,0
	RRF	r0x1008,W
	MOVWF	r0x1009
;	.line	78; "bingo.c"	seed|=(feedback_bit<<6); // realimentamos el bit resultante en el bit #6 del seed
	MOVF	r0x100A,W
	MOVWF	r0x1008
	SWAPF	r0x1008,W
	ANDLW	0xf0
	MOVWF	r0x100A
	BCF	STATUS,0
	RLF	r0x100A,F
	BCF	STATUS,0
	RLF	r0x100A,F
	MOVF	r0x100A,W
	MOVWF	r0x1008
	IORWF	r0x1009,W
	MOVWF	r0x100A
;	.line	79; "bingo.c"	seed &= 0x7F; // limpiamos el MSB para que no se pase de 100
	MOVLW	0x7f
	ANDWF	r0x100A,W
	MOVWF	r0x1008
;;unsigned compare: left < lit(0x64=100), size=1
;	.line	80; "bingo.c"	if(seed >= 100){
	MOVLW	0x64
	SUBWF	r0x1008,W
	BTFSS	STATUS,0
	GOTO	_00144_DS_
;;genSkipc:3307: created from rifx:0x7ffdca9a32a0
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=0, offr=0
;	.line	81; "bingo.c"	return seed>>=1; // se divide entre 2
	BCF	STATUS,0
	RRF	r0x1008,W
	MOVWF	r0x1009
	GOTO	_00146_DS_
_00144_DS_:
;	.line	84; "bingo.c"	return seed;
	MOVF	r0x1008,W
_00146_DS_:
;	.line	86; "bingo.c"	}
	RETURN	
; exit point of _lfsr

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;2 compiler assigned registers:
;   r0x100C
;   r0x100D
;; Starting pCode block
S_bingo__masking	code
_masking:
; 2 exit points
;	.line	61; "bingo.c"	unsigned char masking(unsigned char number){
	MOVWF	r0x100C
;	.line	62; "bingo.c"	unsigned char mask = number;
	MOVWF	r0x100D
;	.line	63; "bingo.c"	switch(number){
	MOVF	r0x100C,W
	XORLW	0x08
	BTFSC	STATUS,2
	GOTO	_00124_DS_
	MOVF	r0x100C,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00125_DS_
	GOTO	_00126_DS_
_00124_DS_:
;	.line	64; "bingo.c"	case 8: mask = 0x20;
	MOVLW	0x20
	MOVWF	r0x100D
;	.line	65; "bingo.c"	break;
	GOTO	_00126_DS_
_00125_DS_:
;	.line	66; "bingo.c"	case 9: mask = 0x21;
	MOVLW	0x21
	MOVWF	r0x100D
_00126_DS_:
;	.line	69; "bingo.c"	return mask;
	MOVF	r0x100D,W
;	.line	70; "bingo.c"	}
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
;	.line	52; "bingo.c"	TRISIO = 0b00001000; //Poner todos los pines como salidas
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	53; "bingo.c"	GPIO = 0x00; //Poner pines en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	55; "bingo.c"	ANSEL = 0x00;
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	56; "bingo.c"	CMCON = 0x07;
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	57; "bingo.c"	}
	RETURN	
; exit point of _setup


;	code size estimation:
;	  190+   25 =   215 instructions (  480 byte)

	end
