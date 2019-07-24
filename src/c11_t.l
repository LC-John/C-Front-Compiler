%e  1019
%p  2807
%n  371
%k  284
%a  1213
%o  1117

O   [0-7]
D   [0-9]
NZ  [1-9]
L   [a-zA-Z_]
A   [a-zA-Z_0-9]
H   [a-fA-F0-9]
HP  (0[xX])
E   ([Ee][+-]?{D}+)
P   ([Pp][+-]?{D}+)
FS  (f|F|l|L)
IS  (((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))
CP  (u|U|L)
SP  (u8|u|U|L)
ES  (\\(['"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))
WS  [ \t\v\n\f]

%{
#include <stdio.h>
#include "y.tab.h"

extern int yyerror(const char *);  /* prints grammar violation message */

extern int sym_type(const char *);  /* returns type from symbol table */

#define sym_type(identifier) IDENTIFIER /* with no symbol table, fake it */

extern FILE* yyout;

char token_sep = '`';
static void comment(void);
static int check_type(void);
static void print_token(const char *);
%}

%%
"/*"                                    { comment(); }
"//".*                                    { /* consume //-comment */ }

"#".*                   { /* consume macro */ }

"auto"					{ print_token(yytext); return(AUTO); }
"break"					{ print_token(yytext); return(BREAK); }
"case"					{ print_token(yytext); return(CASE); }
"char"					{ print_token(yytext); return(CHAR); }
"const"					{ print_token(yytext); return(CONST); }
"continue"				{ print_token(yytext); return(CONTINUE); }
"default"				{ print_token(yytext); return(DEFAULT); }
"do"					{ print_token(yytext); return(DO); }
"double"				{ print_token(yytext); return(DOUBLE); }
"else"					{ print_token(yytext); return(ELSE); }
"enum"					{ print_token(yytext); return(ENUM); }
"extern"				{ print_token(yytext); return(EXTERN); }
"float"					{ print_token(yytext); return(FLOAT); }
"for"					{ print_token(yytext); return(FOR); }
"goto"					{ print_token(yytext); return(GOTO); }
"if"					{ print_token(yytext); return(IF); }
"inline"				{ print_token(yytext); return(INLINE); }
"int"					{ print_token(yytext); return(INT); }
"long"					{ print_token(yytext); return(LONG); }
"register"				{ print_token(yytext); return(REGISTER); }
"restrict"				{ print_token(yytext); return(RESTRICT); }
"return"				{ print_token(yytext); return(RETURN); }
"short"					{ print_token(yytext); return(SHORT); }
"signed"				{ print_token(yytext); return(SIGNED); }
"sizeof"				{ print_token(yytext); return(SIZEOF); }
"static"				{ print_token(yytext); return(STATIC); }
"struct"				{ print_token(yytext); return(STRUCT); }
"switch"				{ print_token(yytext); return(SWITCH); }
"typedef"				{ print_token(yytext); return(TYPEDEF); }
"union"					{ print_token(yytext); return(UNION); }
"unsigned"				{ print_token(yytext); return(UNSIGNED); }
"void"					{ print_token(yytext); return(VOID); }
"volatile"				{ print_token(yytext); return(VOLATILE); }
"while"					{ print_token(yytext); return(WHILE); }
"_Alignas"                              { print_token(yytext); return ALIGNAS; }
"_Alignof"                              { print_token(yytext); return ALIGNOF; }
"_Atomic"                               { print_token(yytext); return ATOMIC; }
"_Bool"                                 { print_token(yytext); return BOOL; }
"_Complex"                              { print_token(yytext); return COMPLEX; }
"_Generic"                              { print_token(yytext); return GENERIC; }
"_Imaginary"                            { print_token(yytext); return IMAGINARY; }
"_Noreturn"                             { print_token(yytext); return NORETURN; }
"_Static_assert"                        { print_token(yytext); return STATIC_ASSERT; }
"_Thread_local"                         { print_token(yytext); return THREAD_LOCAL; }
"__func__"                              { print_token(yytext); return FUNC_NAME; }

{L}{A}*					{ print_token(yytext); return check_type(); }

{HP}{H}+{IS}?				{ print_token(yytext); return I_CONSTANT; }
{NZ}{D}*{IS}?				{ print_token(yytext); return I_CONSTANT; }
"0"{O}*{IS}?				{ print_token(yytext); return I_CONSTANT; }
{CP}?"'"([^'\\\n]|{ES})+"'"		{ print_token(yytext); return I_CONSTANT; }

{D}+{E}{FS}?				{ print_token(yytext); return F_CONSTANT; }
{D}*"."{D}+{E}?{FS}?			{ print_token(yytext); return F_CONSTANT; }
{D}+"."{E}?{FS}?			{ print_token(yytext); return F_CONSTANT; }
{HP}{H}+{P}{FS}?			{ print_token(yytext); return F_CONSTANT; }
{HP}{H}*"."{H}+{P}{FS}?			{ print_token(yytext); return F_CONSTANT; }
{HP}{H}+"."{P}{FS}?			{ print_token(yytext); return F_CONSTANT; }

({SP}?\"([^"\\\n]|{ES})*\"{WS}*)+	{ print_token(yytext); return STRING_LITERAL; }

"..."					{ print_token(yytext); return ELLIPSIS; }
">>="					{ print_token(yytext); return RIGHT_ASSIGN; }
"<<="					{ print_token(yytext); return LEFT_ASSIGN; }
"+="					{ print_token(yytext); return ADD_ASSIGN; }
"-="					{ print_token(yytext); return SUB_ASSIGN; }
"*="					{ print_token(yytext); return MUL_ASSIGN; }
"/="					{ print_token(yytext); return DIV_ASSIGN; }
"%="					{ print_token(yytext); return MOD_ASSIGN; }
"&="					{ print_token(yytext); return AND_ASSIGN; }
"^="					{ print_token(yytext); return XOR_ASSIGN; }
"|="					{ print_token(yytext); return OR_ASSIGN; }
">>"					{ print_token(yytext); return RIGHT_OP; }
"<<"					{ print_token(yytext); return LEFT_OP; }
"++"					{ print_token(yytext); return INC_OP; }
"--"					{ print_token(yytext); return DEC_OP; }
"->"					{ print_token(yytext); return PTR_OP; }
"&&"					{ print_token(yytext); return AND_OP; }
"||"					{ print_token(yytext); return OR_OP; }
"<="					{ print_token(yytext); return LE_OP; }
">="					{ print_token(yytext); return GE_OP; }
"=="					{ print_token(yytext); return EQ_OP; }
"!="					{ print_token(yytext); return NE_OP; }
";"					{ print_token(yytext); return ';'; }
("{"|"<%")				{ print_token(yytext); return '{'; }
("}"|"%>")				{ print_token(yytext); return '}'; }
","					{ print_token(yytext); return ','; }
":"					{ print_token(yytext); return ':'; }
"="					{ print_token(yytext); return '='; }
"("					{ print_token(yytext); return '('; }
")"					{ print_token(yytext); return ')'; }
("["|"<:")				{ print_token(yytext); return '['; }
("]"|":>")				{ print_token(yytext); return ']'; }
"."					{ print_token(yytext); return '.'; }
"&"					{ print_token(yytext); return '&'; }
"!"					{ print_token(yytext); return '!'; }
"~"					{ print_token(yytext); return '~'; }
"-"					{ print_token(yytext); return '-'; }
"+"					{ print_token(yytext); return '+'; }
"*"					{ print_token(yytext); return '*'; }
"/"					{ print_token(yytext); return '/'; }
"%"					{ print_token(yytext); return '%'; }
"<"					{ print_token(yytext); return '<'; }
">"					{ print_token(yytext); return '>'; }
"^"					{ print_token(yytext); return '^'; }
"|"					{ print_token(yytext); return '|'; }
"?"					{ print_token(yytext); return '?'; }

{WS}+					{ /* whitespace separates tokens */ }
.					{ /* discard bad characters */ }

%%

int yywrap(void)        /* called at end of input */
{
    return 1;           /* terminate now */
}

static void comment(void)
{
    int c;

    while ((c = input()) != 0)
        if (c == '*')
        {
            while ((c = input()) == '*')
                ;

            if (c == '/')
                return;

            if (c == 0)
                break;
        }
    yyerror("unterminated comment");
}

static int check_type(void)
{
    switch (sym_type(yytext))
    {
    case TYPEDEF_NAME:                /* previously defined */
        return TYPEDEF_NAME;
    case ENUMERATION_CONSTANT:        /* previously defined */
        return ENUMERATION_CONSTANT;
    default:                          /* includes undefined */
        return IDENTIFIER;
    }
}

static void print_token(const char * s)
{
    fprintf(yyout, "%s\n", s);
}