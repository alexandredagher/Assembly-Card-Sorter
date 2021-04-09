org     $1000

Array   db      $08, $04, $05, $0E, $09, $09, $05, $08, $08, $0D
EndOfArray

Found_Address   dw

Assembly Card Sorter

STACK   equ     $2000

        org     $2000
        lds     #STACK   ; Loading the stack
        ldx     #Array
        ldy     #Array+1  ; Setting y pointer one space ahead of x

        
Loop:   cpx     #EndOfArray-1  ; Checking if our outter loop has reached the end of the array
        bhs     EndLoop        ; If it has jump to end loop Label
        stx     Found_Address   ; Initializing the selection sort to the start
        ldaa    0,x             ; Initializing a to hold "Smallest Value" so far

        
InLoop: cpy     #EndOfArray    ; Check if y is point to the last element in our inner loop
        bhs     EndInLoop       ; If so jump to our EndInLoop label
        cmpa    0,y             ; compare the value inside accumulator a with contents of what y is pointed to
        bhi     If              ; if accumulator a is higher then jump to If label code
        bra     End_If          ; If not then jump to End_If code

End_If: iny                     ; Increment y pointer
        bra     InLoop          ; Jump back to InLoop Code

EndInLoop:
        ldab    0,x             ; Load accumulator b with our value to swap
        staa    0,x             ; Store our new lowest value where x is pointed to
        ldy     Found_Address   ; load register y with the new lowest values memory
        stab    0,y             ; store our old lowest value at the new lowest values location
        inx                      ; increment x
        tfr     x,y              ; transfer accumulator x into y
        iny                      ; increment x
        bra     Loop            ; branh to loop code
        
If:     sty     Found_Address   ; store memory location of y which is our new lowest value in our Found_Addres memory
        ldaa    0,y              ; load accumulator a with our new lowest value
        bra     End_If          ; jump to our end if code

EndLoop:swi
        end
