%{
    #include "calculadora.tab.h" /* Arquivo gerado pelo Bison contendo os tokens */
    #include <stdlib.h>   /* Para a função atoi() */
%}

%%

[0-9]+      { 
                yylval = atoi(yytext); /* Converte a string para inteiro e salva o valor semântico */
                return NUM;            /* Retorna o token NUM para o Bison */
            }

[-+*/\n()]  { 
                return *yytext;        /* Retorna o próprio caractere como token */
            }

[ \t]       { /* Ignora espaços em branco e tabulações */ }

.           { 
                printf("Erro léxico: Caractere inválido '%c'\n", *yytext); 
            }

%%

/* Função obrigatória do Flex que indica o fim do arquivo de entrada */
int yywrap() { 
    return 1; 
}