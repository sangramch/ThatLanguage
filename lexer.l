%option noyywrap

%{
    #include"parser.tab.h"
%}

delim   [ \t\n]
letter  [a-zA-Z]
digit   [0-9]
id      {letter}({letter}|{digit})*
number  {digit}+(E[+-]?{digit}+)?
ws      {delim}+
str     \".*\"

AND "&&" OR "||" XOR "^^" EQ "==" NE "!=" LE "<=" GE ">=" PP "++" MM "--" PE "+=" ME "-="

%%
{ws}    {/*no action at all*/}
if      {return(IF);}
el      {return(ELSE);}
ret     {return(RETURN);}
while   {return(WHILE);}
do      {return(DO);}
until   {return(UNTIL);}
decl    {return(FUNDEC);}
def     {return(VAR);}
"&&"    {return(AND);}
"||"    {return(OR);}
"^^"    {return(XOR);}
"=="    {return(EQ);}
"!="    {return(NE);}
"<="    {return(LE);}
">="    {return(GE);}
"++"    {return(PP);}
"--"    {return(MM);}
"+="    {return(PE);}
"-="    {return(ME);}
{id}    {return(IDENT);}
{number}    {return(INTVAL);}
{str}   {yylval.stringvalue=yytext;return(STRVAL);}
.       {return(yytext[0]);}

%%
