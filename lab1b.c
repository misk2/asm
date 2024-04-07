#include <stdio.h>
int main(){
		int x = 2024;
		int y = 0;
		asm(
			"mov eax,%1;"
			"add eax,eax;"
			"add eax,eax;"
			"add eax,%1;"
			"mov %0,eax;"
			"add eax,eax;"
			"add eax,eax;"
			"mov %0,eax;"
			:"=r"(y)
			:"r"(x)
			:"eax","ebx"
		
		);
		printf("x=%i y=%i\n",x,y);
		return 0;
	}
