/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_VOID = 258,
    T_VAR = 259,
    T_INTTYPE = 260,
    T_BOOLTYPE = 261,
    T_STRINGTYPE = 262,
    T_TRUE = 263,
    T_FALSE = 264,
    T_NULL = 265,
    T_STRINGCONSTANT = 266,
    T_INTCONSTANT = 267,
    T_CHARCONSTANT = 268,
    T_EQ = 269,
    T_NEQ = 270,
    T_GEQ = 271,
    T_GT = 272,
    T_LEQ = 273,
    T_LT = 274,
    T_PLUS = 275,
    T_MINUS = 276,
    T_MULT = 277,
    T_DIV = 278,
    T_MOD = 279,
    T_NOT = 280,
    T_OR = 281,
    T_AND = 282,
    T_ASSIGN = 283,
    T_FUNC = 284,
    T_RETURN = 285,
    T_WHILE = 286,
    T_IF = 287,
    T_ELSE = 288,
    T_FOR = 289,
    T_BREAK = 290,
    T_CONTINUE = 291,
    T_COMMA = 292,
    T_LSB = 293,
    T_RSB = 294,
    T_SEMICOLON = 295,
    T_LCB = 296,
    T_RCB = 297,
    T_LPAREN = 298,
    T_RPAREN = 299,
    T_DOT = 300,
    T_LEFTSHIFT = 301,
    T_RIGHTSHIFT = 302,
    T_PACKAGE = 303,
    T_EXTERN = 304,
    T_COMMENT = 305,
    T_ID = 306,
    T_WHITESPACE = 307,
    T_WHITESPACE_N = 308
  };
#endif
/* Tokens.  */
#define T_VOID 258
#define T_VAR 259
#define T_INTTYPE 260
#define T_BOOLTYPE 261
#define T_STRINGTYPE 262
#define T_TRUE 263
#define T_FALSE 264
#define T_NULL 265
#define T_STRINGCONSTANT 266
#define T_INTCONSTANT 267
#define T_CHARCONSTANT 268
#define T_EQ 269
#define T_NEQ 270
#define T_GEQ 271
#define T_GT 272
#define T_LEQ 273
#define T_LT 274
#define T_PLUS 275
#define T_MINUS 276
#define T_MULT 277
#define T_DIV 278
#define T_MOD 279
#define T_NOT 280
#define T_OR 281
#define T_AND 282
#define T_ASSIGN 283
#define T_FUNC 284
#define T_RETURN 285
#define T_WHILE 286
#define T_IF 287
#define T_ELSE 288
#define T_FOR 289
#define T_BREAK 290
#define T_CONTINUE 291
#define T_COMMA 292
#define T_LSB 293
#define T_RSB 294
#define T_SEMICOLON 295
#define T_LCB 296
#define T_RCB 297
#define T_LPAREN 298
#define T_RPAREN 299
#define T_DOT 300
#define T_LEFTSHIFT 301
#define T_RIGHTSHIFT 302
#define T_PACKAGE 303
#define T_EXTERN 304
#define T_COMMENT 305
#define T_ID 306
#define T_WHITESPACE 307
#define T_WHITESPACE_N 308

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
