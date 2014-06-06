;hello-os
;TAB=4

	ORG		0x7c00

;FAT12フォーマットFDのための記述

	JMP		entry
	DB		0x90
	DB		"HELLOIPL"
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
	DB		"HELLO-OS   "
	DB		"FAT12   "
	RESB	18

;プログラム本体

entry:
	MOV		AX,0
	MOV		SS,AX
	MOV		SP,0x7c00
	MOV		DS,AX

;ディスクを読む
	MOV		AX,0x8020
	MOV		ES,AX
	MOV		CH,0 	;シリンダ0
	MOV		DH,0 	;ヘッド0
	MOV		CL,2 	;セクタ2
	MOV		AH,0x02 ;ディスク読み込み
	MOV		AL,1 	;1セクタ
	MOV		BX,0 	;バッファアドレス=読み出したデータを保存する場所
	MOV		DL,0x00 ;Aドライブ
	INT		0x13
	JC		error

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
	HLT
	JMP		fin ;無限ループ

msg:
	DB		0x0a,0x0a
	DB		"Hello, world"
	DB		0x0a
	DB		0

	RESB	0x7dfe-$

	DB		0x55,0xaa

