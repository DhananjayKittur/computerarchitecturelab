	.data
N_COEFFS:   .word 3
coeff: 		.double 0.5, 1, 0.5
N_SAMPLES: .word 5
sample:	.double 1, 2, 1, 2, 1
result:		.double 0, 0, 0, 0, 0

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
	daddi r7, r7, 8
	l.d f2, coeff(r7)
	daddi r7, r7, 8
	l.d f3, coeff(r7)
	;; f4 is the sum of all the values that is norm
	add.d f4, f1, f2
	add.d f4, f4, f3
	
	;;Step 2: norm is stored in f4. Now reduce the coeff to zero 
	;;First store the zeroth position
	l.d f5, sample(r0)
	s.d f5, result(r0)
	
	daddi r7, r0, 0 ;;Set it to point to zeroth position of sample since for position 1 we need 0, 1, 2 for calculating
	dadd r6, r0, r4 ;; r6 = Number of sample
	daddi r6, r6, -2 ;; As we wont be considering first and last one
outer_loop:	
	
	daddi r10, r7, 0
	l.d f6, sample(r10)
	daddi r10, r10, 8
	l.d f7, sample(r10)
	daddi r10, r10, 8
	l.d f8, sample(r10)
	mul.d f9, f1, f6
	mul.d f10, f2, f7
	mul.d f11, f3, f8
	add.d f5, f9, f10
	add.d f5, f5, f11
	
	div.d f5, f5, f4 ;;result /= norm;
	daddi r7, r7, 8
	s.d f5, result(r7)
	daddi r6, r6, -1
	bnez r6, outer_loop
	;;Store the n-1th position
	daddi r7, r7, 8
	l.d f4, sample(r7)
	s.d f4, result(r7)
	
	
exit:
	halt