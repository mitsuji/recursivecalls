// $ gcc ffor.c

#include <stdio.h>
#include <stdint.h>

void ffor (int x) {
  for (;;) {
    char buff [0x10000];
    printf("x: %d\n",x);
    x ++;
  }
}


int main (int argc, char argv []) {
  ffor (0);
}
