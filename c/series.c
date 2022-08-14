// $ gcc -g series.c
// $ gcc -g -O2 series.c

#include <stdio.h>
#include <stdint.h>

int64_t series (int64_t x) {
  if (x == 0)
    return 0;
  else
    return x + series (x-1);
}


int main (int argc, char argv []) {
  printf("%ld\n", series(10));
}

