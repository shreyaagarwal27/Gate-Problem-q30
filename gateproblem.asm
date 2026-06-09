; Pin mapping:
;   PB3 = Arduino D11 -> A LED
;   PB4 = Arduino D12 -> B LED
;   PB5 = Arduino D13 -> X LED (XNOR output)
 
.include "m328pdef.inc"
 
.org 0x0000
    rjmp MAIN
 
MAIN:
    ldi  r16, 0b00111000    ; Set PB3, PB4, PB5 as outputs
    out  DDRB, r16
 
LOOP:
    ldi  r17, 0             ; Loop counter i = 0
 
NEXT:
    ; --- Extract A (bit1) and B (bit0) from counter ---
    mov  r18, r17
    lsr  r18
    andi r18, 0x01          ; r18 = A
 
    mov  r19, r17
    andi r19, 0x01          ; r19 = B
 
    ; --- Drive A LED on PB3 ---
    tst  r18
    breq A_LOW
    sbi  PORTB, 3           ; A = 1 -> LED ON
    rjmp A_DONE
A_LOW:
    cbi  PORTB, 3           ; A = 0 -> LED OFF
A_DONE:
 
    ; --- Drive B LED on PB4 ---
    tst  r19
    breq B_LOW
    sbi  PORTB, 4           ; B = 1 -> LED ON
    rjmp B_DONE
B_LOW:
    cbi  PORTB, 4           ; B = 0 -> LED OFF
B_DONE:
 
    ; --- Compute XNOR: X = 1 if A == B ---
    cp   r18, r19
    breq SET_HIGH
    cbi  PORTB, 5           ; A != B -> X LED OFF
    rjmp DONE
SET_HIGH:
    sbi  PORTB, 5           ; A == B -> X LED ON
 
DONE:
    rcall DELAY             ; ~1 second delay
 
    inc   r17
    cpi   r17, 4
    brne  NEXT              ; Repeat for all 4 combinations
 
    rjmp  LOOP              ; Restart cycle indefinitely
 
DELAY:
    ldi  r20, 100
L1: ldi  r21, 255
L2: ldi  r22, 255
L3: dec  r22
    brne L3
    dec  r21
    brne L2
    dec  r20
    brne L1
    ret
