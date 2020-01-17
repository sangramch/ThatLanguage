%define parse.error verbose

%{
	#include<ctype.h>
	#include<stdio.h>

	int yylex();

	int yyerror(const char *s){
		printf("%s\n",s);
	}
%}

%union{
	int intvalue;
	char* stringvalue;
}

%token RETURN "ret" DO "do" WHILE "while" UNTIL "until" IF "if" ELSE "el" VAR "def" FUNDEC "decl" IDENT INTVAL STRVAL
%token AND "&&" OR "||" XOR "^^" EQ "==" NE "!=" LE "<=" GE ">=" PP "++" MM "--" PE "+=" ME "-="

%right "then" "el"
%left ','
%right '?' ':' "+=" "-="
%left "||"  '='
%left "&&" "^^"
%left "==" "!=" "<=" ">=" '<' '>'
%left '+' '-'
%left '*' '/' '%'
%left "**"
%right '$' "++" "--" '@' '!'
%left '(' '['
%left UMINUS

%%
	library:
		functions
	;

	functions:
		functions "decl" IDENT '('paramdecls')' block {printf("Recognised Function");}
	|	%empty
	;

	paramdecls:
		paramlist
	|	%empty
	;

	paramlist:	
		paramlist ',' IDENT
	|	IDENT
	;

	block:		
		nest_block'}'
	|	stmt
	;

	nest_block:	'{' |nest_block block;

	stmt:		
		"while" '('exprs')' block
	|	"do" block "while" '('exprs')'
	|	"until" '('exprs')' block
	|	"do" block "until" '('exprs')'
	|	"ret" exprs';'
	|	exprs';'
	|	"if" '('exprs')' block "el" block
	|	"if" '('exprs')' block	%prec "then"
	|	';'
	;

	var_decl:
		"def" var_decl1
	|	var_decl','var_decl1
	;

	var_decl1:
		IDENT'='expr
	|	IDENT
	;

	exprs:
		var_decl
	|	expr
	|	exprs1','expr
	;

	exprs1:
		expr
	|	exprs1','expr
	;

	expr:		
		INTVAL
	|	STRVAL {printf("%s",yylval.stringvalue);}
	|	IDENT
	|	expr'('')'
	|	expr'('exprs1')'
	|	expr'['exprs']'
	|	'-'expr %prec UMINUS
	|	'!'expr
	|	'$'expr
	|	'@'expr
	|	expr"++"
	|	expr"--"
	|	expr'+'expr {printf("Recognised Addition");}
	|	expr'-'expr
	|	expr'*'expr
	|	expr'/'expr
	|	expr'%'expr
	|	expr'>'expr
	|	expr'<'expr
	|	expr">="expr
	|	expr"<="expr
	|	expr'='expr
	|	expr"=="expr
	|	expr"+="expr
	|	expr"-="expr
	|	expr"!="expr
	|	expr"||"expr
	|	expr"&&"expr
	|	expr"^^"expr
	|	expr"**"expr
	|	expr'?'expr':'expr
	;

%%

int main()
{
  yyparse();
  return 1;
}