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
যদি       {return(IF);}
নাহলে     {return(ELSE);}
ফেরত     {return(RETURN);}
যতক্ষণ     {return(WHILE);}
করো      {return(DO);}
যতক্ষননা    {return(UNTIL);}
কার্য      {return(FUNDEC);}
ধরো      {return(VAR);}
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
{number}     {return(INTVAL);}
{str}   {yylval.stringvalue=yytext;return(STRVAL);}
.       {return(yytext[0]);}

%%
