/* bootpack‚ÌƒƒCƒ“ */

#include "bootpack.h"

void HariMain(void)
{
		struct BOOTINFO *binfo = (struct BOOTINFO *) 0x0ff0;
		char s[40];
		
		init_palette();
		init_screen8(binfo->vram,binfo->scrnx,binfo->scrny);
		
		putfonts8_asc(binfo->vram,binfo->scrnx,8,8,COL8_FFFFFF,"ABC 123");
		putfonts8_asc(binfo->vram,binfo->scrnx,31,31,COL8_000000,"haribote OS");
		putfonts8_asc(binfo->vram,binfo->scrnx,30,30,COL8_FFFFFF,"haribote OS");

		sprintf(s, "*scrnx = %d", binfo->scrnx);
		putfonts8_asc(binfo->vram,binfo->scrnx,16,64,COL8_FFFFFF,s);
		
		for(;;){
				io_hlt();
		}
}



