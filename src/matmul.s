.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:
	addi sp, sp, -44
	sw s0, 32(sp)
	# Error checks
	li t0,1
	blt a1,t0,error38	
	blt a2,t0,error38	
	blt a4,t0,error38	
	blt a5,t0,error38	
	bne a2,a4,error38
	# Prologue
	li t0,0 # initialize the index of rows of m0
	li s0,0 # initialize the index of rows of d
outer_loop_start:
	bge t0,a1,outer_loop_end
	li t1,0 # initialize the index of columns of m1
inner_loop_start:
	bge t1,a5,inner_loop_end
	# store registers
	sw ra, 0(sp)
	sw t0, 4(sp)
	sw t1, 8(sp)
	sw a0, 12(sp)
	sw a1, 16(sp)
	sw a2, 20(sp)
	sw a3, 24(sp)
	sw a4, 28(sp)
	sw a5, 36(sp)
	sw a6, 44(sp)
	# set arguments of dot
	mul t2,a2,t0 
	li t3,4
	mul t2,t2,t3
	add t2,a0,t2 
	add a0,x0,t2 # set the address of current row of m0
	add a2,x0,a2 # set the number of elements to use, which is equal to width of m0

	slli t1,t1,2
	add a1,a3,t1 # set the address of current column of m1
	add a4,x0,a5 # set the stride of m1,which is equal to the width of m1
	addi a3,x0,1 # set the stride of m0, which is always 1

	jal ra,dot
	add t2,x0,a0 # save return value
	# restore registers
	lw ra, 0(sp)
	lw t0, 4(sp)
	lw t1, 8(sp)
	lw a0, 12(sp)
	lw a1, 16(sp)
	lw a2, 20(sp)
	lw a3, 24(sp)
	lw a4, 28(sp)
	lw a5, 36(sp)
	lw a6, 44(sp)
	
	slli t3,s0,2
	add t3,t3,a6
	sw t2,0(t3)

	addi t1,t1,1 # increase the index of columns of m1
	addi s0,s0,1
	j inner_loop_start
inner_loop_end:

	addi t0,t0,1 # increase the index of rows of m0
	j outer_loop_start
outer_loop_end:
	# Epilogue
	lw s0, 32(sp)
	addi sp, sp, 44
	ret
error38:
	li a0,38
	jal exit