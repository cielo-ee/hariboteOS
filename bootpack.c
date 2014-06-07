void io_hlt(void);
void write_mem8(int addr,int data);

void HariMain(void)
{
		int i;
		for(i = 0xa000; i <= 0xafffff; i++){
				write_mem8(i,15);
		}

		for(;;){
				io_hlt();
		}
}

