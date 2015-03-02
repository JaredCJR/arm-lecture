	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW

	ldr r1 , =locked		@set r1 locked
.lock_once:
	ldrex r2,[r0]			@read the current status
	cmp r2 , #0			@if current status is unlocked
		strexeq r2,r1,[r0]	@set current status(r0) to be locked
		cmpeq r2 , #0		@r2 is the condition for set lock;success -> r2==0
		bne .lock_once		@fail to lock -> again

        @ END CODE INSERT
	bx lr				@return

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW

	ldr r1 , =unlocked		@set r1 to be unlocked
	str r1 , [r0]			@set current status to be unlocked
	bx lr				@return

        @ END CODE INSERT
	.size unlock_mutex, .-unlock_mutex

	.end
