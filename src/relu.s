.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
	# Prologue
	li t0,1
	blt a1,t0,error
	li t0,0
loop_start:
	bge t0,a1,loop_end
	slli t2,t0,2
	add t3,t2,a0
	lw t4,0(t3)
	bge t4,x0,loop_continue
	sw x0,0(t3)
loop_continue:
	addi t0,t0,1
	j loop_start
loop_end:
	# Epilogue
	ret
error:
	li a0 36
	jal exit
