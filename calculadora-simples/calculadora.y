%{
#include <stdio.h>
#include <stdlib.h>

/* Declarações das funções do Flex para evitar warnings no GCC */
int yylex(void);
void yyerror(const char *s);
%}

/* Declaração dos tokens */
%token NUM

/* Definição de precedência e associatividade (menor para maior) */
%left '+' '-'
%left '*' '/'

%%

/* Regra inicial: permite múltiplas expressões separadas por Enter (\n) */
calc:
    | calc expr '\n' { printf("Resultado: %d\n", $2); }
    | calc '\n'      { /* Ignora linhas em branco */ }
    ;

/* Regras de expressão e ações semânticas */
expr:
      NUM             { $$ = $1; }
    | expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { 
        if($3 == 0) {
            yyerror("Erro semântico: Divisão por zero!");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
      }
    | '(' expr ')'    { $$ = $2; }
    ;

%%

/* Função de tratamento de erros sintáticos chamada pelo Bison */
void yyerror(const char *s) {
    fprintf(stderr, "Erro sintático: %s\n", s);
}

/* Função principal do programa em C-ANSI */
int main(void) {
    printf("=== Calculadora Inteira (Flex/Bison) ===\n");
    printf("Digite uma expressao matematica e pressione Enter (Ctrl+C para sair):\n");
    return yyparse(); /* Inicia o analisador sintático */
}