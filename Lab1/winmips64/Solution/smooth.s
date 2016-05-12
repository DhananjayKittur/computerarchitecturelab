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
	dadd r6, r0, r5 ;; Number of sample
	daddi r7, r0, 0
	;;Set f1 to zero
	mov.d f1, f0 ;; Set f4 to zero

add_coeff:
	;; TODO: Check whether the coefficients are negative
	l.d f3, coeff(r7)
	add.d f1, f1, f3
	daddi r7, r7, 8
	daddi r6, r6, -1
	bnez r6, add_coeff
	
	;;Step 2: norm is stored in f1. Now reduce the coeff to zero 
	;;First store the zeroth position
	l.d f4, sample(r0)
	s.d f4, result(r0)
	
	daddi r7, r0, 8 ;;Set it to point to first position of sample not the zeroth however since we are calculating from n-1 to n+1th point it to n-1.
	dadd r6, r0, r4 ;; r6 = Number of sample
	daddi r6, r6, -2 ;; As we wont be considering first and last one
outer_loop:	
	mov.d f4, f0 ;; Set f4 to zero
	
	daddi r8, r0, 0 ;; Set it to zero
	dadd r9, r0, r5 ;; r9 = Number of COEFFICIENTS
	daddi r10, r7, -8
inner_loop:	
	l.d f5, sample(r10) ;;Load the current sample under consideration
	l.d f6, coeff(r8)
	mul.d f7, f6, f5
	add.d f4, f4, f7
	daddi r10, r10, 8
	daddi r8, r8, 8
	daddi r9, r9, -1
	bnez r9, inner_loop
	
	div.d f4, f4, f1 ;;result /= norm;
	s.d f4, result(r7)
	daddi r7, r7, 8
	daddi r6, r6, -1
	bnez r6, outer_loop
	;;Store the n-1th position
	l.d f4, sample(r7)
	s.d f4, result(r7)
	
	
exit:
	halt