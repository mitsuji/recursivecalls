// $ gcc -g main.c
// $ gcc -O2 -g main.c

#include <stdio.h>
#include <stdint.h>

void ffor (int x);
void frec (int x);

int main (int argc, char argv []) {
  ffor (0);
  //  frec (0);
}

void ffor (int x) {
  for (;;) {
    char buff [0x10000];
    printf("x: %d\n",x);
    x ++;
  }
}

void frec (int x) {
  //  char buff [0x10000];
  printf("x: %d\n",x);
  frec (x+1);
}

