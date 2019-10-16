;*******************************************************************************
;   MSP430G2xx3 Demo - Software Poll P1.3, Set P1.0 if P1.3 = 1
;
;   Description: Poll P1.3 in a loop, if hi P1.0 is set, if low, P1.0 reset.
;   ACLK = n/a, MCLK = SMCLK = default DCO
;
;                MSP430G2xx3
;             -----------------
;         /|\|              XIN|-
;          | |                 |
;          --|RST          XOUT|-
;      /|\   |                 |
;       --o--|P1.3        P1.0|-->LED
;      \|/
;
;   D. Dang
;   Texas Instruments Inc.
;   December 2010
;   Built with Code Composer Essentials Version: 4.2.0
;*******************************************************************************
 .cdecls C,LIST,  "msp430g2553.h"
;------------------------------------------------------------------------------
            .text                           ; Program Start
;------------------------------------------------------------------------------
RESET       mov.w   #0280h,SP               ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT
SetupP1     bis.b   #001h,&P1DIR            ; P1.0 output
            bis.b   #001h,&P1OUT 
            clr		R5                                   ;				          			
Mainloop    inc		R5
			jn      ON                      ; jmp--> P1.3 is set
                                            ;
OFF         bic.b   #001h,&P1OUT            ; P1.0 = 0 / LED OFF
            jmp     Mainloop                ;
ON          bis.b   #001h,&P1OUT            ; P1.0 = 1 / LED ON
            jmp     Mainloop                ;
                                            ;
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
