.data
gridsize:   .byte 8,8
character:  .byte 0,0
box:        .byte 0,0
target:     .byte 0,0

starting_coordinate_character:	.byte 0,0
starting_coordinate_box:		.byte 0,0
starting_coordinate_target: 	.byte 0,0

prompt: 			.string "Enter a move (w, a, s, d, r): "
prompt_invalid:		.string "Invalid move. \n"
prompt_no_change:	.string "There are no changes made to the board. \n"
prompt_win: 		.string "You have successfully placed the box on the target. \n"
prompt_new_game:	.string "Do you wish to play again? Please enter y or n: "
prompt_end_game: 	.string "Thank you for playing! \n"
prompt_invalid_input:	.string "Invalid input. \n"
prompt_sokoban:			.string "Welcome to the game of SOKOBAN!"
prompt_undo_np: 		.string "No more moves to undo. You have reached the start of this game. \n"
prompt_gamemode: 		.string "CHOOSE A GAME MODE TO BEGIN PLAYING :) \n"
prompt_gamemode1:		.string "(1) Single Player Mode [Enter 1 to continue] \n"
prompt_gamemode2:		.string "(2) Multi Player Mode [Enter 2 to continue] \n"
prompt_welcome_sp:		.string "Welcome to Single Player Mode! Enjoy and have fun! \n"
prompt_welcome_spwcc: 	.string "Welcome to Single Player Cheat Mode! Enjoy and have fun! \n"
prompt_welcome_mp:		.string "Welcome to Multi Player Mode! Enjoy and have fun! \n"
prompt_secret_code: 	.string "Enter the 5 digit secret code: "
prompt_wrong_code:		.string "Wrong code entered! Access Denied. \n"
prompt_cheats_enabled: 	.string "CHEAT CODES HAVE BEEN SUCCESFULLY ENABLED \n"
prompt_reset:			.string "Are you sure you wish to reset? Please enter y or n: "
prompt_num_players: 	.string "Enter the number of players who wish to play: "
prompt_player_name: 	.string "Enter a name for the player [MAX 3 CHARACTERS]: "
prompt_leaderboard:		.string "POSITION   NAME   MOVES\n"
prompt_space1:			.string "   "
prompt_space2:			.string "       "
prompt_space3:			.string "     "
secret_code:			.string "55635"

starting_coordinate_character_mp:	.byte 0,0
starting_coordinate_box_mp:			.byte 0,0
starting_coordinate_target_mp:		.byte 0,0

newline: 			.string "\n"
wall_symbol:		.string "+"
floor_symbol: 		.string "_"
target_symbol: 		.string "X"
box_symbol: 		.string "B"
character_symbol: 	.string "C"

char_W: 			.string "w"
char_A:				.string "a"
char_S: 			.string "s"
char_D: 			.string "d"
char_R:				.string "r"
char_Y:				.string "y"
char_N:				.string "n"
char_U:				.string "u"
char_T:				.string "t"
char_E:				.string "e"
char_I:				.string "i"
char_J:				.string "j"
char_K:				.string "k"
char_L:				.string "l"
char_X: 			.string "x"
char_1:				.string "1"
char_2:				.string "2"

s:  .word 13579246, 24681357, 11223344, 55667788

.align 2
num_players: 			.word 1
player_name:			.word 0

.text
.globl _start

_start:

# CITATION FOR PSEUDO RANDOM NUMBER GENERATOR
# Blackman, D., & Vigna, S. 2019. Xoshiro128++: Pseudorandom number generator. 
# Retrieved from https://prng.di.unimi.it/

   	# TODO: That's the base game! Now, pick a pair of enhancements and
    # consider how to implement them.
	
# ENHANCEMENT 1

# (a) Firstly, I am implementing the multi-player competitive mode where the number
# of players inputted by the player are given a chance to play the same puzzle
# each round. After all players have played, a single leaderboard will display
# each player with their respective moves with the player with the least moves on
# the top of the leaderboard.

# (b) play_mp (Line 3214) is what implements the multi-player competitive mode and
# this calls several helper function. One of the main helper functions is
# play_game_mp (Line 2746)

# (c) In my implementation of the play_mp game mode for Sokoban, the function
# handles the entire gameplay loop by coordinating various helper methods that
# manage player input, movement, collision detection, and game state updates.
# When a player inputs a command (w, a, s, d to move or r to reset), the
# function calls helper methods to validate whether the move is allowed by checking
# if the player or a pushed box would collide with walls or go out of bounds. If the
# player attempts to push a box, the logic ensures that the space ahead is free for
# both the player and the box to move into, preventing invalid moves. Once the
# move is validated, the helper methods update the player’s and box's positions on
# the grid. If the move is invalid, appropriate feedback is provided, ensuring a
# smooth experience for the player. The game keeps checking for win conditions by
# using helper methods that confirm whether the box has reached the target
# position, triggering a win message if the objective is completed. This structure
# ensures that the core gameplay runs efficiently, with input handling, movement
# logic, and win condition checks all modularized for easy maintenance and clear
# code organization.

# ENHANCEMENT 2

# (a) Secondly, I am implementing the single-player cheat mode where the player is
# able to use cheat modes when playing. To enable the cheat mode, the player when 
# prompted to choose a gamemode, they enter e which then asks them for a secret code
# that will enable the cheats. There are a few cheat codes that the player can use 
# when playing. These cheat codes cannot be enabled on the multi-player competetive
# (as that would be unfair to other players) or the single player mode, and cheats 
# can only be enabled when the user is prompted to choose a gamemode. The cheat codes
# that a user can use are as follows :
# 	
#	- u : This will allow the player to undo unlimited times, until the board resets
#     to its initial stage
#	- x : This will allow the player to instantly win the level and they will be 
#	  asked if they wanted to play again
#	- t : This will allow the player to teleport to the target. When this key is
#	  pressed, the board will only show the location for the character and the box
#	  since the character will be on the target. Once the character moves, the target
#	  will be visible.
#   - i : this key will allow the box and the character to move up the game and even 
#	  portal through the walls if needed.
#	- j : this key will allow the box and the character to move left in the game and 
# 	  even portal through the walls if needed.
#	- k : this key will allow the box and the character to move down in the game and 
# 	  even portal through the walls if needed.
#	- l : this key will allow the box and the character to move right in the game and 
# 	  even portal through the walls if needed.
#	  

# (b) play_spwcc (Line 3120) is what implements the single-player cheat codes mode 
# and this calls several helper function. One of the main helper functions is the
# play_game_cheat (Line 2019)

# (c) # In my implementation of `play_spwcc`, I designed a single-player mode 
# for Sokoban that introduces cheat codes, giving players more flexibility while
# keeping the cheats exclusive to this mode. When players select the cheat mode by 
# entering `e` at the game mode prompt, they’re asked for a secret code to activate 
# the cheats. These cheats are only available in this mode—they can’t be used in 
# regular single-player or multiplayer competitive modes, to keep things fair.

# I built the game around a set of helper methods that manage things like movement, 
# collision detection, board updates, and cheat handling. Once cheat mode is enabled,
# players can access different cheats that modify the game experience. The `u` cheat 
# allows them to undo moves as many times as they want, even resetting the board back
# to its original state by tracking the history of moves and reverting through 
# previous states. The `x` cheat lets the player win the game instantly, bypassing 
# the usual win condition checks, and then asks if they want to replay the level.

# One cool feature is the teleport (`t`) cheat, which lets the character move 
# directly to the target. When this happens, only the character and the box are 
# shown on the board to highlight the teleport, and the rest of the elements reappear
# once the character moves again. I also added cheats for moving through walls: `i` 
# moves up, `j` moves left, `k` moves down, and `l` moves right. These cheats 
# override the usual collision rules so that the character and box can even move 
# through obstacles.

# The helper methods I used make sure that these movements are smooth and consistent. 
# They handle updates to the grid and make sure the box interactions, goal mechanics,
# and other elements stay in sync with the player's actions. Altogether, this cheat
# enabled mode adds a fun twist to the game by giving players more control and 
# freedom compared to the standard gameplay.
		 
	
	la a0, prompt_sokoban
	li a7, 4
	ecall

	la a0, newline
	ecall
	
	jal choose_gamemode
	

		
	
exit:
    li a7, 10
    ecall
    
    
# --- HELPER FUNCTIONS ---
# Feel free to use, modify, or add to them however you see fit.
     
# Arguments: an integer MAX in a0
# Return: A number from 0 (inclusive) to MAX (exclusive)

choose_gamemode:

	# Store the return address on the stack to prevent overwriting
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp)
	sw s1, 12(sp)
	sw s2, 8(sp)
	sw s3, 4(sp)
	sw s4, 0(sp)
	
	make_gamemode_choice:
	
	la a0, newline
	li a7, 4
	ecall

	# Prompt the user to ask about the game mode they wish to play
	la a0, prompt_gamemode
	ecall

	la a0, prompt_gamemode1
	ecall

	la a0, prompt_gamemode2
	ecall
	
	li a7, 12
	ecall
	mv t0, a0

	la a0, newline
	li a7, 4
	ecall
	
	la a0, char_1
	lb a0, 0(a0)
	beq a0, t0, play_single_player
	
	la a0, char_2
	lb a0, 0(a0)
	beq a0, t0, play_multi_player

	la a0, char_E
	lb a0, 0(a0)
	beq a0, t0, play_cheat_mode

	j invalid_gamemode	
	
	play_single_player:
		
		jal play_sp
		j end_choose_gamemode
		
	play_multi_player:
	
		jal play_mp
		j end_choose_gamemode
		
	play_cheat_mode:
		
		la a0, secret_code
		
		lb s0, 0(a0)
		lb s1, 1(a0)
		lb s2, 2(a0)
		lb s3, 3(a0)
		lb s4, 4(a0)
		
		la a0, prompt_secret_code
		li a7, 4
		ecall
		
		la a0, 0x00000000
		li a7, 8
		ecall
		
		lb t0, 0(a0)
		beq t0, s0, check_num_2
		
		j wrong_code_entered
		
		check_num_2:
		
		lb t0, 1(a0)
		beq t0, s1, check_num_3

		j wrong_code_entered

		check_num_3:
		
		lb t0, 2(a0)
		beq t0, s2, check_num_4

		j wrong_code_entered
		
		check_num_4:
		
		lb t0, 3(a0)
		beq t0, s3, check_num_5

		j wrong_code_entered
		
		check_num_5:
		
		lb t0, 4(a0)
		beq t0, s4, play_cheat_game
		
		wrong_code_entered:
		
			la a0, newline
			li a7, 4
			ecall
		
			la a0, prompt_wrong_code
			ecall
			
			la a0, newline
			ecall

			j make_gamemode_choice
		
		play_cheat_game:
		
		la a0, newline
		li a7, 4
		ecall
		
		la a0, prompt_cheats_enabled
		ecall
		
		jal play_spwcc
		
		j end_choose_gamemode

	invalid_gamemode:
	
		la a0, newline
		li a7, 4
		ecall

		la a0, prompt_invalid_input
		ecall
		
		j make_gamemode_choice
		
	end_choose_gamemode:
	# Retrieve the return address from the stack
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	
	addi sp, sp, 24
	
	jr ra

set_box_coordinate:

	addi sp, sp, -32        # Allocate space on the stack to save registers
	sw t1, 28(sp)
	sw t2, 24(sp)
	sw t3, 20(sp)
	sw t4, 16(sp)
	sw t5, 12(sp)
	sw t6, 8(sp)
    sw ra, 4(sp)           # Save return address (ra) to the stack
    sw s0, 0(sp)           # Save s0 to the stack
	
	mv s0, a0 				# s0 has the base address of the box
	lb t1, 0(a1)			# t1 has the number of rows in the grid
	lb t2, 1(a1)			# t2 has the number of cols in the grid
	mv a0, t1 			
	addi a0, a0, -2 		# subtract 2 from a0 (for external walls) and pass the
							# it as an argument for notrand
	
	jal notrand
	addi t3, a0, 1 			# t3 is the random number generated + 1 to match the 
							# required range
	sb t3, 0(s0) 			# store the random number as the x-coordinate of the box

	li t4, 1 				# t4 is the index of the first row on the internal grid
	addi t5, t1, -2 		# t5 is the index of the last row on the internal grid
	
	# Check if the x-coordinate is not set to be the first and last row on 
	# the internal grid.
    bne t3, t4, check_lower_edge  	# If x is not on the upper edge of on internal 
									# grid, we jump to check the lower edge.
								
    j loop_edge           # If x is on the upper edge, we jump to loop_edge

	check_lower_edge:
	
		bne t3, t5, loop_non_edge   # # If x is not on the lower edge of on internal 
									# grid, we jump to loop_non_edge
		j loop_edge         		# If x is on the lower edge, we jump to loop_edge

	loop_non_edge:
		addi a0, t2, -2           # subtract 2 from t2 (for external walls) and pass the
								  # it as an argument for notrand
		jal notrand               # Generate a random number for y-coordinate
		addi a0, a0, 1            # Add 1 to adjust to the range needed

		j set_box_y_coordinate    # Ultimately we jump to store the y-coordinate

	loop_edge:
		addi a0, t2, -4         # Subtract 4 from t2 and pass it as an argument to notrand
		jal notrand             # Generate a random number for y-coordinate
		addi a0, a0, 2          # Add 2 to adjust to the range needed

	set_box_y_coordinate:
		sb a0, 1(s0)            # Store the valid y-coordinate for the box
		
	# Restore saved registers from the stack before returning
	lw t1, 28(sp)
	lw t2, 24(sp)
	lw t3, 20(sp)
	lw t4, 16(sp)
	lw t5, 12(sp)
	lw t6, 8(sp)
    lw ra, 4(sp)             # Restore return address (ra) from the stack
    lw s0, 0(sp)             # Restore s0 from the stack
    addi sp, sp, 32           # Deallocate space on the stack
    jr ra   
	
set_target_coordinate:
	
	addi sp, sp, -40        # Allocate space on the stack to save registers
    sw t1, 36(sp)
	sw t2, 32(sp)
	sw t3, 28(sp)
	sw t4, 24(sp)
	sw t5, 20(sp)
	sw t6, 16(sp)
	sw ra, 12(sp)           # Save return address (ra) to the stack
	sw s0, 8(sp)			# Save s0 to the stack
	sw s1, 4(sp)			# Save s1 to the stack
    sw s2, 0(sp)            # Save s2 to the stack
	
	mv s0, a0				# s0 has the base address of the target
	lb s1, 0(a2)			# s1 has the x-coordinate of the box
	lb s2, 1(a2)			# s2 has the y-coordinate of the box
	lb t1, 0(a1) 			# t1 has the number of rows on the grid
	lb t2, 1(a1)			# t2 has the number of cols on the grid
	li t3, 1				# t3 has the first row and col of the internal grid
	addi t4, t1, -2			# t4 has the last row on the internal grid
	addi t5, t2, -2			# t5 has the last col on the internal grid


	# Check if the box is on the edge
	beq s1, t3, same_target_x_coordinate	# if the x-coordinate is on the first row
	beq s1, t4, same_target_x_coordinate	# if the x-coordinate is on the last row
	
	beq s2, t3, same_target_y_coordinate	# if the y-coordinate is on the first col
	beq s2, t5, same_target_y_coordinate	# if the y-coordinate is on the last col
	
	# Randomly set the x-coordinate
	addi a0, t1, -2 		# subtract 2 from t1 (for external walls) and pass the
							# internal grid size as an argument for notrand
	
	jal notrand
	addi a0, a0, 1 			# a0 is the random number generated + 1 to match the 
							# required range
	
	beq a0, s1, same_target_x_coordinate
	sb a0, 0(s0) 			# store the random number as the x-coordinate of the target

	# Randomly set the y-coordinate
	addi a0, t2, -2 		# subtract 2 from t2 (for external walls) and pass the
							# internal grid size as an argument for notrand
	
	jal notrand
	addi a0, a0, 1 			# a0 is the random number generated + 1 to match the 
							# required range
	
	sb a0, 1(s0) 			# store the random number as the y-coordinate of the target
	
	j end_set_target_coordinate # jump to end setting the coordinates
	
	same_target_x_coordinate:
		
		sb s1, 0(s0)			# set the same x-coordinate as the box
	
		set_target_y_coordinate:
	
		addi a0, t2, -2 		# subtract 2 from t2 (for external walls) and pass the
								# internal grid size as an argument for notrand
	
		jal notrand
		addi a0, a0, 1 			# a0 is the random number generated + 1 to match the 
								# required range
		
		beq a0, s2, set_target_y_coordinate # if the generated y-coordinate is the same as
								 		 	# the y-coordinate of the box, we regenarate it

		
		sb a0, 1(s0) 				# we set the y-coordinate
		
		
		j end_set_target_coordinate	# jump to end setting the coordinates
		
	same_target_y_coordinate:
	
		sb s2, 1(s0)		# set the same y-coordinate as the box
	
		set_target_x_coordinate:
	
		addi a0, t1, -2 		# subtract 2 from t1 (for external walls) and pass the
								# internal grid size as an argument for notrand
	
		jal notrand
		addi a0, a0, 1 			# a0 is the random number generated + 1 to match the 
								# required range
		
		beq a0, s1, set_target_x_coordinate # if the generated x-coordinate is the same as
											# the x-coordinate of the box, we regenarate it	
		
		sb a0, 0(s0)				# we set the x-coordinate
		
		j end_set_target_coordinate	# jump to end setting the coordinates				
		
	end_set_target_coordinate:
	
	# Restore saved registers from the stack before returning
	lw t1, 36(sp)
	lw t2, 32(sp)
	lw t3, 28(sp)
	lw t4, 24(sp)
	lw t5, 20(sp)
	lw t6, 16(sp)
    lw ra, 12(sp)			# Restore return address (ra) from the stack
    lw s0, 8(sp)			# Restore s0 from the stack
	lw s1, 4(sp)			# Restore s1 from the stack
	lw s2, 0(sp)			# Restore s2 from the stack
    addi sp, sp, 40         # Deallocate space on the stack
    jr ra

set_character_coordinate:

	addi sp, sp, -40        # Allocate space on the stack to save registers
	sw t1, 36(sp)
	sw t2, 32(sp)
	sw t3, 28(sp)
	sw t4, 24(sp)
    sw ra, 20(sp)           # Save return address (ra) to the stack
	sw s0, 16(sp)			# Save s0 to the stack
	sw s1, 12(sp)			# Save s1 to the stack
    sw s2, 8(sp)            # Save s2 to the stack
	sw s3, 4(sp)			# Save s3 to the stack
	sw s4, 0(sp)			# Save s4 to the stack

	mv s0, a0				# s0 has the base address of the character
	lb s1, 0(a2)			# s1 has the x-coordinate of the box
	lb s2, 1(a2)			# s2 has the y-coordinate of the box
	lb s3, 0(a3)			# s3 has the x-coordinate of the target
	lb s4, 1(a3)			# s4 has the y-coordinate of the target
	lb t1, 0(a1) 			# t1 has the number of rows on the grid
	lb t2, 1(a1)			# t2 has the number of cols on the grid

	character_generate_random_coordinates:
	
		addi a0, t1, -2
		jal notrand
		addi t3, a0, 1 			# t3 has the randomly generated x-coordinate

		addi a0, t2, -2
		jal notrand
		addi t4, a0, 1 			# t4 has the randomly generated y-coordinate

		bne s1, t3, match_box_y_coordinate
		j character_generate_random_coordinates
		
		match_box_y_coordinate:
		
			bne s2, t4, match_target_x_coordinate
			j character_generate_random_coordinates
		
		match_target_x_coordinate:
		
			bne s3, t3, match_target_y_coordinate
			j character_generate_random_coordinates
		
		match_target_y_coordinate:
			
			bne s4, t4, setup_coordinates
			j character_generate_random_coordinates
			
	setup_coordinates:
		
		sb t3, 0(s0)
		sb t4, 1(s0)

	end_set_character_coordinate:
	
	# Restore saved registers from the stack before returning
	lw t1, 36(sp)
	lw t2, 32(sp)
	lw t3, 28(sp)
	lw t4, 24(sp)
    lw ra, 20(sp)			# Restore return address (ra) from the stack
    lw s0, 16(sp)			# Restore s0 from the stack
	lw s1, 12(sp)			# Restore s1 from the stack
	lw s2, 8(sp)			# Restore s2 from the stack
	lw s3, 4(sp)			# Restore s3 from the stack
	lw s4, 0(sp)			# Restore s4 from the stack
    addi sp, sp, 40         # Deallocate space on the stack
    jr ra

grid_setup:
	
	addi sp, sp, -68   		# Allocate space on the stack to save registers
	sw ra, 64(sp)			# Save return address (ra) to the stack
	sw t6, 60(sp)			# Save t6 to the stack
	sw s0, 56(sp)			# Save s0 to the stack
	sw s1, 52(sp)			# Save s1 to the stack
	sw s2, 48(sp)			# Save s2 to the stack
	sw s3, 44(sp)			# Save s3 to the stack
	sw s4, 40(sp)			# Save s4 to the stack
	sw s5, 36(sp)			# Save s5 to the stack
	sw s6, 32(sp)			# Save s6 to the stack
	sw s7, 28(sp)			# Save s7 to the stack
	sw s8, 24(sp)			# Save s8 to the stack
	sw s9, 20(sp)			# Save s9 to the stack
	sw t1, 16(sp)			# Save t1 to the stack
	sw t2, 12(sp)			# Save t2 to the stack
	sw t3, 8(sp)			# Save t3 to the stack
	sw t4, 4(sp)			# Save t4 to the stack
	sw t5, 0(sp)			# Save t5 to the stack
	
	mv s9, a0				# s9 has the base address of the heap
	mv s0, a0 				# s0 has the base address of the heap and this will change
	
	la a0, gridsize
	lb s1, 0(a0)			# s1 has the number of rows in the grid
	lb s2, 1(a0)			# s2 has the number of cols in the grid
	
	la a0, box
	lb s3, 0(a0)			# s3 has the x-coordinate of the box
	lb s4, 1(a0)			# s4 has the y-coordinate of the box

	la a0, target
	lb s5, 0(a0)			# s5 has the x-coordinate of the target
	lb s6, 1(a0)			# s6 has the y-coordinate of the target
	
	la a0, character		
	lb s7, 0(a0)			# s7 has the x-coordinate of the character
	lb s8, 1(a0)			# s8 has the y-coordinate of the character

	li t1, 0				# t1 has the first row and col on the grid
	addi t2, s1, -1			# t2 has the last row on the grid
	addi t3, s2, -1			# t3 has the last col on the grid
	

	li t4, 0				# t4 is the index of the current row
	li t5, 0				# t5 is the index of the current col
	
	grid_setup_row_loop:
	
		beq t4, s1, end_grid_setup_loop
		
		grid_setup_col_loop:
		
			beq t5, s2, update_row_loop

			beq t4, t1, wall_setup	# if row is the first row on the grid, then setup wall
			beq t4, t2, wall_setup	# if row is the last row on the grid, then setup wall
			beq t5, t1, wall_setup	# if col is the first col on the grid, then setup wall
			beq t5, t3, wall_setup	# if col is the last col on the grid, then setup wall
			
			check_x_coordinate_box:
				beq t4, s3, check_y_coordinate_box
				
			check_x_coordinate_character:
				beq t4, s7, check_y_coordinate_character
				
			check_x_coordinate_target:
				beq t4, s5, check_y_coordinate_target
				j floor_setup	
			
			check_y_coordinate_box:
				beq t5, s4, box_setup
				j check_x_coordinate_character
				
			check_y_coordinate_character:
				beq t5, s8, character_setup
				j check_x_coordinate_target
				
			check_y_coordinate_target:
				beq t5, s6, target_setup
				j floor_setup
			
			update_col_loop:
			
			addi t5, t5, 1			# increment the index for the col by 1
			j grid_setup_col_loop	# loop again
			
		update_row_loop:

			print_newline:

			la a0, newline			# a0 has the newline symbol
			lb a1, 0(a0)
			sb a1, 0(s0)			# store the newline symbol on the heap
			addi s0, s0, 1			# increment the heap to the next address

		li t5, 0				# reset the col index to 0

		addi t4, t4, 1 			# increment the index for the row by 1
		j grid_setup_row_loop	# loop again


	wall_setup:

		la a0, wall_symbol		# a0 has the wall symbol
		lb a1, 0(a0)
		sb a1, 0(s0)			# store the wall symbol on the heap
		addi s0, s0, 1			# increment the heap to the next address

		j update_col_loop
		
		
	box_setup:

		la a0, box_symbol 		# a0 has the box symbol	
		lb a1, 0(a0)
		sb a1, 0(s0)			# store the box symbol on the heap
		addi s0, s0, 1			# increment the heap to the next address	
		
		j update_col_loop
		
	target_setup:
		
		la a0, target_symbol 	# a0 has the target symbol	
		lb a1, 0(a0)
		sb a1, 0(s0)			# store the target symbol on the heap
		addi s0, s0, 1			# increment the heap to the next address	
		
		j update_col_loop
		
	character_setup:

		la a0, character_symbol # a0 has the character symbol	
		lb a1, 0(a0)
		sb a1, 0(s0)			# store the character symbol on the heap
		addi s0, s0, 1			# increment the heap to the next address	
		
		j update_col_loop

	floor_setup:
		
		la a0, floor_symbol 	# a0 has the floor symbol	
		lb a1, 0(a0)
		sb a1, 0(s0)			# store the floor symbol on the heap
		addi s0, s0, 1			# increment the heap to the next address	
		
		j update_col_loop

	end_grid_setup_loop:

	la t6, 0x00				# t6 has the null pointer
	sb t6, 0(s0)			# we store the null pointer on the heap

	mv a0, s9 				# a0 has the base address of the heap
	li a7, 4					# print the grid that was setup
	ecall

	la a0, newline				# print a newline
	li a7, 4
	ecall

	mv a0, s9

	# Restore saved registers from the stack before returning
    lw ra, 64(sp)			# Restore return address (ra) from the stack
	lw t6, 60(sp)			# Restore t6 from the stack
    lw s0, 56(sp)			# Restore s0 from the stack
	lw s1, 52(sp)			# Restore s1 from the stack
	lw s2, 48(sp)			# Restore s2 from the stack
	lw s3, 44(sp)			# Restore s3 from the stack
	lw s4, 40(sp)			# Restore s4 from the stack
	lw s5, 36(sp)			# Restore s5 from the stack
	lw s6, 32(sp)			# Restore s6 from the stack
	lw s7, 28(sp)			# Restore s7 from the stack
	lw s8, 24(sp)			# Restore s8 from the stack
	lw s9, 20(sp)			# Restore s9 from the stack
	lw t1, 16(sp)			# Restore t1 from the stack
	lw t2, 12(sp)			# Restore t2 from the stack
	lw t3, 8(sp)			# Restore t3 from the stack
	lw t4, 4(sp)			# Restore t4 from the stack
	lw t5, 0(sp)			# Restore t5 from the stack
    addi sp, sp, 68         # Deallocate space on the stack
 
    jr ra

move_up:

	addi sp, sp, -40   		# Allocate space on the stack to save registers
	sw ra, 36(sp)			# Save return address (ra) to the stack
	sw t1, 32(sp)			# Save t1 to the stack
	sw t2, 28(sp)			# Save t2 to the stack
	sw t3, 24(sp)			# Save t3 to the stack
	sw t4, 20(sp)			# Save t4 to the stack
	sw t5, 16(sp)			# Save t5 to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
	sw s2, 4(sp)			# Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la a0, gridsize
	lb s0, 0(a0)			
	addi s0, s0, -1			# s0 has the last row on the grid.
	lb s1, 1(a0)			
	addi s1, s1, -1			# s1 has the last col on the grid.	

	la s2, box				# s2 has the base address of the box
	la s3, character		# s3 has the base address of the character

	lb t1, 0(s2)			# t1 has the box's x-coordinate
	lb t2, 1(s2)			# t2 has the box's y-coordinate
	
	lb t3, 0(s3)			# t3 has the character's x-coordinate
	lb t4, 1(s3)			# t4 has the character's y-coordinate
	
	addi t3, t3, -1 		# when the character moves up, row = row - 1
	
	# if the character moves up into the wall, then it is an invalid move
		beqz t3, move_up_no_change

	# if the character and the box have the same x-coordinate, we check if they
	# have the same y-coordinate
	bne t3, t1, valid_move_up
	
	move_up_check_box_col:
		
		# if they have the same y-coordinate, we move up the box as well
		beq t4, t2, move_up_box
		
		# if box is not in the way of the character, we just move up the character
		j valid_move_up
	
	move_up_box:
		
		addi t1, t1, -1				# when the box moves up, row = row - 1
		
		beqz t1, move_up_no_change 	# if the box moves up into the wall, 
								 	# it is an invalid move
		
		# if it is a valid move, we update the new coordinates of the box's location
		sb t1, 0(s2) 		# update the row with the new row
		
		j valid_move_up

	valid_move_up:
		
		# we update the new coordinates of the character's location
		sb t3, 0(s3)

		li a0, 1

	j move_up_end
		
	move_up_no_change:

		# if it is an invalid move, no coordinates of the box or character change.
		# we print the no change prompt and exit the function
		
		la a0, prompt_no_change	
		li a7, 4
		ecall

		li a0, 0

	move_up_end:
		
		# Restore saved registers from the stack before returning
		lw ra, 36(sp)			# Restore return address (ra) from the stack
		lw t1, 32(sp)			# Restore t1 from the stack
		lw t2, 28(sp)			# Restore t2 from the stack
		lw t3, 24(sp)			# Restore t3 from the stack
		lw t4, 20(sp)			# Restore t4 from the stack
		lw t5, 16(sp)			# Restore t5 from the stack
		lw s0, 12(sp)			# Restore s0 from the stack
		lw s1, 8(sp)			# Restore s1 from the stack
		lw s2, 4(sp)			# Restore s2 from the stack
		lw s3, 0(sp)			# Restore s3 from the stack
		addi sp, sp, 40         # Deallocate space on the stack

		jr ra
	
move_down:

	addi sp, sp, -40   		# Allocate space on the stack to save registers
	sw ra, 36(sp)			# Save return address (ra) to the stack
	sw t1, 32(sp)			# Save t1 to the stack
	sw t2, 28(sp)			# Save t2 to the stack
	sw t3, 24(sp)			# Save t3 to the stack
	sw t4, 20(sp)			# Save t4 to the stack
	sw t5, 16(sp)			# Save t5 to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
	sw s2, 4(sp)			# Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la a0, gridsize
	lb s0, 0(a0)			
	addi s0, s0, -1			# s0 has the last row on the grid.
	lb s1, 1(a0)			
	addi s1, s1, -1			# s1 has the last col on the grid.	

	la s2, box				# s2 has the base address of the box
	la s3, character		# s3 has the base address of the character
	
	lb t1, 0(s2)			# t1 has the box's x-coordinate
	lb t2, 1(s2)			# t2 has the box's y-coordinate
	
	lb t3, 0(s3)			# t3 has the character's x-coordinate
	lb t4, 1(s3)			# t4 has the character's y-coordinate
	
	addi t3, t3, 1 		# when the character moves down, row = row + 1
	
	# if the character moves down into the wall, then it is an invalid move
	beq t3, s0, move_down_no_change

	# if the character and the box have the same x-coordinate, we check if they
	# have the same y-coordinate
	bne t3, t1, valid_move_down
	
	move_down_check_box_col:
		
		# if they have the same y-coordinate, we move down the box as well
		beq t4, t2, move_down_box
		
		# if box is not in the way of the character, we just move down the character
		j valid_move_down
	
	move_down_box:
		
		addi t1, t1, 1				# when the box moves down, row = row + 1
		
		beq t1, s0, move_down_no_change # if the box moves down into the wall, 
								 		# it is an invalid move
		
		# if it is a valid move, we update the new coordinates of the box's location
		sb t1, 0(s2) 		# update the row with the new row
		
		j valid_move_down

	valid_move_down:
		
		# we update the new coordinates of the character's location
		sb t3, 0(s3)		# update the row with the new row
		
		li a0, 1
		
		j move_down_end
		
	move_down_no_change:

		# if it is an invalid move, no coordinates of the box or character change.
		# we print the no change prompt and exit the function
		
		la a0, prompt_no_change	
		li a7, 4
		ecall
		
		li a0, 0
		
	move_down_end:

		# Restore saved registers from the stack before returning
		lw ra, 36(sp)			# Restore return address (ra) from the stack
		lw t1, 32(sp)			# Restore t1 from the stack
		lw t2, 28(sp)			# Restore t2 from the stack
		lw t3, 24(sp)			# Restore t3 from the stack
		lw t4, 20(sp)			# Restore t4 from the stack
		lw t5, 16(sp)			# Restore t5 from the stack
		lw s0, 12(sp)			# Restore s0 from the stack
		lw s1, 8(sp)			# Restore s1 from the stack
		lw s2, 4(sp)			# Restore s2 from the stack
		lw s3, 0(sp)			# Restore s3 from the stack
		addi sp, sp, 40         # Deallocate space on the stack
	
		jr ra


move_left:

	addi sp, sp, -40   		# Allocate space on the stack to save registers
	sw ra, 36(sp)			# Save return address (ra) to the stack
	sw t1, 32(sp)			# Save t1 to the stack
	sw t2, 28(sp)			# Save t2 to the stack
	sw t3, 24(sp)			# Save t3 to the stack
	sw t4, 20(sp)			# Save t4 to the stack
	sw t5, 16(sp)			# Save t5 to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
	sw s2, 4(sp)			# Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la a0, gridsize
	lb s0, 0(a0)			
	addi s0, s0, -1			# s0 has the last row on the grid.
	lb s1, 1(a0)			
	addi s1, s1, -1			# s1 has the last col on the grid.	

	la s2, box				# s2 has the base address of the box
	la s3, character		# s3 has the base address of the character

	lb t1, 0(s2)			# t1 has the box's x-coordinate
	lb t2, 1(s2)			# t2 has the box's y-coordinate
	
	lb t3, 0(s3)			# t3 has the character's x-coordinate
	lb t4, 1(s3)			# t4 has the character's y-coordinate
	
	addi t4, t4, -1 		# when the character moves left, col = col - 1
	
	# if the character moves left into the wall, then it is an invalid move
	beqz t4, move_left_no_change

	# if the character and the box have the same y-coordinate, we check if they
	# have the same x-coordinate
	bne t4, t2, valid_move_left
	
	move_left_check_box_row:
		
		# if they have the same x-coordinate, we move the box left as well
		beq t1, t3, move_left_box

		# if box is not in the way of the character, we just move the character left
		j valid_move_left
	
	move_left_box:
		
		addi t2, t2, -1				# when the box moves left, col = col - 1
		
		beqz t2, move_left_no_change 	# if the box moves left into the wall, 
								 		# it is an invalid move
		
		# if it is a valid move, we update the new coordinates of the box's location
		sb t2, 1(s2) 		# update the col with the new col
		
		j valid_move_left

	valid_move_left:
		
		# we update the new coordinates of the character's location
		sb t4, 1(s3)		# update the col with the new col

		li a0, 1
		
		j move_left_end
		
	move_left_no_change:

		# if it is an invalid move, no coordinates of the box or character change.
		# we print the no change prompt and exit the function
		
		la a0, prompt_no_change	
		li a7, 4
		ecall

		li a0, 0
		
	move_left_end:
		
		# Restore saved registers from the stack before returning
		lw ra, 36(sp)			# Restore return address (ra) from the stack
		lw t1, 32(sp)			# Restore t1 from the stack
		lw t2, 28(sp)			# Restore t2 from the stack
		lw t3, 24(sp)			# Restore t3 from the stack
		lw t4, 20(sp)			# Restore t4 from the stack
		lw t5, 16(sp)			# Restore t5 from the stack
		lw s0, 12(sp)			# Restore s0 from the stack
		lw s1, 8(sp)			# Restore s1 from the stack
		lw s2, 4(sp)			# Restore s2 from the stack
		lw s3, 0(sp)			# Restore s3 from the stack
		addi sp, sp, 40         # Deallocate space on the stack

		jr ra

move_right:

	addi sp, sp, -40   		# Allocate space on the stack to save registers
	sw ra, 36(sp)			# Save return address (ra) to the stack
	sw t1, 32(sp)			# Save t1 to the stack
	sw t2, 28(sp)			# Save t2 to the stack
	sw t3, 24(sp)			# Save t3 to the stack
	sw t4, 20(sp)			# Save t4 to the stack
	sw t5, 16(sp)			# Save t5 to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
	sw s2, 4(sp)			# Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la a0, gridsize
	lb s0, 0(a0)			
	addi s0, s0, -1			# s0 has the last row on the grid.
	lb s1, 1(a0)			
	addi s1, s1, -1			# s1 has the last col on the grid.	

	la s2, box				# s2 has the base address of the box
	la s3, character		# s3 has the base address of the character

	lb t1, 0(s2)			# t1 has the box's x-coordinate
	lb t2, 1(s2)			# t2 has the box's y-coordinate

	lb t3, 0(s3)			# t3 has the character's x-coordinate
	lb t4, 1(s3)			# t4 has the character's y-coordinate
	
	addi t4, t4, 1 		# when the character moves right, col = col + 1
	
	# if the character moves right into the wall, then it is an invalid move
	beq t4, s1, move_right_no_change

	# if the character and the box have the same y-coordinate, we check if they
	# have the same x-coordinate
	bne t4, t2, valid_move_right
	
	move_right_check_box_row:
		
		# if they have the same x-coordinate, we move the box right as well
		beq t1, t3, move_right_box

		# if box is not in the way of the character, we just move the character right
		j valid_move_right
	
	move_right_box:
		
		addi t2, t2, 1				# when the box moves right, col = col + 1
		
		beq t2, s1, move_right_no_change 	# if the box moves right into the wall, 
								 			# it is an invalid move
		
		# if it is a valid move, we update the new coordinates of the box's location
		sb t2, 1(s2) 		# update the col with the new col
		
		j valid_move_right

	valid_move_right:
		
		# we update the new coordinates of the character's location
		sb t4, 1(s3)		# update the col with the new col

		li a0, 1
		
		j move_right_end
		
	move_right_no_change:

		# if it is an invalid move, no coordinates of the box or character change.
		# we print the no change prompt and exit the function
		
		la a0, prompt_no_change	
		li a7, 4
		ecall

		li a0, 0
		
	move_right_end:
		
		# Restore saved registers from the stack before returning
		lw ra, 36(sp)			# Restore return address (ra) from the stack
		lw t1, 32(sp)			# Restore t1 from the stack
		lw t2, 28(sp)			# Restore t2 from the stack
		lw t3, 24(sp)			# Restore t3 from the stack
		lw t4, 20(sp)			# Restore t4 from the stack
		lw t5, 16(sp)			# Restore t5 from the stack
		lw s0, 12(sp)			# Restore s0 from the stack
		lw s1, 8(sp)			# Restore s1 from the stack
		lw s2, 4(sp)			# Restore s2 from the stack
		lw s3, 0(sp)			# Restore s3 from the stack
		addi sp, sp, 40         # Deallocate space on the stack

		jr ra

move_reset:

	addi sp, sp, -32		# Allocate space on the stack to save registers
	sw ra, 28(sp)			# Save return address (ra) to the stack
	sw s0, 24(sp)			# Save s0 to the stack
	sw s1, 20(sp)			# Save s1 to the stack
	sw s2, 16(sp)			# Save s2 to the stack
	sw s3, 12(sp)			# Save s3 to the stack
	sw s4, 8(sp)			# Save s4 to the stack
	sw s5, 4(sp)			# Save s5 to the stack
	sw t0, 0(sp)			# Save to to the stack

	la s0, starting_coordinate_character
	la s3, character

	lb t0, 0(s0)	# t0 has the initial x-coordinate of character
	sb t0, 0(s3)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s0)	# t0 has the initial y-coordinate of character
	sb t0, 1(s3)	# reset the character's y-coordinate to its initial value

	la s1, starting_coordinate_box
	la s4, box

	lb t0, 0(s1)	# t0 has the initial x-coordinate of box
	sb t0, 0(s4)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s1)	# t0 has the initial y-coordinate of box
	sb t0, 1(s4)	# reset the character's y-coordinate to its initial value
	
	la s2, starting_coordinate_target
	la s5, target

	lb t0, 0(s2)	# t0 has the initial x-coordinate of target
	sb t0, 0(s5)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s2)	# t0 has the initial y-coordinate of target
	sb t0, 1(s5)	# reset the character's y-coordinate to its initial value

	# Restore saved registers from the stack before returning
    lw ra, 28(sp)			# Restore return address (ra) from the stack
    lw s0, 24(sp)			# Restore s0 from the stack
	lw s1, 20(sp)			# Restore s1 from the stack
	lw s2, 16(sp)			# Restore s2 from the stack
	lw s3, 12(sp)			# Restore s3 from the stack
	lw s4, 8(sp)			# Restore s4 from the stack
	lw s5, 4(sp)			# Restore s5 from the stack
	lw t0, 0(sp)			# Restore t0 from the stack
    addi sp, sp, 32         # Deallocate space on the stack

    jr ra

move_reset_mp:

	addi sp, sp, -32		# Allocate space on the stack to save registers
	sw ra, 28(sp)			# Save return address (ra) to the stack
	sw s0, 24(sp)			# Save s0 to the stack
	sw s1, 20(sp)			# Save s1 to the stack
	sw s2, 16(sp)			# Save s2 to the stack
	sw s3, 12(sp)			# Save s3 to the stack
	sw s4, 8(sp)			# Save s4 to the stack
	sw s5, 4(sp)			# Save s5 to the stack
	sw t0, 0(sp)			# Save to to the stack

	la s0, starting_coordinate_character_mp
	la s3, character

	lb t0, 0(s0)	# t0 has the initial x-coordinate of character
	sb t0, 0(s3)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s0)	# t0 has the initial y-coordinate of character
	sb t0, 1(s3)	# reset the character's y-coordinate to its initial value

	la s1, starting_coordinate_box_mp
	la s4, box

	lb t0, 0(s1)	# t0 has the initial x-coordinate of box
	sb t0, 0(s4)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s1)	# t0 has the initial y-coordinate of box
	sb t0, 1(s4)	# reset the character's y-coordinate to its initial value
	
	la s2, starting_coordinate_target_mp
	la s5, target

	lb t0, 0(s2)	# t0 has the initial x-coordinate of target
	sb t0, 0(s5)	# reset the character's x-coordinate to its initial value
	
	lb t0, 1(s2)	# t0 has the initial y-coordinate of target
	sb t0, 1(s5)	# reset the character's y-coordinate to its initial value

	# Restore saved registers from the stack before returning
    lw ra, 28(sp)			# Restore return address (ra) from the stack
    lw s0, 24(sp)			# Restore s0 from the stack
	lw s1, 20(sp)			# Restore s1 from the stack
	lw s2, 16(sp)			# Restore s2 from the stack
	lw s3, 12(sp)			# Restore s3 from the stack
	lw s4, 8(sp)			# Restore s4 from the stack
	lw s5, 4(sp)			# Restore s5 from the stack
	lw t0, 0(sp)			# Restore t0 from the stack
    addi sp, sp, 32         # Deallocate space on the stack

    jr ra

move_teleport:

	addi sp, sp, -20        # Allocate space on the stack to save registers
    sw ra, 16(sp)           # Save return address (ra) to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
    sw s2, 4(sp)            # Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la s0, character		# s0 has the base address of the character
	la s1, target			# s1 has the base address of the target
	
	lb s2, 0(s1)			# s2 has the x-coordinate of the target
	lb s3, 1(s1)			# s3 has the y-coordinate of the target
	
	# Store the target's coordinates as the character's coordinates.
	sb s2, 0(s0)			
	sb s3, 1(s0)

	# Restore saved registers from the stack before returning
    lw ra, 16(sp)			# Restore return address (ra) from the stack
    lw s0, 12(sp)			# Restore s0 from the stack
	lw s1, 8(sp)			# Restore s1 from the stack
	lw s2, 4(sp)			# Restore s2 from the stack
	lw s3, 0(sp)			# Restore s3 from the stack
    addi sp, sp, 20         # Deallocate space on the stack

    jr ra	
	
move_instant_win:

	addi sp, sp, -20        # Allocate space on the stack to save registers
    sw ra, 16(sp)           # Save return address (ra) to the stack
	sw s0, 12(sp)			# Save s0 to the stack
	sw s1, 8(sp)			# Save s1 to the stack
    sw s2, 4(sp)            # Save s2 to the stack
	sw s3, 0(sp)			# Save s3 to the stack

	la s0, box				# s0 has the base address of the box
	la s1, target			# s1 has the base address of the target
	
	lb s2, 0(s1)			# s2 has the x-coordinate of the target
	lb s3, 1(s1)			# s3 has the y-coordinate of the target
	
	# Store the target's coordinates as the box's coordinates.
	sb s2, 0(s0)			
	sb s3, 1(s0)

	# Restore saved registers from the stack before returning
    lw ra, 16(sp)			# Restore return address (ra) from the stack
    lw s0, 12(sp)			# Restore s0 from the stack
	lw s1, 8(sp)			# Restore s1 from the stack
	lw s2, 4(sp)			# Restore s2 from the stack
	lw s3, 0(sp)			# Restore s3 from the stack
    addi sp, sp, 20         # Deallocate space on the stack

    jr ra

move_portal_up:

	addi sp, sp, -40   		# Allocate space on the stack to save registers
	sw ra, 36(sp)			# Save return address (ra) to the stack
	sw s0, 32(sp)			
	sw s1, 28(sp)			
	sw s2, 24(sp)			
	sw s3, 20(sp)			
	sw s4, 16(sp)			
	sw t1, 12(sp)			
	sw t2, 8(sp)		
	sw t3, 4(sp)			
	sw t4, 0(sp)			
	
	la s0, character		# s0 has the base address of the character
	la s1, box				# s1 has the base address of the box

	li s2, 1				# s2 has the first row/col of the grid
	
	la a0, gridsize
	lb s3, 0(a0)
	addi s3, s3, -2			# s3 has the last valid row on the grid

	lb s4, 1(a0)
	addi s4, s4, -2			# s4 has the last valid col on the grid
	
	lb t1, 0(s0)			# t1 has the x-coordinate of the character
	lb t2, 1(s0)			# t2 has the y-coordinate of the character
	lb t3, 0(s1)			# t3 has the x-coordinate of the box
	lb t4, 1(s1)			# t4 has the y-coordinate of the box

	# Let us start by moving the character up
	addi t1, t1, -1
	
	beqz t1, portal_move_up_character
	
	j normal_move_up_character
	
	portal_move_up_character:
		
		mv t1, s3

	normal_move_up_character:
		
		beq t3, t1, match_up_y_coordinate
		j portal_up_move_end
		
	match_up_y_coordinate:
	
		beq t2, t4, move_box_up
		j portal_up_move_end
		
	move_box_up:
	
		addi t3, t3, -1
		
		beqz t3, portal_move_up_box
		
		j portal_up_move_end
	
	portal_move_up_box:
	
		mv t3, s3	
	
	portal_up_move_end:

	sb t1, 0(s0)
	sb t2, 1(s0)
	sb t3, 0(s1)
	sb t4, 1(s2)

	# Restore saved registers from the stack before returning
	lw ra, 36(sp)			# Restore return address (ra) from the stack
	lw s0, 32(sp)			
	lw s1, 28(sp)			
	lw s2, 24(sp)			
	lw s3, 20(sp)			
	lw s4, 16(sp)			
	lw t1, 12(sp)			
	lw t2, 8(sp)			
	lw t3, 4(sp)			
	lw t4, 0(sp)			
	addi sp, sp, 40         # Deallocate space on the stack

	jr ra
	
	
move_portal_down:

	portal_move_down:
    addi sp, sp, -40        # Allocate space on the stack to save registers
    sw ra, 36(sp)           # Save return address (ra) to the stack
    sw s0, 32(sp)           
    sw s1, 28(sp)           
    sw s2, 24(sp)           
    sw s3, 20(sp)           
    sw s4, 16(sp)           
    sw t1, 12(sp)           
    sw t2, 8(sp)            
    sw t3, 4(sp)            
    sw t4, 0(sp)            

    la s0, character        # s0 has the base address of the character
    la s1, box              # s1 has the base address of the box

    li s2, 1                # s2 has the first row/col of the grid
    
    la a0, gridsize
    lb s3, 0(a0)            # s3 has the grid size (rows)
    addi s3, s3, -1         # s3 has the last row on the grid

    lb s4, 1(a0)            # s4 has the grid size (cols)
    addi s4, s4, -1         # s4 has the last col on the grid

    lb t1, 0(s0)            # t1 has the x-coordinate of the character
    lb t2, 1(s0)            # t2 has the y-coordinate of the character
    lb t3, 0(s1)            # t3 has the x-coordinate of the box
    lb t4, 1(s1)            # t4 has the y-coordinate of the box

    # Move the character down
    addi t1, t1, 1

    bge t1, s3, portal_move_down_character

    j normal_move_down_character

	portal_move_down_character:

		mv t1, s2                # Wrap to the first valid row if out of bounds

	normal_move_down_character:

		beq t3, t1, match_down_y_coordinate
		j portal_down_move_end

	match_down_y_coordinate:

		beq t2, t4, move_box_down
		j portal_down_move_end

	move_box_down:

		addi t3, t3, 1

		beq t3, s3, portal_move_down_box

		j portal_down_move_end

	portal_move_down_box:

		mv t3, s2                # Wrap box to the first valid row

	portal_down_move_end:

		sb t1, 0(s0)
		sb t2, 1(s0)
		sb t3, 0(s1)
		sb t4, 1(s1)

		# Restore saved registers from the stack before returning
		lw ra, 36(sp)            # Restore return address (ra) from the stack
		lw s0, 32(sp)            
		lw s1, 28(sp)            
		lw s2, 24(sp)            
		lw s3, 20(sp)            
		lw s4, 16(sp)            
		lw t1, 12(sp)            
		lw t2, 8(sp)            
		lw t3, 4(sp)            
		lw t4, 0(sp)            
		addi sp, sp, 40          # Deallocate space on the stack

		jr ra


move_portal_left:

	portal_move_left:
    addi sp, sp, -40        # Allocate space on the stack to save registers
    sw ra, 36(sp)           # Save return address (ra) to the stack
    sw s0, 32(sp)           
    sw s1, 28(sp)           
    sw s2, 24(sp)           
    sw s3, 20(sp)           
    sw s4, 16(sp)           
    sw t1, 12(sp)           
    sw t2, 8(sp)            
    sw t3, 4(sp)            
    sw t4, 0(sp)            

    la s0, character        # s0 has the base address of the character
    la s1, box              # s1 has the base address of the box

    li s2, 0                # s2 has the first row/column on the grid

    la a0, gridsize
    lb s3, 0(a0)            # s3 has the grid size (rows)
    addi s3, s3, -2         # s3 has the last valid row on the grid

    lb s4, 1(a0)            # s4 has the grid size (cols)
    addi s4, s4, -2         # s4 has the last valid col on the grid

    lb t1, 0(s0)            # t1 has the x-coordinate of the character
    lb t2, 1(s0)            # t2 has the y-coordinate of the character
    lb t3, 0(s1)            # t3 has the x-coordinate of the box
    lb t4, 1(s1)            # t4 has the y-coordinate of the box

    # Move the character left
    addi t2, t2, -1

    beq t2, s2, portal_move_left_character

    j normal_move_left_character

	portal_move_left_character:

		mv t2, s4                # Wrap to the last column if out of bounds

	normal_move_left_character:

		beq t4, t2, match_left_x_coordinate
		j portal_left_move_end

	match_left_x_coordinate:

		beq t3, t1, move_box_left
		j portal_left_move_end

	move_box_left:

		addi t4, t4, -1

		beq t4, s2, portal_move_left_box

		j portal_left_move_end

	portal_move_left_box:

		mv t4, s4                # Wrap box to the last column

	portal_left_move_end:

		sb t1, 0(s0)
		sb t2, 1(s0)
		sb t3, 0(s1)
		sb t4, 1(s1)

		# Restore saved registers from the stack before returning
		lw ra, 36(sp)            # Restore return address (ra) from the stack
		lw s0, 32(sp)            
		lw s1, 28(sp)            
		lw s2, 24(sp)            
		lw s3, 20(sp)            
		lw s4, 16(sp)            
		lw t1, 12(sp)            
		lw t2, 8(sp)            
		lw t3, 4(sp)            
		lw t4, 0(sp)            
		addi sp, sp, 40          # Deallocate space on the stack

		jr ra


move_portal_right:

	portal_move_right:
    addi sp, sp, -40        # Allocate space on the stack to save registers
    sw ra, 36(sp)           # Save return address (ra) to the stack
    sw s0, 32(sp)           
    sw s1, 28(sp)           
    sw s2, 24(sp)           
    sw s3, 20(sp)           
    sw s4, 16(sp)           
    sw t1, 12(sp)           
    sw t2, 8(sp)            
    sw t3, 4(sp)            
    sw t4, 0(sp)            

    la s0, character        # s0 has the base address of the character
    la s1, box              # s1 has the base address of the box

    li s2, 1                # s2 has the first valid row/column on the grid

    la a0, gridsize
    lb s3, 0(a0)            # s3 has the grid size (rows)
    addi s3, s3, -1         # s3 has the last row on the grid

    lb s4, 1(a0)            # s4 has the grid size (cols)
    addi s4, s4, -1         # s4 has the last col on the grid

    lb t1, 0(s0)            # t1 has the x-coordinate of the character
    lb t2, 1(s0)            # t2 has the y-coordinate of the character
    lb t3, 0(s1)            # t3 has the x-coordinate of the box
    lb t4, 1(s1)            # t4 has the y-coordinate of the box

    # Move the character right
    addi t2, t2, 1

    beq t2, s4, portal_move_right_character

    j normal_move_right_character

	portal_move_right_character:

		mv t2, s2                # Wrap to the first column if out of bounds

	normal_move_right_character:

		beq t4, t2, match_right_x_coordinate
		j portal_right_move_end

	match_right_x_coordinate:

		beq t3, t1, move_box_right
		j portal_right_move_end

	move_box_right:

		addi t4, t4, 1

		beq t4, s4, portal_move_right_box

		j portal_right_move_end

	portal_move_right_box:

		mv t4, s2                # Wrap box to the first column

	portal_right_move_end:

		sb t1, 0(s0)
		sb t2, 1(s0)
		sb t3, 0(s1)
		sb t4, 1(s1)

		# Restore saved registers from the stack before returning
		lw ra, 36(sp)            # Restore return address (ra) from the stack
		lw s0, 32(sp)            
		lw s1, 28(sp)            
		lw s2, 24(sp)            
		lw s3, 20(sp)            
		lw s4, 16(sp)            
		lw t1, 12(sp)            
		lw t2, 8(sp)            
		lw t3, 4(sp)            
		lw t4, 0(sp)            
		addi sp, sp, 40          # Deallocate space on the stack

		jr ra
	
		
set_starting_coordinates:
	
	addi sp, sp, -28        # Allocate space on the stack to save registers
    sw ra, 24(sp)           # Save return address (ra) to the stack
	sw s0, 20(sp)			# Save s0 to the stack
	sw s1, 16(sp)			# Save s1 to the stack
    sw s2, 12(sp)           # Save s2 to the stack
	sw s3, 8(sp)			# Save s3 to the stack
	sw s4, 4(sp)			# Save s4 to the stack
	sw s5, 0(sp)			# Save s5 to the stack

	lb s0, 0(a0)			# s0 has the x-coordinate of the character
	lb s1, 1(a0)			# s1 has the y-coordinate of the character
	
	# Setting up the starting coordinate for the character

	la a0, starting_coordinate_character
	sb s0, 0(a0)				
	sb s1, 1(a0)			
	

	lb s2, 0(a1)			# s2 has the x-coordinate of the box
	lb s3, 1(a1)			# s3 has the y-coordinate of the box

	# Setting up the starting coordinate for the box

	la a1, starting_coordinate_box
	sb s2, 0(a1)				
	sb s3, 1(a1)

	lb s4, 0(a2)			# s4 has the x-coordinate of the target
	lb s5, 1(a2)			# s5 has the y-coordinate of the target

	# Setting up the starting coordinate for the target

	la a2, starting_coordinate_target
	sb s4, 0(a2)				
	sb s5, 1(a2)

	# Restore saved registers from the stack before returning
    lw ra, 24(sp)			# Restore return address (ra) from the stack
    lw s0, 20(sp)			# Restore s0 from the stack
	lw s1, 16(sp)			# Restore s1 from the stack
	lw s2, 12(sp)			# Restore s2 from the stack
	lw s3, 8(sp)			# Restore s3 from the stack
	lw s4, 4(sp)			# Restore s4 from the stack
	lw s5, 0(sp)			# Restore s5 from the stack
    addi sp, sp, 28         # Deallocate space on the stack

    jr ra	

play_game:

		addi sp, sp, -4		# Allocate space on the stack to save registers
		sw ra, 0(sp)		# Save return address (ra) to the stack
		
	
		play_game_loop:

			la a0, box
			lb t1, 0(a0)		# t1 has the x-coordinate of the box
			lb t2, 1(a0)		# t2 has the y-coordinate of the box

			la a0, target	
			lb t3, 0(a0)		# t3 has the x-coordinate of the target
			lb t4, 1(a0)		# t4 has the y-coordinate of the target

			# print a newline after every move

			la a0, newline
			li a7, 4
			ecall

			bne t1, t3, continue_loop	# if not the same x-coordinate, we continue


			# if the box and the target have the same x-coordinate, we check the y-coordinate
			check_same_y_coordinate:

				beq t2, t4, end_game_loop 		# if the y-coordinates match, end the game.

			continue_loop:

				la a0, prompt			# print the prompt to ask for a move
				li a7, 4
				ecall

				li a7, 12				# read the inputted character
				ecall

				mv t0, a0				# t0 has the input from the user

				la a0, newline
				li a7, 4
				ecall

				check_move_up:

					la t5, char_W				# t5 has the base address of char_W
					lb t5, 0(t5)				# t5 has the char W

					# if the user input does not match, we check in other directions
					bne t0, t5, check_move_down

					jal move_up		# if it matches, we call the function move_up

					bnez a0, print_move_up_grid
					
					j play_game_loop
					
					print_move_up_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0
						
						j play_game_loop	# loop again for the next input

				check_move_down:

					la t5, char_S				# t5 has the base address of char_S
					lb t5, 0(t5)				# t5 has the char S

					# if the user input does not match, we check in other directions
					bne t0, t5, check_move_left

					jal move_down		# if it matches, we call the function move_down

					bnez a0, print_move_down_grid
					
					j play_game_loop
					
					print_move_down_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						j play_game_loop	# loop again for the next input

				check_move_left:

					la t5, char_A				# t5 has the base address of char_A
					lb t5, 0(t5)				# t5 has the char A

					# if the user input does not match, we check in other directions
					bne t0, t5, check_move_right

					jal move_left		# if it matches, we call the function move_left

					bnez a0, print_move_left_grid	
					
					j play_game_loop
					
					print_move_left_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0
						
						j play_game_loop	# loop again for the next input

				check_move_right:

					la t5, char_D			# t5 has the base address of char_D
					lb t5, 0(t5)			# t5 has the char D

					# if the user input does not match, we check if they want to reset
					bne t0, t5, check_move_reset

					jal move_right	# if it matches, we call the function move_right	

					bnez a0, print_move_right_grid
					
					j play_game_loop
					
					print_move_right_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						j play_game_loop	# loop again for the next input

				check_move_reset:

					la t5, char_R			# t5 has the base address of char_R
					lb t5, 0(t5)			# t5 has the char R

					# if the user input does not match, we return invalid move
					bne t0, t5, return_invalid_move

					# if it matches we reset the locations of character, box and target on the
					# grid

					la a0, prompt_reset
					li a7, 4
					ecall
					
					li a7, 12
					ecall
					
					la t5, char_Y
					lb t5, 0(t5)
					
					bne t5, a0, check_no_input

					jal move_reset	# if it matches, we call the function move_reset
					
					la a0, newline
					li a7, 4
					ecall

					la a0, newline
					li a7, 4
					ecall
					
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
					
					j play_game_loop
					
					check_no_input:
					
					la t5, char_N
					lb t5, 0(t5)
					
					bne t5, a0, check_reset_invalid_input
					
					j skip_reset
					
					check_reset_invalid_input:

					la a0, newline
					li a7, 4
					ecall
					
					la a0, prompt_invalid_input
					ecall
					
					la a0, newline
					ecall
					
					j check_move_reset
									
					skip_reset:
			
					la a0, newline
					li a7, 4
					ecall
					
					j play_game_loop	# loop again for the next input			

				return_invalid_move:

					# print that the user input is invalid and request another move
					la a0, prompt_invalid
					li a7, 4
					ecall

					j play_game_loop	


		end_game_loop:

			la a0, prompt_win	# Indicate that the game has succesfully ended
			li a7, 4
			ecall

			# Ask the user if they want to play again
			prompt_for_new_game:

				la a0, newline
				ecall

				la a0, prompt_new_game		
				ecall

				li a7, 12
				ecall

				mv t0, a0	# t0 has the user input

				la a0, newline
				li a7, 4
				ecall

				la a0, char_Y
				lb a0, 0(a0)
				
				# If the input is not Y, we check against other inputs
				bne a0, t0, check_other_inputs

				# If the input was Y, we ask them to choose the gamemode they wish to play
				jal choose_gamemode
				
				j end_game
				
			check_other_inputs:

				la a0, char_N
				lb a0, 0(a0)
				
				# If the input is not N, it is an invalid input and we ask again
				bne t0, a0, user_input_invalid

				la a0, prompt_end_game	# print the thank you message
				li a7, 4
				ecall

				j end_game

				user_input_invalid:

					la a0, prompt_invalid_input
					li a7, 4
					ecall

					j prompt_for_new_game

			end_game:
			
			# Restore saved registers from the stack before returning
			lw ra, 0(sp)			# Restore return address (ra) from the stack
			addi sp, sp, 4			# Deallocate space on the stack
		
			jr ra

play_game_cheat:

		addi sp, sp, -28	# Allocate space on the stack to save registers
		sw ra, 24(sp)		# Save return address (ra) to the stack
		sw s0, 20(sp)		# Save s0 to the stack
		sw s1, 16(sp)		# Save s1 to the stack
		sw s2, 12(sp)		# Save s2 to the stack
		sw s3, 8(sp)		# Save s3 to the stack
		sw s4, 4(sp)		# Save s4 to the stack
		sw s5, 0(sp)		# Save s5 to the stack

		li s0, 0	# s0 accounts for the amount of space added on the stack

		addi s0, s0, 4
		addi sp, sp, -4

		la t5, character
		lb t5, 1(t5)
		sb t5, 3(sp)	# store the character's y-coordinate on the stack

		la t5, character
		lb t5, 0(t5)
		sb t5, 2(sp)	# store the character's x-coordinate on the stack

		la t5, box
		lb t5, 1(t5)
		sb t5, 1(sp)	# store the box's y-coordinate on the stack

		la t5, box
		lb t5, 0(t5)
		sb t5, 0(sp)	# store the box's x-coordinate on the stack

	
		play_game_cheat_loop:

			la a0, box
			lb t1, 0(a0)		# t1 has the x-coordinate of the box
			lb t2, 1(a0)		# t2 has the y-coordinate of the box

			la a0, target	
			lb t3, 0(a0)		# t3 has the x-coordinate of the target
			lb t4, 1(a0)		# t4 has the y-coordinate of the target

			# print a newline after every move

			la a0, newline
			li a7, 4
			ecall

			bne t1, t3, continue_cheat_loop	# if not the same x-coordinate, we continue


			# if the box and the target have the same x-coordinate, we check the y-coordinate
			check_same_y_cheat_coordinate:

				beq t2, t4, end_game_cheat_loop 		# if the y-coordinates match, end the game.

			continue_cheat_loop:

				la a0, prompt			# print the prompt to ask for a move
				li a7, 4
				ecall

				li a7, 12				# read the inputted character
				ecall

				mv t0, a0				# t0 has the input from the user

				la a0, newline
				li a7, 4
				ecall

				check_cheat_move_up:

					la t5, char_W				# t5 has the base address of char_W
					lb t5, 0(t5)				# t5 has the char W

					# if the user input does not match, we check in other directions
					bne t0, t5, check_cheat_move_down

					jal move_up		# if it matches, we call the function move_up

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack

					bnez a0, print_cheat_move_up_grid

					j play_game_cheat_loop
					
					print_cheat_move_up_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0
						
						j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_down:

					la t5, char_S				# t5 has the base address of char_S
					lb t5, 0(t5)				# t5 has the char S

					# if the user input does not match, we check in other directions
					bne t0, t5, check_cheat_move_left

					jal move_down		# if it matches, we call the function move_down
					
					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
			
					bnez a0, print_cheat_move_down_grid
					
					j play_game_cheat_loop
					
					print_cheat_move_down_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_left:

					la t5, char_A				# t5 has the base address of char_A
					lb t5, 0(t5)				# t5 has the char A

					# if the user input does not match, we check in other directions
					bne t0, t5, check_cheat_move_right

					jal move_left		# if it matches, we call the function move_left
					
					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
					
					bnez a0, print_cheat_move_left_grid	
					
					j play_game_cheat_loop
					
					print_cheat_move_left_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0
						
						j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_right:

					la t5, char_D			# t5 has the base address of char_D
					lb t5, 0(t5)			# t5 has the char D

					# if the user input does not match, we check if they want to reset
					bne t0, t5, check_cheat_move_reset

					jal move_right	# if it matches, we call the function move_right	
					
					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
					
					bnez a0, print_cheat_move_right_grid
					
					j play_game_cheat_loop
					
					print_cheat_move_right_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_reset:

					la t5, char_R			# t5 has the base address of char_R
					lb t5, 0(t5)			# t5 has the char R

					# if the user input does not match, we check if they want to undo
					bne t0, t5, check_cheat_move_undo

					# if it matches we reset the locations of character, box and target on the
					# grid

					la a0, prompt_reset
					li a7, 4
					ecall

					li a7, 12
					ecall
					
					la t5, char_Y
					lb t5, 0(t5)
					
					bne t5, a0, check_cheat_no_input

					la a0, newline
					li a7, 4
					ecall

					la a0, newline
					li a7, 4
					ecall

					jal move_reset	# if it matches, we call the function move_reset
					
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
					
					j play_game_cheat_loop
					
					check_cheat_no_input:
					
					la t5, char_N
					lb t5, 0(t5)
					
					bne t5, a0, reset_cheat_invalid_input
					
					j skip_cheat_reset
					
					reset_cheat_invalid_input:

					la a0, newline
					li a7, 4
					ecall
					
					la a0, prompt_invalid_input
					ecall
					
					la a0, newline
					ecall
					
					j check_cheat_move_reset

					skip_cheat_reset:

					la a0, newline
					li a7, 4
					ecall
					
					j play_game_cheat_loop	# loop again for the next input	

				check_cheat_move_undo:
				
					la t5, char_U			# t5 has the base address of char_U
					lb t5, 0(t5)			# t5 has the char U

					# if the user input does not match, we check for move teleport
					bne t0, t5, check_cheat_move_teleport

					# we first check if the character and the box are at the starting location
					la s2, starting_coordinate_character
					la s3, character
					
					# we check if the character's x-coordinate matches the its initial position
					lb s4, 0(s2)
					lb s5, 0(s3)

					beq s4, s5, match_y_coordinate_character
					
					j undo_move
					
					match_y_coordinate_character:
					
					lb s4, 1(s2)
					lb s5, 1(s3)

					beq s4, s5, match_x_coordinate_box
					
					j undo_move
					
					match_x_coordinate_box:
					
					la s2, starting_coordinate_box
					la s3, box
					
					lb s4, 0(s2)
					lb s5, 0(s3)
					
					beq s4, s5, match_y_coordinate_box
					
					j undo_move
					
					match_y_coordinate_box:
					
					lb s4, 1(s2)
					lb s5, 1(s3)
					
					beq s4, s5, undo_not_possible
					
					j undo_move
					
					undo_not_possible:
					
					la a0, prompt_undo_np
					li a7, 4
					ecall
					
					j play_game_cheat_loop					
					
					undo_move:
					# if it matches, we undo the move and return to the previous locations
					# of the character and the box on the grid

					addi sp, sp, 4

					la s1, box		# s1 has the base address of the box
					
					lb t5, 0(sp)	# we load x-box from the stack
					sb t5, 0(s1)	# we store x-box as the x-coordinate of the box
					lb t5, 1(sp)	# we load y-box from the stack
					sb t5, 1(s1)	# we store y-box as the y-coordinate of the box

					la s1, character
					
					lb t5, 2(sp)	# we load x-box from the stack
					sb t5, 0(s1)	# we store x-box as the x-coordinate of the box
					lb t5, 3(sp)	# we load y-box from the stack
					sb t5, 1(s1)	# we store y-box as the y-coordinate of the box
					
					mv a0, t6
					jal grid_setup
					mv t6, a0
					
					j play_game_cheat_loop

				check_cheat_move_teleport:
				
					la t5, char_T			# t5 has the base address of char_T
					lb t5, 0(t5)			# t5 has the char T

					# if the user input does not match, we check for instant win
					bne t0, t5, check_cheat_move_instant_win
					
					jal move_teleport

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
						
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
						
					j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_instant_win:

					la t5, char_X			# t5 has the base address of char_X
					lb t5, 0(t5)			# t5 has the char X

					# if the user input does not match, we check for portal up move
					bne t0, t5, check_cheat_move_portal_up
					
					jal move_instant_win

					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0

					j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_portal_up:
				
					la t5, char_I			# t5 has the base address of char_I
					lb t5, 0(t5)			# t5 has the char I

					# if the user input does not match, we check for portal down move
					bne t0, t5, check_cheat_move_portal_down

					jal move_portal_up

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
						
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
						
					j play_game_cheat_loop	# loop again for the next input

				check_cheat_move_portal_down:
				
					la t5, char_K			# t5 has the base address of char_K
					lb t5, 0(t5)			# t5 has the char K

					# if the user input does not match, we check for portal left move
					bne t0, t5, check_cheat_move_portal_left

					jal move_portal_down

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
						
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
						
					j play_game_cheat_loop	# loop again for the next input

				
				check_cheat_move_portal_left:
				
					la t5, char_J			# t5 has the base address of char_J
					lb t5, 0(t5)			# t5 has the char J

					# if the user input does not match, we check for portal right move
					bne t0, t5, check_cheat_move_portal_right

					jal move_portal_left

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
						
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
						
					j play_game_cheat_loop	# loop again for the next input
	
				check_cheat_move_portal_right:
				
					la t5, char_L			# t5 has the base address of char_L
					lb t5, 0(t5)			# t5 has the char L

					# if the user input does not match, we return invalid move
					bne t0, t5, return_invalid_cheat_move

					jal move_portal_right

					addi s0, s0, 4
					addi sp, sp, -4
					
					la t5, character
					lb t5, 1(t5)
					sb t5, 3(sp)	# store the character's y-coordinate on the stack

					la t5, character
					lb t5, 0(t5)
					sb t5, 2(sp)	# store the character's x-coordinate on the stack

					la t5, box
					lb t5, 1(t5)
					sb t5, 1(sp)	# store the box's y-coordinate on the stack

					la t5, box
					lb t5, 0(t5)
					sb t5, 0(sp)	# store the box's x-coordinate on the stack
						
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
						
					j play_game_cheat_loop	# loop again for the next input

				return_invalid_cheat_move:

					# print that the user input is invalid and request another move
					la a0, prompt_invalid
					li a7, 4
					ecall

					j play_game_cheat_loop	


		end_game_cheat_loop:

			la a0, prompt_win	# Indicate that the game has succesfully ended
			li a7, 4
			ecall

			# Ask the user if they want to play again
			prompt_for_new_cheat_game:

				la a0, newline
				ecall

				la a0, prompt_new_game		
				ecall

				li a7, 12
				ecall

				mv t0, a0	# t0 has the user input

				la a0, newline
				li a7, 4
				ecall

				la a0, char_Y
				lb a0, 0(a0)
				
				# If the input is not Y, we check against other inputs
				bne a0, t0, cheat_check_other_inputs

				# If the input was Y, we set up a new game
				jal choose_gamemode
				
				j end_game_cheat

			cheat_check_other_inputs:

				la a0, char_N
				lb a0, 0(a0)
				
				# If the input is not N, it is an invalid input and we ask again
				bne t0, a0, user_input_invalid_cheat

				la a0, prompt_end_game	# print the thank you message
				li a7, 4
				ecall

				j end_game_cheat

				user_input_invalid_cheat:

					la a0, prompt_invalid_input
					li a7, 4
					ecall

					j prompt_for_new_game

			end_game_cheat:

			add sp, sp, s0		# Remove all the space that was created on the stack
			
			# Restore saved registers from the stack before returning
			lw ra, 24(sp)			# Restore return address (ra) from the stack
			lw s0, 20(sp)			# Restore s0 from the stack
			lw s1, 16(sp)			# Restore s1 from the stack
			lw s2, 12(sp)			# Restore s2 from the stack
			lw s3, 8(sp)			# Restore s3 from the stack
			lw s4, 4(sp)			# Restore s4 from the stack
			lw s5, 0(sp)			# Restore s5 from the stack
			addi sp, sp, 28			# Deallocate space on the stack
		
			jr ra
			
play_game_mp_again:

	addi sp, sp, -4
	sw ra, 0(sp)

	# Ask the user if they want to play again
	prompt_for_new_mp_game:
	la a0, newline
	ecall

	la a0, prompt_new_game		
	ecall

	li a7, 12
	ecall

	mv t0, a0	# t0 has the user input

	la a0, newline
	li a7, 4
	ecall

	la a0, char_Y
	lb a0, 0(a0)

	# If the input is not Y, we check against other inputs
	bne a0, t0, check_other_inputs_mp

	# If the input was Y, we ask them to choose the gamemode they wish to play
	jal choose_gamemode

	j end_mp_game

	check_other_inputs_mp:

	la a0, char_N
	lb a0, 0(a0)

	# If the input is not N, it is an invalid input and we ask again
	bne t0, a0, user_input_invalid_mp

	la a0, prompt_end_game	# print the thank you message
	li a7, 4
	ecall

	j end_mp_game

	user_input_invalid_mp:

	la a0, prompt_invalid_input
	li a7, 4
	ecall

	j prompt_for_new_mp_game

	end_mp_game:
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	jr ra

play_game_mp:

		addi sp, sp, -36		# Allocate space on the stack to save registers
		sw ra, 32(sp)		# Save return address (ra) to the stack
		sw s0, 28(sp)		# Save s0 to the stack
		sw t0, 24(sp)
		sw t1, 20(sp)
		sw t2, 16(sp)
		sw t3, 12(sp)
		sw t4, 8(sp)
		sw t5, 4(sp)
		sw t6, 0(sp)
		
		li s0, 0			# s0 has the number of moves the player has played
							# This is set to 0 initially
							
		jal set_starting_coordinates
		
		play_game_mp_loop:

			la t5, box
			lb t1, 0(t5)		# t1 has the x-coordinate of the box
			lb t2, 1(t5)		# t2 has the y-coordinate of the box

			la t5, target	
			lb t3, 0(t5)		# t3 has the x-coordinate of the target
			lb t4, 1(t5)		# t4 has the y-coordinate of the target

			# print a newline after every move

			la a0, newline
			li a7, 4
			ecall

			bne t1, t3, continue_mp_loop	# if not the same x-coordinate, we continue


			# if the box and the target have the same x-coordinate, we check the y-coordinate
			check_same_mp_y_coordinate:

				beq t2, t4, end_game_mp_loop 		# if the y-coordinates match, end the game.

			continue_mp_loop:

				la a0, prompt			# print the prompt to ask for a move
				li a7, 4
				ecall
				
				la a0, 0x00000000
				li a7, 12				# read the inputted character
				ecall

				mv t0, a0				# t0 has the input from the user

				la a0, newline
				li a7, 4
				ecall

				check_mp_move_up:

					la t5, char_W				# t5 has the base address of char_W
					lb t5, 0(t5)				# t5 has the char W

					# if the user input does not match, we check in other directions
					bne t0, t5, check_mp_move_down

					jal move_up		# if it matches, we call the function move_up

					bnez a0, print_mp_move_up_grid
					
					j play_game_mp_loop
					
					print_mp_move_up_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0

						addi s0, s0, 1
						
						j play_game_mp_loop	# loop again for the next input

				check_mp_move_down:

					la t5, char_S				# t5 has the base address of char_S
					lb t5, 0(t5)				# t5 has the char S

					# if the user input does not match, we check in other directions
					bne t0, t5, check_mp_move_left

					jal move_down		# if it matches, we call the function move_down

					bnez a0, print_mp_move_down_grid
					
					j play_game_mp_loop
					
					print_mp_move_down_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						addi s0, s0, 1
						
						j play_game_mp_loop	# loop again for the next input

				check_mp_move_left:

					la t5, char_A				# t5 has the base address of char_A
					lb t5, 0(t5)				# t5 has the char A

					# if the user input does not match, we check in other directions
					bne t0, t5, check_mp_move_right

					jal move_left		# if it matches, we call the function move_left

					bnez a0, print_mp_move_left_grid	
					
					j play_game_mp_loop
					
					print_mp_move_left_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates
						mv t6, a0
						
						addi s0, s0, 1
						
						j play_game_mp_loop	# loop again for the next input

				check_mp_move_right:

					la t5, char_D			# t5 has the base address of char_D
					lb t5, 0(t5)			# t5 has the char D

					# if the user input does not match, we check if they want to reset
					bne t0, t5, check_mp_move_reset

					jal move_right	# if it matches, we call the function move_right	

					bnez a0, print_mp_move_right_grid
					
					j play_game_mp_loop
					
					print_mp_move_right_grid:
						
						mv a0, t6
						jal grid_setup	# finally we setup a grid after the updated coordinates	
						mv t6, a0
						
						addi s0, s0, 1
						
						j play_game_mp_loop	# loop again for the next input

				check_mp_move_reset:

					la t5, char_R			# t5 has the base address of char_R
					lb t5, 0(t5)			# t5 has the char R

					# if the user input does not match, we return invalid move
					bne t0, t5, return_invalid_mp_move

					# if it matches we reset the locations of character, box and target on the
					# grid

					la a0, prompt_reset
					li a7, 4
					ecall
					
					li a7, 12
					ecall
					
					la t5, char_Y
					lb t5, 0(t5)
					
					bne t5, a0, check_no_input_mp

					jal move_reset_mp	# if it matches, we call the function move_reset
					
					la a0, newline
					li a7, 4
					ecall

					la a0, newline
					li a7, 4
					ecall
					
					mv a0, t6
					jal grid_setup	# finally we setup a grid after the updated coordinates
					mv t6, a0
					
					j play_game_mp_loop
					
					check_no_input_mp:
					
					la t5, char_N
					lb t5, 0(t5)
					
					bne t5, a0, check_reset_invalid_input_mp
					
					j skip_reset_mp
					
					check_reset_invalid_input_mp:

					la a0, newline
					li a7, 4
					ecall
					
					la a0, prompt_invalid_input
					ecall
					
					la a0, newline
					ecall
					
					j check_mp_move_reset
									
					skip_reset_mp:
			
					la a0, newline
					li a7, 4
					ecall
					
					j play_game_mp_loop	# loop again for the next input			

				return_invalid_mp_move:

					# print that the user input is invalid and request another move
					la a0, prompt_invalid
					li a7, 4
					ecall

					j play_game_mp_loop	


		end_game_mp_loop:

			la a0, prompt_win	# Indicate that the game has succesfully ended
			li a7, 4
			ecall

			mv a0, s0

			jal move_reset
			
			# Restore saved registers from the stack before returning
			lw ra, 32(sp)		# Save return address (ra) to the stack
			lw s0, 28(sp)		# Save s0 to the stack
			lw t0, 24(sp)
			lw t1, 20(sp)
			lw t2, 16(sp)
			lw t3, 12(sp)
			lw t4, 8(sp)
			lw t5, 4(sp)
			lw t6, 0(sp)
			addi sp, sp, 36			# Deallocate space on the stack
		
			jr ra


play_sp:

	la a0, newline
	li a7, 4
	ecall

	la a0, prompt_welcome_sp
	ecall

	la a0, newline
	ecall
	
	addi sp, sp, -4
	sw ra, 0(sp)
		
	# TODO: Generate locations for the character, box, and target. Static
    # locations in memory have been provided for the (x, y) coordinates 
    # of each of these elements.
    # 
    # There is a notrand function that you can use to start with. It's 
    # really not very good; you will replace it with your own rand function
    # later. Regardless of the source of your "random" locations, make 
    # sure that none of the items are on top of each other and that the 
    # board is solvable.

	# Randomly generate a location for the box on the grid. The box cannot occupy
	# the corners of the internal grid.
	
		la a0, box 				# pass the base address of box as arg 1
		la a1, gridsize 		# pass the base address of gridsize as arg 2
		jal set_box_coordinate  # call the function set_box_coordinate

		
	# Randomly generate a location for the target on the grid. The location needs to be 
	# such so that the game is solvable.

		la a0, target				# pass the base address of target as arg 1
		la a1, gridsize				# pass the base address of gridsize as arg 2
		la a2, box					# pass the base address of box as arg 3
		jal set_target_coordinate	# call the function set_target_coordinate


	# Randomly generate a location for the character on the grid. This location is 
	# different than the location of the box and the target.
	
		la a0, character				# pass the base address of character as arg 1
		la a1, gridsize					# pass the base address of gridsize as arg 2
		la a2, box						# pass the base address of box as arg 3
		la a3, target					# pass the base address of target as arg 4
		jal set_character_coordinate	# call the function set_character_coordinate

	   
    # TODO: Now, print the gameboard. Select symbols to represent the walls,
    # character, box, and target. Write a function that uses the location of
    # the various elements (in memory) to construct a gameboard and that 
    # prints that board one character at a time.
    # HINT: You may wish to construct the string that represents the board
    # and then print that string with a single syscall. If you do this, 
    # consider whether you want to place this string in static memory or 
    # on the stack. 
	
	# Allocating space on the heap by (row*col)+row+1
	
		la t0, gridsize
		lb t1, 0(t0)		# t1 has the number of rows
		lb t2, 1(t0)		# t2 has the number of cols

		mul a0, t1, t2
		add a0, a0, t1
		addi a0, a0, 1

		# round up to the nearest largest multiple of 4
		addi a0, a0, 3
		
		andi a0, a0, -4

		li a7, 9
		ecall

		mv t6, a0			# t6 has the base address to the heap
	

	# Setting up the grid

			mv a0, t6
			jal grid_setup				# call the function grid_setup	
			mv t6, a0

    # TODO: Enter a loop and wait for user input. Whenever user input is
    # received, update the gameboard state with the new location of the 
    # player (and if applicable, box and target). Print a message if the 
    # input received is invalid or if it results in no change to the game 
    # state. Otherwise, print the updated game state.

	# You will also need to restart the game if the user requests it and 
    # indicate when the box is located in the same position as the target.
    # For the former, it may be useful for this loop to exist in a function,
    # to make it cleaner to exit the game loop.

	# Set up the starting coordinates for the character, box and target

	la a0, character				# pass the base address of character as arg 1
	la a1, box						# pass the base address of box as arg 2
	la a2, target					# pass the base address of target as arg 3
	jal set_starting_coordinates	# call the function set_starting_coordinates

	# Play the game

	jal play_game

	lw ra, 0(sp)
	addi sp, sp, 4
	
	jr ra

play_spwcc:

	la a0, newline
	li a7, 4
	ecall

	la a0, prompt_welcome_spwcc
	ecall

	la a0, newline
	ecall
	
	addi sp, sp, -4
	sw ra, 0(sp)

	# Randomly generate a location for the box on the grid. The box cannot occupy
	# the corners of the internal grid.
	
		la a0, box 				# pass the base address of box as arg 1
		la a1, gridsize 		# pass the base address of gridsize as arg 2
		jal set_box_coordinate  # call the function set_box_coordinate

		
	# Randomly generate a location for the target on the grid. The location needs to be 
	# such so that the game is solvable.

		la a0, target				# pass the base address of target as arg 1
		la a1, gridsize				# pass the base address of gridsize as arg 2
		la a2, box					# pass the base address of box as arg 3
		jal set_target_coordinate	# call the function set_target_coordinate


	# Randomly generate a location for the character on the grid. This location is 
	# different than the location of the box and the target.
	
		la a0, character				# pass the base address of character as arg 1
		la a1, gridsize					# pass the base address of gridsize as arg 2
		la a2, box						# pass the base address of box as arg 3
		la a3, target					# pass the base address of target as arg 4
		jal set_character_coordinate	# call the function set_character_coordinate

	   
    # TODO: Now, print the gameboard. Select symbols to represent the walls,
    # character, box, and target. Write a function that uses the location of
    # the various elements (in memory) to construct a gameboard and that 
    # prints that board one character at a time.
    # HINT: You may wish to construct the string that represents the board
    # and then print that string with a single syscall. If you do this, 
    # consider whether you want to place this string in static memory or 
    # on the stack. 
	
	# Allocating space on the heap by (row*col)+row+1
	
		la t0, gridsize
		lb t1, 0(t0)		# t1 has the number of rows
		lb t2, 1(t0)		# t2 has the number of cols

		mul a0, t1, t2
		add a0, a0, t1
		addi a0, a0, 1

		# round up to the nearest largest multiple of 4
		addi a0, a0, 3
		
		andi a0, a0, -4

		li a7, 9
		ecall

		mv t6, a0			# t6 has the base address to the heap
	

	# Setting up the grid

		mv a0, t6
		jal grid_setup				# call the function grid_setup	
		mv t6, a0

	# Set up the starting coordinates for the character, box and target

	la a0, character				# pass the base address of character as arg 1
	la a1, box						# pass the base address of box as arg 2
	la a2, target					# pass the base address of target as arg 3
	jal set_starting_coordinates	# call the function set_starting_coordinates

	# Play the game

	jal play_game_cheat

	lw ra, 0(sp)
	addi sp, sp, 4
	
	jr ra	

play_mp:

	la a0, newline
	li a7, 4
	ecall

	la a0, prompt_welcome_mp	# Print the welcome message for this gamemode
	ecall

	la a0, newline
	ecall

	la a0, prompt_num_players	# Prompt the player for the number of players
	ecall
	
	li a7, 5
	ecall
	
	la a1, num_players			# Store their input in num_players
	sw a0, 0(a1)

	# Save the ra and the registers on the stack	
	addi sp, sp, -80 
	sw s11, 76(sp)
	sw s10, 72(sp)
	sw s9, 68(sp)
	sw s8, 64(sp)
	sw s7, 60(sp)
	sw s6, 56(sp)
	sw s5, 52(sp)
	sw ra, 48(sp)
	sw s0, 44(sp)
	sw s1, 40(sp)
	sw s2, 36(sp)
	sw s3, 32(sp)
	sw s4, 28(sp)
	sw t0, 24(sp)
	sw t1, 20(sp)
	sw t2, 16(sp)
	sw t3, 12(sp)
	sw t4, 8(sp)
	sw t5, 4(sp)
	sw t6, 0(sp)

	# Randomly generate a location for the box on the grid. The box cannot occupy
	# the corners of the internal grid.
	
		la a0, box 				# pass the base address of box as arg 1
		la a1, gridsize 		# pass the base address of gridsize as arg 2
		jal set_box_coordinate  # call the function set_box_coordinate
		la t1, starting_coordinate_box_mp
		la t2, box
		lb t3, 0(t2)
		lb t4, 1(t2)
		sb t3, 0(t1)
		sb t4, 1(t1)

		
		
	# Randomly generate a location for the target on the grid. The location needs to be 
	# such so that the game is solvable.

		la a0, target				# pass the base address of target as arg 1
		la a1, gridsize				# pass the base address of gridsize as arg 2
		la a2, box					# pass the base address of box as arg 3
		jal set_target_coordinate	# call the function set_target_coordinate
		la t1, starting_coordinate_target_mp
		la t2, target
		lb t3, 0(t2)
		lb t4, 1(t2)
		sb t3, 0(t1)
		sb t4, 1(t1)

	# Randomly generate a location for the character on the grid. This location is 
	# different than the location of the box and the target.
	
		la a0, character				# pass the base address of character as arg 1
		la a1, gridsize					# pass the base address of gridsize as arg 2
		la a2, box						# pass the base address of box as arg 3
		la a3, target					# pass the base address of target as arg 4
		jal set_character_coordinate	# call the function set_character_coordinate
		la t1, starting_coordinate_character_mp
		la t2, character
		lb t3, 0(t2)
		lb t4, 1(t2)
		sb t3, 0(t1)
		sb t4, 1(t1)
	
	# Set up the starting coordinates for the character, box and target

    # TODO: Now, print the gameboard. Select symbols to represent the walls,
    # character, box, and target. Write a function that uses the location of
    # the various elements (in memory) to construct a gameboard and that 
    # prints that board one character at a time.
    # HINT: You may wish to construct the string that represents the board
    # and then print that string with a single syscall. If you do this, 
    # consider whether you want to place this string in static memory or 
    # on the stack. 
	
	# Allocating space on the heap by (row*col)+row+1
	
		la t0, gridsize
		lb t1, 0(t0)		# t1 has the number of rows
		lb t2, 1(t0)		# t2 has the number of cols

		mul a0, t1, t2
		add a0, a0, t1
		addi a0, a0, 1

		# round up to the nearest largest multiple of 4
		addi a0, a0, 3
		
		andi a0, a0, -4

		li a7, 9
		ecall

		mv t6, a0			# t6 has the base address to the heap

	la s0, num_players
	lw s0, 0(s0)			# s0 has the number of players playing the game
	
	# we now add memory to the heap
	slli a0, s0, 3
	addi a0, a0, 8
	li a7, 9
	ecall
	
	mv s1, a0				# s1 has the base of the heap
	andi s1, s1, -4
	mv s2, s1

	# now we empty the heap
	li t0, 1			# this is the index for emptying the heap

	la s0, num_players
	lw s0, 0(s0)			# s0 has the number of players playing the game
	
	empty_heap_loop:
	
	bgt t0, s0, empty_heap_loop_end
	
	li t1, 2147483642		# t1 has the largest number that can be stored in 4 bytes
	
	# we store the number in t1 on the heap
	sw t1, 0(s2)
	sw t1, 4(s2)
	
	# we increment the heap up and add 1 to the counter t0
	addi s2, s2, 8
	addi t0, t0, 1
	
	j empty_heap_loop
	
	empty_heap_loop_end:
	
	la s0, num_players
	lw s0, 0(s0)			# s0 has the number of players playing the game

	mv t0, s0				# t0 has the number of players as a counter
	
	play_mp_game_loop:
	
	beqz t0, end_mp_game_loop	# if the counter reaches 0, we end the loop
	
	la a0, newline
	li a7, 4
	ecall
	
	la a0, prompt_player_name	# we ask for the player's name
	ecall
	
	la a0, 0x00000000
	li a7, 8
	ecall
	
	# we store the player's name bit by bit into s4 
	la s4, player_name	# s4 has the base address to player_name
	lb t2, 0(a0)		# t1 has the first character of the input
	sb t2, 0(s4)		# store the first character of the input
	lb t2, 1(a0)		# t2 has the second character of the input
	sb t2, 1(s4)		# store the second character of the input
	lb t2, 2(a0)		# t3 has the third character of the input
	sb t2, 2(s4)		# store the third character of the input

	la t2, 0x00
	sb t2, 3(s4)		# store the null pointer as the last byte of the player name
	
	# we setup and print the grid
	mv a0, t6
	jal grid_setup
	mv t6, a0
		
	# we play the multi-player game
	jal play_game_mp
	
	# after a player has finished playing the game, we reset the board 
	# for the other player
	jal move_reset_mp
	
	mv s3, a0			# s3 has the current number of moves
	mv s2, s1			# s2 has the base address of the heap

	# we now setup the heap
	
	li t1, 1
	
	# we sort the players moves and put them on the heap after comparing them with
	# the moves already stored on the heap
	leaderboard_find_spot:
	
		bgt t1, s0, insert_heap_player
		lw t2, 4(s2)
		
		bge t2, s3, insert_curr_player
		
		# increment the heap up and the counter t1 by 1
		addi s2, s2, 8
		addi t1, t1, 1
		
		j leaderboard_find_spot
		
	insert_curr_player:
	
		# we load the name and the moves for the player on the heap into registers
		lw t3, 0(s2)
		lw t4, 4(s2)

		# we store the current player's name (bit by bit) and then their moves on the heap
		la s4, player_name
		lb t5, 0(s4)
		sb t5, 0(s2)
		lb t5, 1(s4)
		sb t5, 1(s2)
		lb t5, 2(s4)
		sb t5, 2(s2)
		la t5, 0x00
		sb t5, 3(s2)
		sw s3, 4(s2)
		
		# after that, we increment the heap up and the counter t1 by 1
		addi s2, s2, 8
		addi t1, t1, 1


	# we now need to shift all the moves on the leaderboard up by 1
	shift_leaderboard:
	
		bgt t1, s0, insert_heap_player
		
		# we first load the player name and their moves into registers
		lw t5, 0(s2)
		lw t6, 4(s2)
		
		# we store the current player's name and moves in those spots on the heap
		sw t3, 0(s2)
		sw t4, 4(s2)
		
		# we move the stored player's name and moves into the registers to be stored
		# after the heap is incremented up
		mv t3, t5
		mv t4, t6
		
		# we increment the heap and the counter accordingly
		addi s2, s2, 8
		addi t1, t1, 1
		
		# we repeat the process until the last player
		j shift_leaderboard
		
	# we manually add the last player on the heap. The player's name and moves are stored
	# in t3 and t4, we add it to the heap and run the loop again for the next player.
	insert_heap_player:

		sw t3, 0(s2)
		sw t4, 4(s2)
		
		addi t0, t0, -1
		j play_mp_game_loop
	
	# once all player's have played, we begin to set up the leaderboard to print it
	end_mp_game_loop:
		
		# we bring back the heap counter to the base, and the heap has now stored 
		# the player names and their moves in ascending order.
		mv s2, s1
		
		# we print the leaderboard prompt
		la a0, prompt_leaderboard
		li a7, 4
		ecall

		la a0, newline
		ecall
		
		# we set up the counter to print the leaderboard for every player
		li s10, 1

		show_leaderboard:
		
			# we stop when the counter equals or is greater than the number of players
			bgt s10, s0, stop_show_leaderboard

			# we print the allignment
			la a0, prompt_space1
			li a7, 4
			ecall
			
			# we print the position
			mv a0, s10
			li a7, 1
			ecall
			
			# we print the allignment 
			la a0, prompt_space2
			li a7, 4
			ecall
			
			# we print the player's name from the heap
			mv a0, s2
			li a7, 4
			ecall
			
			# we print the allignment 
			la a0, prompt_space3
			li a7, 4
			ecall
			
			# we reset the value in a0
			la a0, 0x00000000
			
			# we print the player's moves from the heap
			lw a0, 4(s2)
			li a7, 1
			ecall
			
			# we print a newline
			la a0, newline
			li a7, 4
			ecall
		
			# we increment the counter by 1 and the heap up by 8 to get the next
			# player's records
			addi s10, s10, 1
			addi s2, s2, 8
			
			j show_leaderboard
		
	stop_show_leaderboard:
	
	# we prompt the player if they would want to play again
	jal play_game_mp_again
	
	lw s11, 76(sp)
	lw s10, 72(sp)
	lw s9, 68(sp)
	lw s8, 64(sp)
	lw s7, 60(sp)
	lw s6, 56(sp)
	lw s5, 52(sp)
	lw ra, 48(sp)
	lw s0, 44(sp)
	lw s1, 40(sp)
	lw s2, 36(sp)
	lw s3, 32(sp)
	lw s4, 28(sp)
	lw t0, 24(sp)
	lw t1, 20(sp)
	lw t2, 16(sp)
	lw t3, 12(sp)
	lw t4, 8(sp)
	lw t5, 4(sp)
	lw t6, 0(sp)
	addi sp, sp, 80


# CITATION FOR PSEUDO RANDOM NUMBER GENERATOR
# Blackman, D., & Vigna, S. 2019. Xoshiro128++: Pseudorandom number generator. 
# Retrieved from https://prng.di.unimi.it/
notrand:
   
    addi sp, sp, -48  		# Allocate space on the stack to save all registers
	sw t0, 44(sp)			# Save t0 to the stack
	sw t1, 40(sp)			# Save t1 to the stack
	sw t2, 36(sp)			# Save t2 to the stack
	sw t3, 32(sp)			# Save t3 to the stack
	sw t4, 28(sp)			# Save t4 to the stack
	sw t5, 24(sp)			# Save t5 to the stack
	sw t6, 20(sp)			# Save t6 to the stack
    sw ra, 16(sp)           # Save ra to the stack
    sw s0, 12(sp)           # Save s0 to the stack
    sw s1, 8(sp)            # Save s1 to the stack
    sw s2, 4(sp)            # Save s2 to the stack
    sw s3, 0(sp)          	# Save s3 to the stack

    # Load the state variables into registers
    la t0, s          # Load base address of state array
    lw s0, 0(t0)      # s0 = s[0]
    lw s1, 4(t0)      # s1 = s[1]
    lw s2, 8(t0)      # s2 = s[2]
    lw s3, 12(t0)     # s3 = s[3]

    # Calculate result = rotl(s0 + s3, 7) + s0
    add t1, s0, s3     # t1 = s0 + s3
    li t2, 7           # Rotation amount
    call rotl          # Rotate t1 by 7, result in t1
    add t1, t1, s0     # t1 = result + s0

    # t = s1 << 9
    slli t2, s1, 9     # t2 = s1 << 9

    # Update state variables
    xor s2, s2, s0     # s2 ^= s0
    xor s3, s3, s1     # s3 ^= s1
    xor s1, s1, s2     # s1 ^= s2
    xor s0, s0, s3     # s0 ^= s3

    # s2 ^= t
    xor s2, s2, t2     # s2 ^= t

    # s3 = rotl(s3, 11)
    li t2, 11          # Rotation amount
    call rotl          # Rotate s3 by 11, result in s3

    # Store updated state back into memory
    sw s0, 0(t0)       # s[0] = s0
    sw s1, 4(t0)       # s[1] = s1
    sw s2, 8(t0)       # s[2] = s2
    sw s3, 12(t0)      # s[3] = s3

    # Generate final random number between 0 and a0 (max)
    remu a0, t1, a0    # a0 = (result % max)

    # Restore registers from the stack
    lw t0, 44(sp)			# Restore t0 from the stack
	lw t1, 40(sp)			# Restore t1 from the stack
	lw t2, 36(sp)			# Restore t2 from the stack
	lw t3, 32(sp)			# Restore t3 from the stack
	lw t4, 28(sp)			# Restore t4 from the stack
	lw t5, 24(sp)			# Restore t5 from the stack
	lw t6, 20(sp)			# Restore t6 from the stack
    lw ra, 16(sp)           # Restore ra from the stack
    lw s0, 12(sp)           # Restore s0 from the stack
    lw s1, 8(sp)            # Restore s1 from the stack
    lw s2, 4(sp)            # Restore s2 from the stack
    lw s3, 0(sp)          	# Restore s3 from the stack

    # Adjust the stack pointer back to its original position
    addi sp, sp, 48

    jr ra              # Return to caller

# Rotate left function: rotl(x, k)
rotl:
    sll t3, t1, t2     # t3 = x << k
    li t4, 32
    sub t4, t4, t2     # t4 = 32 - k
    srl t1, t1, t4     # t1 = x >> (32 - k)
    or t1, t1, t3      # t1 = (x << k) | (x >> (32 - k))
    jr ra              # Return from rotl
