;haribote

CYLS	EQU	0x0ff0	;ブートセクタを設定する

;キーボードのLED状態の格納番地
LEDS	EQU	0x0ff1

;スクリーンモード設定の格納番地
VMODE	EQU	0x0ff2  ;色数
SCRNX	EQU	0x0ff4  ;X方向解像度
SCRNY	EQU	0x0ff6  ;Y方向解像度
VRAM	EQU	0x0ff8  ;グラフィックバッファの開始アドレス

		ORG	0xc200
		MOV	AL,0x13 
		MOV	AH,0x00
		INT	0x10	;スクリーン設定
		MOV BYTE [VMODE],8
		MOV WORD [SCRNX],320
		MOV WORD [SCRNY],200
		MOV DWORD [VRAM],0x000a0000

;キーボードのLED状態をBIOS経由で取得

		MOV AH,0x12
		INT 0x16
		MOV [LEDS],AL

fin:
		HLT
		JMP		fin
