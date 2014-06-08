;naskfunk

[FORMAT "WCOFF"] ;オブジェクトファイルを作るモード
[INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]		;32bitモード用の機械語を作る
[FILE "naskfunc.nas"]

		GLOBAL _io_hlt, _io_cli,io_sti,io_stihlt
		GLOBAL _io_in8, _io_in16, _io_in32
		GLOBAL _io_out8,_io_out16,_io_out32
		GLOBAL _io_load_eflags, _io_store_eflags 

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

