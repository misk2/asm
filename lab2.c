#include <stdio.h>
int main(){
	int x=0x39D;
	int y;
	asm(
		"mov eax,%1;"
		"mov ecx,0;"
		"mov ebx,0;"
	"petla:"	
		"shl eax;"
		"jnc skok;"
		"add ebx,1;"
	"skok:"
		"add ecx,1;"
		"cmp ecx,32;"
		"jnz petla;"
		"mov %0,ebx;"	
		:"=r"(y)
		:"r"(x)
		:"eax","ebx","ecx"
	);
	
	printf("x=%i y=%i\n",x,y);
	return 0;
		}
