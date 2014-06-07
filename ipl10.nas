;hello-os
;TAB=4

CYLS	EQU		10				; �ǂ��܂œǂݍ��ނ�

		ORG		0x7c00

;FAT12�t�H�[�}�b�gFD�̂��߂̋L�q

		JMP		entry
		DB		0x90
		DB		"HALIBOTE"
		DW		512
		DB		1
		DW		1
		DB		2
		DW		224
		DW		2880
		DB		0xf0
		DW		9
		DW		18
		DW		2
		DD		0
		DD		2880
		DB		0,0,0x29
		DD		0xffffffff
		DB		"HARIBOTEOS "
		DB		"FAT12   "
		RESB	18

;�v���O�����{��

entry:
		MOV		AX,0
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

;�f�B�X�N��ǂ�

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0 	;�V�����_0
		MOV		DH,0 	;�w�b�h0
		MOV		CL,2 	;�Z�N�^2
readloop:
		MOV		SI,0	;���s�񐔂𐔂���
retry:
		MOV		AH,0x02 ;�f�B�X�N�ǂݍ���
		MOV		AL,1 	;1�Z�N�^
		MOV		BX,0 	;�o�b�t�@�A�h���X=�ǂݏo�����f�[�^��ۑ�����ꏊ([ES:BX]��ES�͋L���ȗ�)
		MOV		DL,0x00 ;A�h���C�u
		INT		0x13	
		JNC		next	;�G���[���N���Ȃ����next��
		ADD		SI,1
		CMP		SI,5
		JAE		error
		MOV		AH,0x00
		MOV		DL,0x00	;A�h���C�u
		INT		0x13	;�h���C�u�̃��Z�b�g
		JMP		retry
next:
		MOV		AX,ES ;�A�h���X��0x200�i�߂�
		ADD		AX,0x0020
		MOV		ES,AX
		ADD		CL,1
		CMP		CL,18
		JBE		readloop
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop 

; �ǂݏI������̂�haribote.sys�����s���I�I�I�I�I�I�I�I�I�I�I�I�I�I�I

		MOV		[0x0ff0],CH		; IPL���ǂ��܂œǂ񂾂̂�������
		JMP		0xc200

error:
		MOV		AX,0
		MOV		ES,AX
		MOV		SI,msg		
putloop:
		MOV		AL,[SI]
		ADD		SI,1
		CMP		AL,0	;3C 00
		JE		fin	;74 09?
		MOV		AH,0x0e ;B4 0E
		MOV		BX,15	;B8 0F
		INT		0x10	;CD 10
		JMP		putloop
fin:
		HLT						; ��������܂�CPU���~������
		JMP		fin				; �������[�v
msg:
		DB		0x0a, 0x0a
		DB		"load error"
		DB		0x0a
		DB		0

		RESB	0x7dfe-$

		DB		0x55, 0xaa

�@