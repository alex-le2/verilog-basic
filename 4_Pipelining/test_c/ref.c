#include <stdio.h>

int main() {
	FILE *fp;
	fp = fopen("ref_c.txt","w");
	for (int i = 0; i<100; i++){ 
		long result = 1;
		for(int j = 0; j < 8; j++) {
			result *= i; 
		}
		fprintf (fp, "result = %lu\n",result);
	}
	fclose(fp);
	return 0;
}
 
