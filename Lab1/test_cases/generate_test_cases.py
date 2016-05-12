import random
import os


NUM_OF_TEST_CASES = 20
def generate_random_input(filename_c, filename_asm):
	file_c = open(filename_c, 'w')
	file_asm = open(filename_asm, 'w')
	file_c.write(str(NUM_OF_TEST_CASES)+'\n')
	file_asm.write(str(NUM_OF_TEST_CASES)+'\n')

	for i in range (0, NUM_OF_TEST_CASES):
		file_asm.write("\t\t\tTest Case: " +str(i)+'\n')
		file_asm.write("N_COEFFS:   .word 3\n")
		file_c.write('3\n')
		str_input = "coeff: 		.double"
		for i in range(0, 3):
			#Generate random number in the range of (-1, 1)
			rand_value = random.randint(-10, 10)
			if i != 0:
				str_input += ','
			str_input += ' ' + str(rand_value/10.0)
			file_c.write(str(rand_value) + ' ')
		str_input += '\n'
		file_asm.write(str_input)
		file_c.write('\n')
		str_input = "N_SAMPLES: .word "
		num_samples = random.randint(0,99)
		str_input += str(num_samples) + '\n'
		file_asm.write(str_input)
		file_c.write(str(num_samples) + '\n')
		str_input = "sample:	.double"
		for i in range(0, num_samples):
			rand_value = random.randint(0, 100)
			if i != 0:
				str_input += ','
			str_input += ' ' + str(rand_value)
			file_c.write(str(rand_value) + ' ')
		file_asm.write(str_input+'\n')
		file_c.write('\n')
		str_input = "result:		.double"
		for i in range(0, num_samples):
			if i != 0:
				str_input += ','
			str_input += ' 0'
		file_asm.write(str_input)
		file_asm.write('\n\n')

	file_asm.close()
	file_c.close()

def run_c_program():
	f=os.popen("./exec")


if __name__ == '__main__':
	filename_c = "test_input.txt"
	filename_asm = "test_input_asm.txt"
	generate_random_input(filename_c, filename_asm)
