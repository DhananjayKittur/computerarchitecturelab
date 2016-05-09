	.data
coeff: .word 1, 2, 3, 4
result: .word 0, 0, 0, 0
NUM_COEFF: .word 4
initial_mult_value: .word 0
	.text
	ld r4, NUM_COEFF(r0)
	ld r6, initial_mult_value(r0)
	;Initialize the register with zero somehow
start_add: 
	ld r5, coeff(r6)
	sd r5, result(r6)
	daddi r6, r6, 8
	daddi r4, r4, -1
	bnez r4, start_add
	
halt