
_InitMain:

;practica8.c,7 :: 		void InitMain() {
;practica8.c,8 :: 		ANSEL  = 0;                         // Configure AN pins as digital
	CLRF       ANSEL+0
;practica8.c,9 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;practica8.c,10 :: 		C1ON_bit = 0;                       // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;practica8.c,11 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;practica8.c,13 :: 		PORTA = 255;
	MOVLW      255
	MOVWF      PORTA+0
;practica8.c,14 :: 		TRISA = 255;                        // configure PORTA pins as input
	MOVLW      255
	MOVWF      TRISA+0
;practica8.c,15 :: 		PORTB = 0;                          // set PORTB to 0
	CLRF       PORTB+0
;practica8.c,16 :: 		TRISB = 0;                          // designate PORTB pins as output
	CLRF       TRISB+0
;practica8.c,17 :: 		PORTC = 0;                          // set PORTC to 0
	CLRF       PORTC+0
;practica8.c,18 :: 		TRISC = 0;                          // designate PORTC pins as output
	CLRF       TRISC+0
;practica8.c,19 :: 		PWM1_Init(5000);                    // Initialize PWM1 module at 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;practica8.c,21 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;practica8.c,23 :: 		void main() {
;practica8.c,24 :: 		InitMain();
	CALL       _InitMain+0
;practica8.c,25 :: 		current_duty  = 16;                 // initial value for current_duty
	MOVLW      16
	MOVWF      _current_duty+0
;practica8.c,26 :: 		current_duty1 = 16;                 // initial value for current_duty1
	MOVLW      16
	MOVWF      _current_duty1+0
;practica8.c,28 :: 		PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;practica8.c,30 :: 		PWM1_Set_Duty(current_duty);        // Set current duty for PWM1
	MOVF       _current_duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;practica8.c,33 :: 		while (1) {                         // endless loop
L_main0:
;practica8.c,34 :: 		if (RA0_bit==0) {                    // button on RA0 pressed
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main2
;practica8.c,35 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
;practica8.c,36 :: 		current_duty++;                 // increment current_duty
	INCF       _current_duty+0, 1
;practica8.c,37 :: 		PWM1_Set_Duty(current_duty);
	MOVF       _current_duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;practica8.c,38 :: 		}
L_main2:
;practica8.c,40 :: 		if (RA1_bit==0) {                    // button on RA1 pressed
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main4
;practica8.c,41 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
;practica8.c,42 :: 		current_duty--;                 // decrement current_duty
	DECF       _current_duty+0, 1
;practica8.c,43 :: 		PWM1_Set_Duty(current_duty);
	MOVF       _current_duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;practica8.c,44 :: 		}
L_main4:
;practica8.c,58 :: 		Delay_ms(5);                      // slow down change pace a little
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;practica8.c,59 :: 		}
	GOTO       L_main0
;practica8.c,60 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
