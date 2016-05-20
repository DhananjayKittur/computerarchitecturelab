	.data
N_COEFFS:   .word 3
coeff: 		.double 0.1, 0.4, -0.8
N_SAMPLES: .word 43
sample:	.double 28, 5, 34, 63, 78, 14, 61, 18, 19, 96, 100, 94, 8, 68, 55, 18, 86, 33, 57, 95, 44, 37, 84, 9, 49, 3, 62, 33, 39, 10, 93, 80, 78, 27, 75, 72, 77, 16, 42, 27, 15, 66, 52
result:		.double 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

CR: .word32 0x10000
DR:    .word32 0x10008

		.text
	ld r4, N_SAMPLES(r0)
	ld r5, N_COEFFS(r0)
	daddi r15, r0, 0
	daddi r16, r0, 8
	slt r6, r4, r5
	daddi r17, r0, 16
	;; sets 0 if r4 < r5 else sets 1
	bnez r6, exit
	;; SUBROUTINE STARTS HERE 
	;; Step 1: Find the sum of norm
	
	;;Bring all the coefficient values to the registers.
	;;
	;;Check whether the coefficient is positive or negative
	;;
	;;daddi r7, r0, 0
	l.d f1, coeff(r15)
	l.d f2, coeff(r16)
	l.d f3, coeff(r17)
	c.lt.d f1, f0
	bc1f COFF_1_POS
	nop
	sub.d f4, f0, f1 ;; If f1<f0, then make f1 = -f1
	j COEFF_2
COFF_1_POS:
	nop
	add.d f4, f4, f1
	;;
COEFF_2:	
	;;daddi r7, r7, 8
	;;l.d f2, coeff(r7)
	c.lt.d f2, f0
	bc1f COFF_2_POS
	nop
	sub.d f4, f4, f2
	j COEFF_3
COFF_2_POS:
	nop
	add.d f4, f4, f2
COEFF_3:
	;;daddi r7, r7, 8
	;;l.d f3, coeff(r7)
	;; f4 is the sum of all the values that is norm
	c.lt.d f3, f0
	bc1f COFF_3_POS
	nop
	sub.d f4, f4, f3 ;;
	j SUMM_COEFF
COFF_3_POS:
	nop
	add.d f4, f4, f3
SUMM_COEFF:
	
	div.d f1, f1, f4
	div.d f2, f2, f4
	div.d f3, f3, f4
	;;Step 2: norm is stored in f4. Now reduce the coeff to zero 
	;;First store the zeroth position
	l.d f5, sample(r0)
	s.d f5, result(r0)
	
	daddi r7, r0, 0 ;;Set it to point to zeroth position of sample since for position 1 we need 0, 1, 2 for calculating
	daddi r6, r4, -2 ;; As we wont be considering first and last one, r6 = Number of sample
	l.d f6, sample(r7)
	daddi r7, r7, 8
	l.d f7, sample(r7)
	daddi r7, r7, 8
	andi r8, r6, 1
	beq r8, r0, outer_loop
	;;Handle for the odd case
	l.d f8, sample(r7)
	mul.d f10, f1, f6
	mul.d f11, f2, f7
	mul.d f12, f3, f8
	add.d f16, f10, f11
	add.d f16, f16, f12
	daddi r7, r7, -8
	s.d f16, result(r7)
	daddi r7, r7, 16
	mov.d f6, f7
	mov.d f7, f8
	daddi r6, r6, -1
	beqz r6, printdouble ;; Change it to exit while submitting
	
    ;; Needs major optimization since this is the loop and will execute multiple times here 
	;; Loading should be done from n+2 and storage should be done in n so 16 addition is needed to move it ahead and -8 while storage
	
	;;Consider for odd cases later on
outer_loop:	
	
	;;daddi r7, r7, 16  ;; Normalize the space for loading the next data
	
	l.d f8, sample(r7)
	daddi r7, r7, 8
	l.d f9, sample(r7)
	mul.d f10, f1, f6
	mul.d f11, f2, f7
	mul.d f12, f3, f8
	
	mul.d f13, f1, f7
	mul.d f14, f2, f8
	mul.d f15, f3, f9
	
	add.d f16, f10, f11
	
	daddi r7, r7, -16 ;; Normalize the space for storage
	add.d f17, f13, f14
	
	add.d f16, f16, f12
	
	daddi r6, r6, -2 ;; Moved up so that the branch instruction doesnt have to wait for it
	add.d f17, f17, f15
	
	s.d f16, result(r7) ;;We will have to store in one place before the current pointer
	daddi r7, r7, 8
	s.d f17, result(r7)
	mov.d f6, f8
	mov.d f7, f9
	daddi r7, r7, 16

	bnez r6, outer_loop
	
	
	;;Store the n-1th position
	nop
	daddi r7, r7, -8
	l.d f4, sample(r7)
	s.d f4, result(r7)

printdouble:
	lwu r11, CR(r0) ;; Control Register
	lwu r12, DR(r0) ;; Data Register
	daddi r10, r0, 3
	daddi r7, r0, 0
	ld r8, N_SAMPLES(r0)
PRINT_LOOP:
	l.d f1, result(r7)
	s.d f1, (r12)   ;; output f0 .... 
	sd r10, (r11)   ;; .... to screen
	daddi r8, r8, -1
	daddi r7, r7, 8
	bnez r8, PRINT_LOOP
	nop
;;printdouble ends	
exit:
	halt