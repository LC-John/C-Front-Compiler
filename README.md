# C-Tokenizer

## Requirements

bison (GNU Bison) == 3.0.4

flex == 2.5.37

gcc == 4.8.5

## How2Use

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
