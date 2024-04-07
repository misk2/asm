#include <stdio.h>
int main(){
		int x = 2024;
		int y;
		asm(
			"mov eax,%1;"
			"add eax,eax;"
			"mov %0,eax;"
			:"=r"(y)
			:"r"(x)
			:"eax","ebx"
		
		);
		printf("x=%i y=%i\n",x,y);
		return 0;
	}
