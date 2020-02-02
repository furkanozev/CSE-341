
I used parser for lexical analysis.
This means that in the event that some 2 tokens follow one after another, it works to show that this is a wrong token.
For example, (and+ 3) for and+, Instead of KW_AND OP_PLUS, my program give error message like "and+ cannot tokenized.".
Because there is no such token. But 2 token can come next to each other like "(and" and 2 token are tokenized  using the parser.

*********** PART 1 *******************
For compile and run:

	lex gpp_lexer.l 		=> It will reproduce a lex.yy.c file.
	gcc lex.yy.c
	./a.out

	OR

	gcc gpp_lexer.c
	./a.out

After run program, You must choose between 2 selections.
1. g++
2. g++ "filename.g++"

In the 1st selection, the program works as an interpreter.
In the 2st selection, File will be loaded by the interpreter and interpreted right away.

If you want to terminate the program, you must enter: ( exit )			=> please attention to the whitespace

I did this part using regular expressions in accordance with homework pdf and g++ syntax pdf.


*********** PART 2 *******************
For run:

	clisp gpp_lexer.lisp

After run program, You must choose between 2 selections.
1. (gppinterpreter)
2. (gppinterpreter "filename.g++")

! Please attention to the spaces when entering these (above) selections. For example ( gppinterpreter ) will give you error message.

In the 1st selection, the program works as an interpreter.
In the 2st selection, File will be loaded by the interpreter and interpreted right away.

If you want to terminate the program, you must enter: ( exit )

I did this part using DFA in accordance with homework pdf and g++ syntax pdf.



I added execution images to related files.
I created the test sample in the homework pdf as a file named "test.gpp".
I uploaded this file to the part folders.