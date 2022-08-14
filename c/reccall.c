// $ gcc -g reccall.c
// $ gcc -O2 -g reccall.c

#include <stdio.h>
#include <stdint.h>

uint64_t series1 (uint64_t x);
uint64_t series2 (uint64_t x, uint64_t acc);

void ffor (int x);
void frec (int x);

int main (int argc, char argv []) {
  printf("%lu\n", series1(10000000));
//  printf("%lu\n", series2(10000000,0));

  //  ffor (0);
  //  frec (0);
}


// -O2 で使える
uint64_t series1 (uint64_t x) {
  if (x == 0)
	return 0;
  else
	return x + series1 (x-1);
}

// -O2 で使える
uint64_t series2 (uint64_t x, uint64_t acc) {
  if (x == 0)
	return acc;
  else
	return series2 (x-1, acc+x);
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

