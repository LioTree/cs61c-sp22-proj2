.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
	# Prologue
	li t0,1
	blt a1,t0,error # size < 1?
	li t0,0 # i = 0
	li t5,0 # max_index=0
	lw t6,0(a0) # max = a0[0]
loop_start:
	bge t0,a1,loop_end # foreach over?
	slli t2,t0,2
	add t3,t2,a0
	lw t4,0(t3) # get element of a0
	blt t4,t6,loop_continue
	beq t4,t6,loop_continue
	add t5,x0,t0
	add t6,x0,t4
loop_continue:
    addi t0,t0,1 # i++
	j loop_start
loop_end:
	# Epilogue
	add a0,x0,t5
	ret
error:
	li a0 36
	jal exit
