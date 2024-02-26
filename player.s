
  AREA    |.text|, CODE, READONLY
  PRESERVE8;
  THUMB;


  EXPORT update_points_s

update_points_s FUNCTION	; char update_points_s(player_t *player, uint8_t target_info); add points earned in the last attempt to target.
	; r0 *player
	; r1 target_info
		PUSH          {r4-r7,lr}
		MOV           r2,r0
		MOVS          r3,#0x00
		LDRH          r0,[r2,#0x00]
		ADDS          r0,r0,#1
		STRH          r0,[r2,#0x00]
		AND           r0,r1,#0xFC
		CBZ           r0,label13
		AND           r0,r1,#0x02
		CBNZ          r0,label13
		LDRH          r5,[r2,#0x02]
		ADDS          r5,r5,#1
		STRH          r5,[r2,#0x02]
		UBFX          r0,r1,#2,#3
		UBFX          r4,r1,#5,#2
		SUBS          r5,r0,#1
		ADDS          r6,r2,#6
		ADD           r5,r6,r5,LSL #2
		LDRB          r5,[r5,r4]
		ADDS          r5,r5,#1
		UXTB          r7,r5
		SUBS          r5,r0,#1
		ADD           r5,r6,r5,LSL #2
		STRB          r7,[r5,r4]
		ADDS          r3,r3,#1
		SUBS          r5,r0,#1
		ADD           r5,r6,r5,LSL #2
		LDRB          r5,[r5,r4]
		CMP           r5,r0
		BNE           label14
		ADD           r3,r3,r0
label14	NOP           
label13 LDRH          r0,[r2,#0x04]
		ADD           r0,r0,r3
		STRH          r0,[r2,#0x04]
		MOV           r0,r3
		POP           {r4-r7,pc}
		MOV	R0, #0					; 
		BX	LR						; return 0
  ENDFUNC
   

  EXPORT player_get_num_pieces_destroyed_s

player_get_num_pieces_destroyed_s FUNCTION	; int  player_get_num_pieces_destroyed_s (player_t * player);player_get_num_pieces_destroyed_s
	; r0 *player
		PUSH          {r4-r5,lr}
		MOV           r3,r0
		MOVS          r0,#0x00
		MOVS          r1,#0x00
		B             label1
label5 	MOVS          r2,#0x00
		B             label2
label4 	ADDS          r4,r3,#6
		ADD           r4,r4,r1,LSL #2
		LDRB          r5,[r4,r2]
		ADDS          r4,r1,#1
		CMP           r5,r4
		BNE           label3
		ADDS          r0,r0,#1
label3 	ADDS          r2,r2,#1
label2	RSB           r4,r1,#0x04
		CMP           r4,r2
		BGT           label4
		ADDS          r1,r1,#1
label1 	CMP           r1,#0x04
		BLT           label5
		POP           {r4-r5,pc}
		MOV	R0, #0				; 
		BX	LR						; return 0
  ENDFUNC
  
  EXPORT player_done_s

player_done_s FUNCTION	; char player_done_s(player_t * player);check if the player destroyed all pieces and the game has ended
	; r0 *player
		PUSH          {r4-r5,lr}
		MOV           r3,r0
		MOVS          r0,#0x01
		MOVS          r1,#0x00
		B             label6
label11	MOVS          r2,#0x00
		B             label7
label10	ADDS          r4,r3,#6
		ADD           r4,r4,r1,LSL #2
		LDRB          r5,[r4,r2]
		ADDS          r4,r1,#1
		CMP           r5,r4
		BGE           label8
		MOVS          r0,#0x00
		B             label9
label8 	ADDS          r2,r2,#1
label7	RSB           r4,r1,#0x04
		CMP           r4,r2
		BGT           label10
label9 	NOP           
		ADDS          r1,r1,#1
label6 	CMP           r1,#0x04
		BLT           label11
		POP           {r4-r5,pc}
		MOV	R0, #0				; 
		BX	LR						; return 0
  ENDFUNC
  
  END