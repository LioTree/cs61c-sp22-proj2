.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
	# Prologue
	# check whether the length of the array is less than 1
	li t0,1
	blt a2,t0,error36
	blt a3,t0,error37
	blt a4,t0,error37
	li t0,0 # i = 0
	li t1,0 # j = 0
	li t3,0 # result = 0
loop_start:
	bge t0,a2,loop_end # i < a2?
	slli t4,t0,2
	add t4,t4,a0 # get &(a0[i])
	lw t5,0(t4) # get value of a0[i]

	slli t4,t1,2
	add t4,t4,a1 # get &(a1[j])
	lw t6,0(t4) # get value of a1[j]

	mul t6,t5,t6
	add t3,t3,t6

	add t0,t0,a3 # i += a3
	add t1,t1,a4 # j += a4
	j loop_start
loop_end:
	# Epilogue
	add a0,x0,t3
	ret
error36:
	li a0,36
	jal exit
error37:
	li a0,37
	jal exit
