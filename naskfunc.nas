;naskfunk

[FORMAT "WCOFF"] ;�I�u�W�F�N�g�t�@�C������郂�[�h
[BITS 32]		;32bit���[�h�p�̋@�B������

[FILE "naskfunc.nas"]

		GLOBAL _io_hlt

[SECTION .text]
_io_hlt: ;void io_hlt(void)
		HLT
		RET
