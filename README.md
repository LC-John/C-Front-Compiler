# C-Front-Compiler

## Requirements

```
bison (GNU Bison) == 3.0.4
flex == 2.5.37
gcc == 4.8.5
```

You may compile this project under other environments, yet it may cause some trouble.

## Tokenizer

Run these commands.

```
$> make clean
$> make
```

The executable is ``./token``. The first argument is the input file path, and the second is the output file path.

```
$> ./token -I {InputFile} -O {OutputFile}
$> ./tree -I {InputFile} > {OutputFile}
```

## Tree Parser

Run these commands.

```
$> make clean
$> make
```

The executable is ``./tree``. The first argument is the input file path, and the second is the output file path.

```
$> ./tree -I {InputFile} -O {OutputFile}
$> ./tree -I {InputFile} > {OutputFile}
```

## Examples

A ``Hello World`` program may looks like this:

```
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

```

When tokenizing this C file, macros are removed first. Then the tokenized file looks like this:

```
void
some_function
(
int
*
)
;
int
main
(
)
{
some_function
(
"hello world!"
)
;
return
0
;
}
void
some_function
(
int
*
a
)
{
printf
(
"%d\n"
,
*
a
)
;
return
;
}
```

When parsing this C file, macros are removed first. Then the parsing tree looks like this:

```
[*] translation unit
  [*] <external_declaration>
    [*] <declaration>
      [*] <declaration_specifiers>
        [*] <type_specifier>
          [#] [void]
      [*] <init_declarator_list>
        [*] <init_declarator>
          [*] <declarator>
            [*] <direct_declarator>
              [*] <direct_declarator>
                [#] [some_function]
              [#] [(]
              [*] <parameter_type_list>
                [*] <parameter_list>
                  [*] <parameter_declaration>
                    [*] <declaration_specifiers>
                      [*] <type_specifier>
                        [#] [int]
                    [*] <abstract_declarator>
                      [*] <pointer>
                        [#] [*]
              [#] [)]
      [#] [;]
  [*] <external_declaration>
    [*] <function_definition>
      [*] <declaration_specifiers>
        [*] <type_specifier>
          [#] [int]
      [*] <declarator>
        [*] <direct_declarator>
          [*] <direct_declarator>
            [#] [main]
          [#] [(]
          [#] [)]
      [*] <compound_statement>
        [#] [{]
        [*] <block_item_list>
          [*] <block_item>
            [*] <statement>
              [*] <expression_statement>
                [*] <expression>
                  [*] <assignment_expression>
                    [*] <conditional_expression>
                      [*] <logical_or_expression>
                        [*] <logical_and_expression>
                          [*] <inclusive_or_expression>
                            [*] <exclusive_or_expression>
                              [*] <and_expression>
                                [*] <equality_expression>
                                  [*] <relational_expression>
                                    [*] <shift_expression>
                                      [*] <additive_expression>
                                        [*] <multiplicative_expression>
                                          [*] <cast_expression>
                                            [*] <unary_expression>
                                              [*] <postfix_expression>
                                                [*] <postfix_expression>
                                                  [*] <primary_expression>
                                                    [#] [some_function]
                                                [#] [(]
                                                [*] <argument_expression_list>
                                                  [*] <assignment_expression>
                                                    [*] <conditional_expression>
                                                      [*] <logical_or_expression>
                                                        [*] <logical_and_expression>
                                                          [*] <inclusive_or_expression>
                                                            [*] <exclusive_or_expression>
                                                              [*] <and_expression>
                                                                [*] <equality_expression>
                                                                  [*] <relational_expression>
                                                                    [*] <shift_expression>
                                                                      [*] <additive_expression>
                                                                        [*] <multiplicative_expression>
                                                                          [*] <cast_expression>
                                                                            [*] <unary_expression>
                                                                              [*] <postfix_expression>
                                                                                [*] <primary_expression>
                                                                                  [*] <string>
                                                                                    [#] ["hello world!"]
                                                [#] [)]
                [#] [;]
          [*] <block_item>
            [*] <statement>
              [*] <jump_statement>
                [#] [return]
                [*] <expression>
                  [*] <assignment_expression>
                    [*] <conditional_expression>
                      [*] <logical_or_expression>
                        [*] <logical_and_expression>
                          [*] <inclusive_or_expression>
                            [*] <exclusive_or_expression>
                              [*] <and_expression>
                                [*] <equality_expression>
                                  [*] <relational_expression>
                                    [*] <shift_expression>
                                      [*] <additive_expression>
                                        [*] <multiplicative_expression>
                                          [*] <cast_expression>
                                            [*] <unary_expression>
                                              [*] <postfix_expression>
                                                [*] <primary_expression>
                                                  [*] <constant>
                                                    [#] [0]
                [#] [;]
        [#] [}]
  [*] <external_declaration>
    [*] <function_definition>
      [*] <declaration_specifiers>
        [*] <type_specifier>
          [#] [void]
      [*] <declarator>
        [*] <direct_declarator>
          [*] <direct_declarator>
            [#] [some_function]
          [#] [(]
          [*] <parameter_type_list>
            [*] <parameter_list>
              [*] <parameter_declaration>
                [*] <declaration_specifiers>
                  [*] <type_specifier>
                    [#] [int]
                [*] <declarator>
                  [*] <pointer>
                    [#] [*]
                  [*] <direct_declarator>
                    [#] [a]
          [#] [)]
      [*] <compound_statement>
        [#] [{]
        [*] <block_item_list>
          [*] <block_item>
            [*] <statement>
              [*] <expression_statement>
                [*] <expression>
                  [*] <assignment_expression>
                    [*] <conditional_expression>
                      [*] <logical_or_expression>
                        [*] <logical_and_expression>
                          [*] <inclusive_or_expression>
                            [*] <exclusive_or_expression>
                              [*] <and_expression>
                                [*] <equality_expression>
                                  [*] <relational_expression>
                                    [*] <shift_expression>
                                      [*] <additive_expression>
                                        [*] <multiplicative_expression>
                                          [*] <cast_expression>
                                            [*] <unary_expression>
                                              [*] <postfix_expression>
                                                [*] <postfix_expression>
                                                  [*] <primary_expression>
                                                    [#] [printf]
                                                [#] [(]
                                                [*] <argument_expression_list>
                                                  [*] <assignment_expression>
                                                    [*] <conditional_expression>
                                                      [*] <logical_or_expression>
                                                        [*] <logical_and_expression>
                                                          [*] <inclusive_or_expression>
                                                            [*] <exclusive_or_expression>
                                                              [*] <and_expression>
                                                                [*] <equality_expression>
                                                                  [*] <relational_expression>
                                                                    [*] <shift_expression>
                                                                      [*] <additive_expression>
                                                                        [*] <multiplicative_expression>
                                                                          [*] <cast_expression>
                                                                            [*] <unary_expression>
                                                                              [*] <postfix_expression>
                                                                                [*] <primary_expression>
                                                                                  [*] <string>
                                                                                    [#] ["%d\n"]
                                                  [#] [,]
                                                  [*] <assignment_expression>
                                                    [*] <conditional_expression>
                                                      [*] <logical_or_expression>
                                                        [*] <logical_and_expression>
                                                          [*] <inclusive_or_expression>
                                                            [*] <exclusive_or_expression>
                                                              [*] <and_expression>
                                                                [*] <equality_expression>
                                                                  [*] <relational_expression>
                                                                    [*] <shift_expression>
                                                                      [*] <additive_expression>
                                                                        [*] <multiplicative_expression>
                                                                          [*] <cast_expression>
                                                                            [*] <unary_expression>
                                                                              [*] <unary_operator>
                                                                                [#] [*]
                                                                              [*] <cast_expression>
                                                                                [*] <unary_expression>
                                                                                  [*] <postfix_expression>
                                                                                    [*] <primary_expression>
                                                                                      [#] [a]
                                                [#] [)]
                [#] [;]
          [*] <block_item>
            [*] <statement>
              [*] <jump_statement>
                [#] [return]
                [#] [;]
        [#] [}]
```