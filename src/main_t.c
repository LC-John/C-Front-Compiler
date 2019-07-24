#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern FILE* yyin;
extern FILE* yyout;

int main(int argc, char** argv)
{
    int i;
    for (i = 1; i < argc; i++)
    {
        // printf ("%s\n", argv[i]);
        if ((strcmp(argv[i], "-I") == 0) || (strcmp(argv[i], "--input") == 0))
        {
            yyin = fopen(argv[i+1], "r");
            if (yyin == NULL)
            {
                fprintf(stderr, "Cannot open %s\n", argv[i+1]);
                exit(-1);
            }
        }
        if ((strcmp(argv[i], "-O") == 0) || (strcmp(argv[i], "--output") == 0))
        {
            yyout = fopen(argv[i+1], "w");
            if (yyout == NULL)
            {
                fprintf(stderr, "Cannot open %s\n", argv[i+1]);
                exit(-1);
            }
        }
    }
    yyparse();
    return 0;
}