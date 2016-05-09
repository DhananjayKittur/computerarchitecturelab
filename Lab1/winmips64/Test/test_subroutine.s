	.data
num1: .word 20
num2: .word 70
result: .word 0
;;Parameter will be passed in rxx and return value will be stored in r10

		.text
	ld r4, num1(r0)
	ld r5, num2(r0)
	daddi r29, r0, 0x80
	jal add_func
	sd r10, result(r0)
	halt
	
	
add_func:
	sd r31, (r29)
	daddi r29, r29, 8
	sd r4, (r29)
	daddi r29, r29, 8
	sd r5, (r29)
	daddi r29, r29, 8
	dadd r10, r4, r5
	daddi r29, r29, -8
	ld r5, (r29)
	daddi r29, r29, -8
	ld r4, (r29)
	daddi r29, r29, -8
	ld r31, 0(r29)
	jr r31
	
	