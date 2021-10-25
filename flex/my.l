%{
typedef enum {
    IntConstant=1000,Float,Int,Var,Operator,Line,Return,If,Else,Def,Fuzhi,Maohao,Method
} TokenType;

int error=9999;
%}
DIGTALS ([0-9]+)
INTEGER ([1-9]+[0-9]*)
LETTERS ([a-zA-Z]+)
VAR (var_)([0-9a-zA-Z]+)
METHOD (method_)([0-9a-zA-Z]+)
FLOAT ([0-9]+[.][0-9]*)
OPERATORS ([+*-/%=(),])

%%
[ \t\r\a]+          { /* 忽略掉所有的空格 */               }
":="   {return Fuzhi;}
":"    {return Maohao;}
[\n]   {return Line;}
"INT"  {return Int;}
"FLOAT" {return Float;}
"DEF"   {return Def;}
{METHOD} {return Method;}
{OPERATORS} { return Operator;}
{INTEGER} { return IntConstant;}
{VAR}     { return Var;}
{FLOAT}   { return Float;}


%%
int main( char* argv[]) {
    // printf("参数%s",argv[0]);
    int token=-1;
    char s[20];
    while (token=yylex()) {
        if(token==1005){
            //换行
            printf("token:%d", token);
            printf("  内容:\\n \n");
            continue;

        }
        printf("token:%d", token);
        sscanf(yytext,"%s",s);
        printf("  内容:%s\n",s);
    }
    return 0;
}
int yywrap(void) {
    return 1;
}