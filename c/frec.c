// $ gcc -g frec.c
// $ gcc -O2 -g frec.c

#include <stdio.h>
#include <stdint.h>

void frec (int x) {
  char buff [0x10000];
  printf("x: %d\n",x);
  frec (x+1);
}

int main (int argc, char argv []) {
  frec (0);
}


