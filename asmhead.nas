;haribote

CYLS	EQU	0x0ff0	;�u�[�g�Z�N�^��ݒ肷��

;�L�[�{�[�h��LED��Ԃ̊i�[�Ԓn
LEDS	EQU	0x0ff1

;�X�N���[�����[�h�ݒ�̊i�[�Ԓn
VMODE	EQU	0x0ff2  ;�F��
SCRNX	EQU	0x0ff4  ;X�����𑜓x
SCRNY	EQU	0x0ff6  ;Y�����𑜓x
VRAM	EQU	0x0ff8  ;�O���t�B�b�N�o�b�t�@�̊J�n�A�h���X

		ORG	0xc200
		MOV	AL,0x13 
		MOV	AH,0x00
		INT	0x10	;�X�N���[���ݒ�
		MOV BYTE [VMODE],8
		MOV WORD [SCRNX],320
		MOV WORD [SCRNY],200
		MOV DWORD [VRAM],0x000a0000

;�L�[�{�[�h��LED��Ԃ�BIOS�o�R�Ŏ擾

		MOV AH,0x12
		INT 0x16
		MOV [LEDS],AL

fin:
		HLT
		JMP		fin
