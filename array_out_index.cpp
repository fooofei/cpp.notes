
#include <stdio.h>
#include <stdint.h>


int main()
{

  uint32_t i = 0;
  uint8_t b[1028];


  /* on Windows not crash, but core dumped on linux */
  b[i] = b[i - 1];

  return 0;
}