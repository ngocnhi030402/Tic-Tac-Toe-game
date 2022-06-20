.data
	msg3:			.asciiz "\nPLAYER CANNOT CHOOSE THE CENTRAL POINT (POINT 13)IN THE FIRST CHOICE"
	msg7:			.asciiz "\nPLEASE ENTER ANOTHER POINT: "
	game:			.asciiz "\n---GAME TICTACTOE START ---\n"
	rule:			.asciiz "\n#######################################\n#THE BOARD IS NUMBERIZED FROM 1 TO 25,#\n#    LEFT TO RIGHT, TOP TO BOTTOM     #\n#    PlayerX will be the first player #\n#######################################\n"				    
	newLine: 		.asciiz "\n"
	Xturn:			.asciiz "\nIt's playerX's turn"
	Oturn:			.asciiz "\nIt's playerO's turn"
	xwin:			.asciiz "\nPlayer X win"
	owin:			.asciiz "\nPlayer O win"
	draw:			.asciiz "\nIt's a draw"
	playerXEnterPoint: 	.asciiz "\nPlayer X please enter a point: "
	playerOEnterPoint: 	.asciiz "\nPlayer O please enter a point: "
	invalid:		.asciiz "\nInvalid move, please enter again: "
	same:			.asciiz "\nThis point has already been chosen, please enter another point: "	
	notundo:		.asciiz "\nYou cannot undo! You havent entered any point!"
	theend:		.asciiz "\n#####THE END#####\n"
	banco: 		.asciiz "\n | | | | \n-+-+-+-+-\n | | | | \n-+-+-+-+-\n | | | | \n-+-+-+-+-\n | | | | \n-+-+-+-+-\n | | | | \n"
	banco2: 		.asciiz "\n 1| 2| 3| 4| 5\n--+--+--+--+--\n 6| 7| 8| 9|10\n--+--+--+--+--\n11|12|13|14|15\n--+--+--+--+--\n16|17|18|19|20\n--+--+--+--+--\n21|22|23|24|25\n"
	undoMsg:		.asciiz "\nDo you want to undo your last choice? Type 1(if yes) or any number(if no): "
	arrx: 			.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	X: 			.asciiz "X"
	O: 			.asciiz "O"
	space:			.byte ' '
	again: 		.asciiz "\n Do you want to play again? Type 1(if yes) or any number(if no):  "
.text
main:
first:
	addi $t1, $zero, 0 #count = 0, when count = 25 -> stop playing -> draw
	addi $t0, $zero, 0 #count turn, if countturn is even -> X's turn, else Y's turn
	addi $t2, $zero, 0 #count for array
	addi $t3, $zero, 0 #count for undofunc
	addi $s1, $zero, 0 #check central point
	addi $t5, $zero, 0 
	la $s7, arrx
	lb $s6, space
	la $a2, banco
	la $s2, owin
	la $s3, xwin

	sb $s6, 1($a2)
	sb $s6, 3($a2)
	sb $s6, 5($a2)
	sb $s6, 7($a2)
	sb $s6, 9($a2)
	sb $s6, 21($a2)
	sb $s6, 23($a2)
	sb $s6, 25($a2)
	sb $s6, 27($a2)
	sb $s6, 29($a2)
	sb $s6, 41($a2)
	sb $s6, 43($a2)
	sb $s6, 45($a2)
	sb $s6, 47($a2)
	sb $s6, 49($a2)
	sb $s6, 61($a2)
	sb $s6, 63($a2)
	sb $s6, 65($a2)
	sb $s6, 67($a2)
	sb $s6, 69($a2)
	sb $s6, 81($a2)
	sb $s6, 83($a2)
	sb $s6, 85($a2)
	sb $s6, 87($a2)
	sb $s6, 89($a2)

	sb $t2, 0($s7)
	sb $t2, 4($s7)
	sb $t2, 8($s7)
	sb $t2, 12($s7)
	sb $t2, 16($s7)
	sb $t2, 20($s7)
	sb $t2, 24($s7)
	sb $t2, 28($s7)
	sb $t2, 32($s7)
	sb $t2, 36($s7)
	sb $t2, 40($s7)
	sb $t2, 44($s7)
	sb $t2, 48($s7)
	sb $t2, 52($s7)
	sb $t2, 56($s7)
	sb $t2, 60($s7)
	sb $t2, 64($s7)
	sb $t2, 68($s7)
	sb $t2, 72($s7)
	sb $t2, 76($s7)
	sb $t2, 80($s7)
	sb $t2, 84($s7)
	sb $t2, 88($s7)
	sb $t2, 92($s7)
	sb $t2, 96($s7)
end:
	#print game start
	li $v0, 4
	la $a0, game
	syscall
	li $v0, 4
	la $a0, rule
	syscall
	
print:
	li $v0,4
	la $a0, banco2
	syscall
	#print board
	li $v0, 4
	la $a0, banco
	syscall
	
	beq $t1, 25, drawfun
	addi $t1, $t1, 1
	
	rem $t2, $t0, 2 #remainder of t0 / 2
	addi $t0, $t0, 1
	
	undo:
		#print undo
		li $v0, 4
		la $a0, undoMsg
		syscall
		#read 1 or 0
		li $v0, 5
		syscall
		move $s1, $v0
		
		beq $s1, 1, undofunc
	turn:
	beq $t2, 0, xturn #if t2 = 0 -> go to xturn 
	bne $t2, 0, oturn #if t2 != 0 -> go to oturn
	#j ask
	
xturn: 
	lb $a1, X
	#print player's turn
	li $v0, 4
	la $a0, Xturn
	syscall
	#print playerXEnterPoint 
	li $v0, 4
	la $a0, playerXEnterPoint
	syscall
	#read integer
	li $v0, 5
	syscall
	move $s0, $v0 #save $v0
	j tictactoe
	
oturn:
	lb $a1, O
	#print Oturn
	li $v0, 4
	la $a0, Oturn
	syscall
	#print playerOEnterPoint 
	li $v0, 4
	la $a0, playerOEnterPoint
	syscall
	#read integer
	li $v0, 5
	syscall
	move $s0, $v0 #save $v0
	
	j tictactoe
	
tictactoe:
	#check central point
	seq $t3, $t1, 1
	seq $t4, $s0, 13
	and $t5, $t3, $t4
	bne $t5, 0, checkcentralpoint
	
	seq $t3, $t1, 2
	seq $t4, $s0, 13
	and $t5, $t3, $t4
	bne $t5, 0, checkcentralpoint
	
	#j print
	beq $s0, 1, point1
	beq $s0, 2, point2
	beq $s0, 3, point3
	beq $s0, 4, point4
	beq $s0, 5, point5
	beq $s0, 6, point6
	beq $s0, 7, point7
	beq $s0, 8, point8
	beq $s0, 9, point9
	beq $s0, 10, point10
	beq $s0, 11, point11
	beq $s0, 12, point12
	beq $s0, 13, point13
	beq $s0, 14, point14
	beq $s0, 15, point15
	beq $s0, 16, point16
	beq $s0, 17, point17
	beq $s0, 18, point18
	beq $s0, 19, point19
	beq $s0, 20, point20
	beq $s0, 21, point21
	beq $s0, 22, point22
	beq $s0, 23, point23
	beq $s0, 24, point24
	beq $s0, 25, point25
	
	li $v0, 4
	la $a0, invalid
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	j tictactoe
	
undofunc:
	
	beq $t1, 1, cannotundo
	beq $t1, 2 cannotundo
	beq $s0, 1, undo1
	beq $s0, 2, undo2
	beq $s0, 3, undo3
	beq $s0, 4, undo4
	beq $s0, 5, undo5
	beq $s0, 6, undo6
	beq $s0, 7, undo7
	beq $s0, 8, undo8
	beq $s0, 9, undo9
	beq $s0, 10, undo10
	beq $s0, 11, undo11
	beq $s0, 12, undo12
	beq $s0, 13, undo13
	beq $s0, 14, undo14
	beq $s0, 15, undo15
	beq $s0, 16, undo16
	beq $s0, 17, undo17
	beq $s0, 18, undo18
	beq $s0, 19, undo19
	beq $s0, 20, undo20
	beq $s0, 21, undo21
	beq $s0, 22, undo22
	beq $s0, 23, undo23
	beq $s0, 24, undo24
	beq $s0, 25, undo25
	
printboardundo:
	li $v0, 4
	la $a0, banco2
	syscall
	#print board
	li $v0, 4
	la $a0, banco
	syscall
	rem $t2, $t0, 2 #remainder of t0 / 2
	addi $t0, $t0, 1
	beq $t2, 0, xturn #if t2 = 0 -> go to xturn 
	bne $t2, 0, oturn #if t2 != 0 -> go to oturn
	
cannotundo:
	li $v0, 4
	la $a0, notundo
	syscall
	move $s0, $v0
	j turn
	
undo1:
	li $t2, 0
	sb $s6, 1($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 0($s7)
	j printboardundo
undo2:
	li $t2, 0
	sb $s6, 3($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 4($s7)
	j printboardundo
undo3:
	li $t2, 0
	sb $s6, 5($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 8($s7)
	j printboardundo
undo4:
	li $t2, 0
	sb $s6, 7($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 12($s7)
	j printboardundo
undo5:
	li $t2, 0
	sb $s6, 9($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 16($s7)
	j printboardundo
undo6:
	li $t2, 0
	sb $s6, 21($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 20($s7)
	j printboardundo
undo7:
	li $t2, 0
	sb $s6, 23($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 24($s7)
	j printboardundo
undo8:
	li $t2, 0
	sb $s6, 25($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 28($s7)
	j printboardundo
undo9:
	li $t2, 0
	sb $s6, 27($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 32($s7)
	j printboardundo
undo10:
	li $t2, 0
	sb $s6, 29($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 36($s7)
	j printboardundo
undo11:
	li $t2, 0
	sb $s6, 41($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 40($s7)
	j printboardundo
undo12:
	li $t2, 0
	sb $s6, 43($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 44($s7)
	j printboardundo
undo13:
	li $t2, 0
	sb $s6, 45($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 48($s7)
	j printboardundo
undo14:
	li $t2, 0
	sb $s6, 47($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 52($s7)
	j printboardundo
undo15:
	li $t2, 0
	sb $s6, 49($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 56($s7)
	j printboardundo
undo16:
	li $t2, 0
	sb $s6, 61($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 60($s7)
	j printboardundo
undo17:
	li $t2, 0
	sb $s6, 63($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 64($s7)
	j printboardundo
undo18:
	li $t2, 0
	sb $s6, 65($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 68($s7)
	j printboardundo
undo19:
	li $t2, 0
	sb $s6, 67($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 72($s7)
	j printboardundo
undo20:
	li $t2, 0
	sb $s6, 69($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 76($s7)
	j printboardundo
undo21:
	li $t2, 0
	sb $s6, 81($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 80($s7)
	j printboardundo
undo22:
	li $t2, 0
	sb $s6, 83($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 84($s7)
	j printboardundo
undo23:
	li $t2, 0
	sb $s6, 85($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 88($s7)
	j printboardundo
undo24:
	li $t2, 0
	sb $s6, 87($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 92($s7)
	j printboardundo
undo25:
	li $t2, 0
	sb $s6, 89($a2)
	subi $t1, $t1, 1 #count--
	sb $t2, 96($s7)
	j printboardundo

point1:
	lw $t4, 0($s7)
	
	bne $t4, 0, samePoint 
	beq $t2, 0, xturnpoint1
	bne $t2, 0, oturnpoint1	
	xturnpoint1:
		li $t3, 1
		sb $t3, 0($s7) #put t1 into array
		sb $a1, 1($a2) #x
		j checknprint		
	oturnpoint1:
		li $t3, 2
		sb $t3, 0($s7)
		sb $a1, 1($a2) #o
		j checknprint			
point2:
	lw $t4, 4($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint2
	bne $t2, 0, oturnpoint2	
	xturnpoint2:
		li $t3, 1
		sb $t3, 4($s7)
		sb $a1, 3($a2) #x
		j checknprint		
	oturnpoint2:
		li $t3, 2
		sb $t3, 4($s7)
		sb $a1, 3($a2) #o
		j checknprint
point3:
	lw $t4, 8($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint3
	bne $t2, 0, oturnpoint3	
	xturnpoint3:
		li $t3, 1
		sb $t3, 8($s7)
		sb $a1, 5($a2) #x
		j checknprint		
	oturnpoint3:
		li $t3, 2
		sb $t3, 8($s7)
		sb $a1, 5($a2) #o
		j checknprint

point4:
	lw $t4, 12($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint4
	bne $t2, 0, oturnpoint4
	xturnpoint4:
		li $t3, 1
		sb $t3, 12($s7)
		sb $a1, 7($a2) #x
		j checknprint		
	oturnpoint4:
		li $t3, 2
		sb $t3, 12($s7)
		sb $a1, 7($a2) #o
		j checknprint
point5:
	lw $t4, 16($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint5
	bne $t2, 0, oturnpoint5	
	xturnpoint5:
		li $t3, 1
		sb $t3, 16($s7)
		sb $a1, 9($a2) #x
		j checknprint		
	oturnpoint5:
		li $t3, 2
		sb $t3, 16($s7)
		sb $a1, 9($a2) #o
		j checknprint
point6:
	lw $t4, 20($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint6
	bne $t2, 0, oturnpoint6	
	xturnpoint6:
		li $t3, 1
		sb $t3, 20($s7)
		sb $a1, 21($a2) #x
		j checknprint		
	oturnpoint6:
		li $t3, 2
		sb $t3, 20($s7)
		sb $a1, 21($a2) #o
		j checknprint
point7:
	lw $t4, 24($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint7
	bne $t2, 0, oturnpoint7	
	xturnpoint7:
		li $t3, 1
		sb $t3, 24($s7)
		sb $a1, 23($a2) #x
		j checknprint		
	oturnpoint7:
		li $t3, 2
		sb $t3, 24($s7)
		sb $a1, 23($a2) #o
		j checknprint
point8:
	lw $t4, 28($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint8
	bne $t2, 0, oturnpoint8	
	xturnpoint8:
		li $t3, 1
		sb $t3, 28($s7)
		sb $a1, 25($a2) #x
		j checknprint		
	oturnpoint8:
		li $t3, 2
		sb $t3, 28($s7)
		sb $a1, 25($a2) #o
		j checknprint
point9:
	lw $t4, 32($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint9
	bne $t2, 0, oturnpoint9	
	xturnpoint9:
		li $t3, 1
		sb $t3, 32($s7)
		sb $a1, 27($a2) #x
		j checknprint		
	oturnpoint9:
		li $t3, 2
		sb $t3, 32($s7)
		sb $a1, 27($a2) #o
		j checknprint
point10:
	lw $t4, 36($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint10
	bne $t2, 0, oturnpoint10	
	xturnpoint10:
		li $t3, 1
		sb $t3, 36($s7)
		sb $a1, 29($a2) #x
		j checknprint	
	oturnpoint10:
		li $t3, 2
		sb $t3, 36($s7)
		sb $a1, 29($a2) #o
		j checknprint
point11:
	lw $t4, 40($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint11
	bne $t2, 0, oturnpoint11	
	xturnpoint11:
		li $t3, 1
		sb $t3, 40($s7)
		sb $a1, 41($a2) #x
		j checknprint		
	oturnpoint11:
		li $t3, 2
		sb $t3, 40($s7)
		sb $a1, 41($a2) #o
		j checknprint
point12:
	lw $t4, 44($s7)	
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint12
	bne $t2, 0, oturnpoint12
	xturnpoint12:
		li $t3, 1
		sb $t3, 44($s7)
		sb $a1, 43($a2) #x
		j checknprint
	oturnpoint12:
		li $t3, 2
		sb $t3, 44($s7)
		sb $a1, 43($a2) #o
		j checknprint
point13:
	lw $t4, 48($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint13
	bne $t2, 0, oturnpoint13
	xturnpoint13:
		li $t3, 1
		sb $t3, 48($s7)
		sb $a1, 45($a2) #x
		j checknprint
	oturnpoint13:
		li $t3, 2
		sb $t3, 48($s7)
		sb $a1, 45($a2) #o
		j checknprint
point14:
	lw $t4, 52($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint14
	bne $t2, 0, oturnpoint14
	xturnpoint14:
		li $t3, 1
		sb $t3, 52($s7)
		sb $a1, 47($a2) #x
		j checknprint
	oturnpoint14:
		li $t3, 2
		sb $t3, 52($s7)
		sb $a1, 47($a2) #o
		j checknprint
point15:
	lw $t4, 56($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint15
	bne $t2, 0, oturnpoint15
	xturnpoint15:
		li $t3, 1
		sb $t3, 56($s7)
		sb $a1, 49($a2) #x
		j checknprint	
	oturnpoint15:
		li $t3, 2
		sb $t3, 56($s7)
		sb $a1, 49($a2) #o
		j checknprint
point16:
	lw $t4, 60($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint16
	bne $t2, 0, oturnpoint16
	xturnpoint16:
		li $t3, 1
		sb $t3, 60($s7)
		sb $a1, 61($a2) #x
		j checknprint	
	oturnpoint16:
		li $t3, 2
		sb $t3, 60($s7)
		sb $a1, 61($a2) #o
		j checknprint
point17:
	lw $t4, 64($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint17
	bne $t2, 0, oturnpoint17
	xturnpoint17:
		li $t3, 1
		sb $t3, 64($s7)
		sb $a1, 63($a2) #x
		j checknprint	
	oturnpoint17:
		li $t3, 2
		sb $t3, 64($s7)
		sb $a1, 63($a2) #o
		j checknprint
point18:
	lw $t4, 68($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint18
	bne $t2, 0, oturnpoint18
	xturnpoint18:
		li $t3, 1
		sb $t3, 68($s7)
		sb $a1, 65($a2) #x
		j checknprint	
	oturnpoint18:
		li $t3, 2
		sb $t3, 68($s7)
		sb $a1, 65($a2) #o
		j checknprint
point19:
	lw $t4, 72($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint19
	bne $t2, 0, oturnpoint19
	xturnpoint19:
		li $t3, 1
		sb $t3, 72($s7)
		sb $a1, 67($a2) #x
		j checknprint	
	oturnpoint19:
		li $t3, 2
		sb $t3, 72($s7)
		sb $a1, 67($a2) #o
		j checknprint
point20:
	lw $t4, 76($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint20
	bne $t2, 0, oturnpoint20
	xturnpoint20:
		li $t3, 1
		sb $t3, 76($s7)
		sb $a1, 69($a2) #x
		j checknprint	
	oturnpoint20:
		li $t3, 2
		sb $t3, 76($s7)
		sb $a1, 69($a2) #o
		j checknprint
point21:
	lw $t4, 80($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint21
	bne $t2, 0, oturnpoint21
	xturnpoint21:
		li $t3, 1
		sb $t3, 80($s7)
		sb $a1, 81($a2) #x
		j checknprint	
	oturnpoint21:
		li $t3, 2
		sb $t3, 80($s7)
		sb $a1, 81($a2) #o
		j checknprint
point22:
	lw $t4, 84($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint22
	bne $t2, 0, oturnpoint22
	xturnpoint22:
		li $t3, 1
		sb $t3, 84($s7)
		sb $a1, 83($a2) #x
		j checknprint	
	oturnpoint22:
		li $t3, 2
		sb $t3, 84($s7)
		sb $a1, 83($a2) #o
		j checknprint
point23:
	lw $t4, 88($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint23
	bne $t2, 0, oturnpoint23
	xturnpoint23:
		li $t3, 1
		sb $t3, 88($s7)
		sb $a1, 85($a2) #x
		j checknprint	
	oturnpoint23:
		li $t3, 2
		sb $t3, 88($s7)
		sb $a1, 85($a2) #o
		j checknprint
point24:
	lw $t4, 92($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint24
	bne $t2, 0, oturnpoint24
	xturnpoint24:
		li $t3, 1
		sb $t3, 92($s7)
		sb $a1, 87($a2) #x
		j checknprint	
	oturnpoint24:
		li $t3, 2
		sb $t3, 92($s7)
		sb $a1, 87($a2) #o
		j checknprint
point25:
	lw $t4, 96($s7)
	bne $t4, 0, samePoint
	beq $t2, 0, xturnpoint25
	bne $t2, 0, oturnpoint25
	xturnpoint25:
		li $t3, 1
		sb $t3, 96($s7)
		sb $a1, 89($a2) #x
		j checknprint	
	oturnpoint25:
		li $t3, 2
		sb $t3, 96($s7)
		sb $a1, 89($a2) #o
		j checknprint

samePoint:
	#print 
	li $v0, 4
	la $a0, same
	syscall
	#input another point
	li $v0, 5
	syscall
	move $s0, $v0
	j tictactoe
checkcentralpoint:
	li $v0, 4
	la $a0, msg3
	syscall	
	li $v0, 4
	la $a0, msg7
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	j tictactoe
checknprint:
	#ngang
	#1
	lb $t7, 0($s7)
	lb $t6, 4($s7)
	lb $t5, 8($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#2
	lb $t7, 4($s7)
	lb $t6, 8($s7)
	lb $t5, 12($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#3
	lb $t7, 8($s7)
	lb $t6, 12($s7)
	lb $t5, 16($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#4
	lb $t7, 20($s7)
	lb $t6, 24($s7)
	lb $t5, 28($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#5
	lb $t7, 24($s7)
	lb $t6, 28($s7)
	lb $t5, 32($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#6
	lb $t7, 28($s7)
	lb $t6, 32($s7)
	lb $t5, 36($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#7
	lb $t7, 40($s7)
	lb $t6, 44($s7)
	lb $t5, 48($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#8
	lb $t7, 44($s7)
	lb $t6, 48($s7)
	lb $t5, 52($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#9
	lb $t7, 48($s7)
	lb $t6, 52($s7)
	lb $t5, 56($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#10
	lb $t7, 60($s7)
	lb $t6, 64($s7)
	lb $t5, 68($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#11
	lb $t7, 64($s7)
	lb $t6, 68($s7)
	lb $t5, 72($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#12
	lb $t7, 68($s7)
	lb $t6, 72($s7)
	lb $t5, 76($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#13
	lb $t7, 80($s7)
	lb $t6, 84($s7)
	lb $t5, 88($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#14
	lb $t7, 84($s7)
	lb $t6, 88($s7)
	lb $t5, 92($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#15
	lb $t7, 88($s7)
	lb $t6, 92($s7)
	lb $t5, 96($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	
	#doc
	#1
	lb $t7, 0($s7)
	lb $t6, 20($s7)
	lb $t5, 40($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#2
	lb $t7, 20($s7)
	lb $t6, 40($s7)
	lb $t5, 60($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#3
	lb $t7, 40($s7)
	lb $t6, 60($s7)
	lb $t5, 80($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#4
	lb $t7, 4($s7)
	lb $t6, 24($s7)
	lb $t5, 44($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#5
	lb $t7, 24($s7)
	lb $t6, 44($s7)
	lb $t5, 64($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#6
	lb $t7, 44($s7)
	lb $t6, 64($s7)
	lb $t5, 84($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#7
	lb $t7, 8($s7)
	lb $t6, 18($s7)
	lb $t5, 48($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#8
	lb $t7, 18($s7)
	lb $t6, 48($s7)
	lb $t5, 68($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#9
	lb $t7, 48($s7)
	lb $t6, 68($s7)
	lb $t5, 88($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#10
	lb $t7, 12($s7)
	lb $t6, 32($s7)
	lb $t5, 52($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#11
	lb $t7, 32($s7)
	lb $t6, 52($s7)
	lb $t5, 72($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#12
	lb $t7, 52($s7)
	lb $t6, 72($s7)
	lb $t5, 92($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#13
	lb $t7, 16($s7)
	lb $t6, 36($s7)
	lb $t5, 56($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#14
	lb $t7, 36($s7)
	lb $t6, 56($s7)
	lb $t5, 76($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#15
	lb $t7, 56($s7)
	lb $t6, 76($s7)
	lb $t5, 96($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	
	#cheo
	#1
	lb $t7, 8($s7)
	lb $t6, 24($s7)
	lb $t5, 40($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#2
	lb $t7, 12($s7)
	lb $t6, 28($s7)
	lb $t5, 44($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#3
	lb $t7, 28($s7)
	lb $t6, 44($s7)
	lb $t5, 60($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#4
	lb $t7, 16($s7)
	lb $t6, 32($s7)
	lb $t5, 48($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#5
	lb $t7, 32($s7)
	lb $t6, 48($s7)
	lb $t5, 64($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#6
	lb $t7, 48($s7)
	lb $t6, 64($s7)
	lb $t5, 80($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#7
	lb $t7, 36($s7)
	lb $t6, 52($s7)
	lb $t5, 68($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#8
	lb $t7, 52($s7)
	lb $t6, 68($s7)
	lb $t5, 84($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#9
	lb $t7, 56($s7)
	lb $t6, 72($s7)
	lb $t5, 88($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#10
	lb $t7, 8($s7)
	lb $t6, 32($s7)
	lb $t5, 56($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#11
	lb $t7, 4($s7)
	lb $t6, 18($s7)
	lb $t5, 52($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#12
	lb $t7, 18($s7)
	lb $t6, 52($s7)
	lb $t5, 76($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#13
	lb $t7, 0($s7)
	lb $t6, 24($s7)
	lb $t5, 48($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#14
	lb $t7, 24($s7)
	lb $t6, 48($s7)
	lb $t5, 72($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#15
	lb $t7, 48($s7)
	lb $t6, 72($s7)
	lb $t5, 96($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#16
	lb $t7, 20($s7)
	lb $t6, 44($s7)
	lb $t5, 68($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#17
	lb $t7, 44($s7)
	lb $t6, 68($s7)
	lb $t5, 92($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	#18
	lb $t7, 40($s7)
	lb $t6, 64($s7)
	lb $t5, 88($s7)
	and $s5, $t7, $t6
	and $s5, $s5, $t5
	bne $s5, 0, win
	
	j print
win:
	li $v0, 4
	la $a0, banco2
	syscall
	li $v0, 4
	la $a0, banco
	syscall
	#print win
	beq $t2, 0, printxwin
	bne $t2, 0, printowin
	printxwin:
		li $v0, 4
		la $a0, xwin
		syscall
		j exit
	printowin:
		li $v0, 4
		la $a0, owin
		syscall
		j exit
drawfun:
	li $v0, 4
	la $a0, draw
	syscall	
exit:
	li $v0, 4
	la $a0, again
	syscall
	li $v0, 5
	syscall
	move $t5, $v0
	beq $t5, 1, first
	bne $t5, 1, exitt
exitt:
	#exit program
	li $v0, 10
	syscall
