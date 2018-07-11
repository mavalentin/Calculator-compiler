# Calculator-compiler
### Compiling and running
`flex -l calc-lex.l`  
`yacc -vd calc-yacc.y`  
`gcc y.tab.c -ly -ll -lm`  
`./a.out`

### Info
Supported mathematical operations: +-*/!^%, sqrt(x)  
() parentheses and || absolute value

`5%100` results to: 5  
decimal numbers depend on used system locale (comma or point)

Variable assignment: `x=5`  
Display variable value: `x`  
Variables can be used inside the mathematical operations: `x+y`  
Non-defined variables will cause a "not defined" warning, but will be used as value 0 for the performed operation
