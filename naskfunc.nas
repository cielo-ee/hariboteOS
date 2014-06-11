;naskfunk

[FORMAT "WCOFF"] ;オブジェクトファイルを作るモード
[INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]		;32bitモード用の機械語を作る
[FILE "naskfunc.nas"]

		GLOBAL _io_hlt, _io_cli,_io_sti,io_stihlt ;なぜio_stihltだけ_がつかない？
		GLOBAL _io_in8, _io_in16, _io_in32
		GLOBAL _io_out8,_io_out16,_io_out32
		GLOBAL _io_load_eflags, _io_store_eflags 
		GLOBAL _load_gdtr,_load_idtr
		GLOBAL	_asm_inthandler21, _asm_inthandler2c
		EXTERN	_inthandler21, _inthandler2c

[SECTION .text]
_io_hlt: ;void io_hlt(void)
		HLT
		RET

_io_cli: ;void io_cli(void);
		CLI
		RET

_io_sti: ;void_io_sti(void);
		STI
		RET

_io_stihlt: ;void io_stihlt(void);
		STI
		HLT
		RET

_io_in8: ; int io_in8(int port);
		MOV		EDX,[ESP+4] ;port
		MOV		EAX,0
		IN		AL,DX
		RET

_io_in16: ; int io_in16(int port);
		MOV 	EDX,[ESP+4] ;port
		MOV		EAX,0
		IN		AX,DX
		RET

_io_in32: ; int io_in32(int port);
		MOV		EDX,[ESP+4] ;port
		IN		EAX,DX
		RET

_io_out8: ; void io_out8(int port, int data);
		MOV		EDX,[ESP+4] ;port
		MOV		EAX,[ESP+8] ;data
		OUT		DX,AL
		RET

_io_out16: ;  void io_out16(int port,int data);
		MOV		EDX,[ESP+4] ;port
		MOV		EAX,[ESP+8] ;data
		OUT		DX,AX

_io_out32: ; void io_out32(int port,int data);
		MOV		EDX,[ESP+4] ;port
		MOV		EAX,[ESP+8] ;data
		OUT		DX,EAX
		RET

_io_load_eflags: ; void io_store_eflags(void);
		PUSHFD ;
		POP 	EAX
		RET

_io_store_eflags: ; void io_store_eflags(int eflags);
		MOV		EAX,[ESP+4]
		PUSH 	EAX
		POPFD
		RET

_load_gdtr: ;void load_gdtr(int limit,int addr);
		MOV		AX,[ESP+4]	; limit
		MOV		[ESP+6],AX
		LGDT	[ESP+6]
		RET

_load_idtr:		; void load_idtr(int limit, int addr);
		MOV		AX,[ESP+4]		; limit
		MOV		[ESP+6],AX
		LIDT	[ESP+6]
		RET

_asm_inthandler21:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler21
		POPAD
		POP		DS
		POP		ES
		IRETD

_asm_inthandler2c:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler2c
		POP		EAX
		POPAD
		POP		DS
		POP		ES
		IRETD
