.data
        # var = 11
var:
        .word 12
x:
        .word 5
y:
        .word 7
# reserve 4 bytes
quot:
        .space 4
# reserve 4 bytes
rema:
        .space 4
message:
        .asciiz "GOOD\n"
nl:
        .asciiz "\n"

.text

main:
        # print_int(var)
        li $v0 1      # load immediate, syscall 1
        lw $a0 var      # load word, first argument
        syscall

        # print_string(nl)
        li $v0 4
        la $a0 nl
        syscall

        # quot = var / 4
        lw $a1 var
        li $a2 4
        divu $a0 $a1 $a2

        sw $a0 quot

        # print_int(quot)
        li $v0 1
        lw $a0 quot
        syscall

        # print_string(nl)
        li $v0 4
        la $a0 nl
        syscall

        # rem = var mod 4
        lw $a1 var
        li $a2 4
        divu $a1 $a2

        # move from hi register (remainder); lo - quotient
        mfhi $a0

        sw $a0 rema

        # print_int(rem)
        li $v0 1
        lw $a0 rema
        syscall

        # print_string(nl)
        li $v0 4
        la $a0 nl
        syscall

        # if (rem == 3)
if_start:
        lw $a0 rema
        li $a1 3
        bne $a0 $a1 if_end
        #       print_string("GOOD")
then_branch:
        li $v0 4
        la $a0 message
        syscall
if_end:

        # swap x and y using the stack
        # push x
        lw $a0 x
        sw $a0 0($sp)
        addiu $sp $sp -4
        # push y
        lw $a0 y
        sw $a0 0($sp)
        addiu $sp $sp -4
        # pop x
        lw $a0 4($sp)
        addiu $sp $sp 4
        sw $a0 x
        # pop y
        addiu $sp $sp 4
        lw $a0 0($sp)
        sw $a0 y

        # print_int(x)
        li $v0 1
        lw $a0 x
        syscall

        # print_string(nl)
        li $v0 4
        la $a0 nl
        syscall

        # print_int(y)
        li $v0 1
        lw $a0 y
        syscall

        # print_string(nl)
        li $v0 4
        la $a0 nl
        syscall

        # while (cond)
        #       smth
        #
        # while_start:
        #       b<!cond> while_end
        #       smth
        # while_end:

        # V1 - exit
        # li $v0 10
        # syscall
        
        # V2 - "ret"
        jr $ra # jump register, ra - return address
