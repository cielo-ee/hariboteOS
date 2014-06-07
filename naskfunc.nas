;naskfunk

[FORMAT "WCOFF"] ;オブジェクトファイルを作るモード
[BITS 32]		;32bitモード用の機械語を作る

[FILE "naskfunc.nas"]

		GLOBAL _io_hlt

[SECTION .text]
_io_hlt: ;void io_hlt(void)
		HLT
		RET
