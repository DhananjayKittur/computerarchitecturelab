	.data
N_COEFFS:   .word 3
coeff: 		.double -1.0, 1.0, -0.2
N_SAMPLES: .word 30
sample:	.double 68, 23, 27, 7, 46, 54, 66, 100, 44, 65, 52, 96, 50, 93, 4, 1, 25, 5, 33, 44, 79, 28, 64, 30, 92, 0, 98, 18, 50, 58
result:		.double 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


CR: .word32 0x10000
DR:    .word32 0x10008

		.text
	ld r4, N_SAMPLES(r0)
	ld r5, N_COEFFS(r0)
	slt r6, r4, r5
	;; sets 0 if r4 < r5 else sets 1
	bnez r6, exit
	;; SUBROUTINE STARTS HERE 
	;; Step 1: Find the sum of norm
	
	;;Bring all the coefficient values to the registers.
	;;
	;;TODO: Check whether the coefficient is positive or negative
	;;
	daddi r7, r0, 0
	l.d f1, coeff(r7)
	c.lt.d f1, f0
	bc1f COFF_1_POS
	sub.d f4, f0, f1 ;; If f1<f0, then make f1 = -f1
	j COEFF_2
COFF_1_POS:
	add.d f4, f4, f1
	;;
COEFF_2:	
	daddi r7, r7, 8
	l.d f2, coeff(r7)
	c.lt.d f2, f0
	bc1f COFF_2_POS
	sub.d f4, f4, f2
	j COEFF_3
COFF_2_POS:
	add.d f4, f4, f2
COEFF_3:
	daddi r7, r7, 8
	l.d f3, coeff(r7)
	;; f4 is the sum of all the values that is norm
	c.lt.d f3, f0
	bc1f COFF_3_POS
	sub.d f4, f4, f3 ;;
	j SUMM_COEFF
COFF_3_POS:
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
	dadd r6, r0, r4 ;; r6 = Number of sample
	daddi r6, r6, -2 ;; As we wont be considering first and last one
	l.d f6, sample(r7)
	daddi r7, r7, 8
	l.d f7, sample(r7)
	daddi r7, r7,8
outer_loop:	
	
	l.d f8, sample(r7)
	mul.d f9, f1, f6
	mul.d f10, f2, f7
	mul.d f11, f3, f8
	add.d f5, f9, f10
	add.d f5, f5, f11
	
	daddi r7, r7, -8
	s.d f5, result(r7) ;;We will have to store in one place before the current pointer
	daddi r7, r7, 16
	daddi r6, r6, -1
	mov.d f6, f7
	mov.d f7, f8
	bnez r6, outer_loop
	;;Store the n-1th position
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
	
exit:
	halt