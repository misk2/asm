#include <stdio.h>
int main(){
	int x=0x39D;
	int y;
	asm(
		"mov eax,%1;"
		"xor ebx,ebx;"
	"petla:"	
		"shl eax;"
		"jnc skok;"
		"inc ebx;"
	"skok:"
		"and eax,eax;"
		//"cmp eax,0;"
		"jnz petla;"
		"mov %0,ebx;"	
		:"=r"(y)
		:"r"(x)
		:"eax","ebx","ecx"
	);
	
	printf("x=%i y=%i\n",x,y);
	return 0;
		}