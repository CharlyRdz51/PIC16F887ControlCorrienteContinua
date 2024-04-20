#line 1 "C:/Users/user/Desktop/practica8/practica8.c"


unsigned short current_duty, old_duty, current_duty1, old_duty1;



void InitMain() {
 ANSEL = 0;
 ANSELH = 0;
 C1ON_bit = 0;
 C2ON_bit = 0;

 PORTA = 255;
 TRISA = 255;
 PORTB = 0;
 TRISB = 0;
 PORTC = 0;
 TRISC = 0;
 PWM1_Init(5000);

}

void main() {
 InitMain();
 current_duty = 16;
 current_duty1 = 16;

 PWM1_Start();

 PWM1_Set_Duty(current_duty);


 while (1) {
 if (RA0_bit==0) {
 Delay_ms(40);
 current_duty++;
 PWM1_Set_Duty(current_duty);
 }

 if (RA1_bit==0) {
 Delay_ms(40);
 current_duty--;
 PWM1_Set_Duty(current_duty);
 }
#line 58 "C:/Users/user/Desktop/practica8/practica8.c"
 Delay_ms(5);
 }
}
