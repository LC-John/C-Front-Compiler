#include <stdio.h>

void some_function(int*);

int main()
{
	some_function("hello world!");
	return 0;
}

void some_function(int *a) {
	printf("%d\n", *a);
	return;
}