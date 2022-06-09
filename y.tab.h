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
    T_VAR = 258,
    T_TRUE = 259,
    T_FALSE = 260,
    T_NULL = 261,
    T_STRINGCONSTANT = 262,
    T_INTCONSTANT = 263,
    T_CHARCONSTANT = 264,
    T_HEXCONSTANT = 265,
    T_VOID = 266,
    T_INTTYPE = 267,
    T_BOOLTYPE = 268,
    T_STRINGTYPE = 269,
    T_EQ = 270,
    T_NEQ = 271,
    T_GEQ = 272,
    T_GT = 273,
    T_LEQ = 274,
    T_LT = 275,
    T_PLUS = 276,
    T_MINUS = 277,
    T_MULT = 278,
    T_DIV = 279,
    T_MOD = 280,
    T_NOT = 281,
    T_OR = 282,
    T_AND = 283,
    T_ASSIGN = 284,
    T_FUNC = 285,
    T_RETURN = 286,
    T_WHILE = 287,
    T_IF = 288,
    T_ELSE = 289,
    T_FOR = 290,
    T_BREAK = 291,
    T_CONTINUE = 292,
    T_COMMA = 293,
    T_LSB = 294,
    T_RSB = 295,
    T_SEMICOLON = 296,
    T_LCB = 297,
    T_RCB = 298,
    T_LPAREN = 299,
    T_RPAREN = 300,
    T_DOT = 301,
    T_LEFTSHIFT = 302,
    T_RIGHTSHIFT = 303,
    T_ID = 304,
    T_PACKAGE = 305,
    T_EXTERN = 306,
    T_COMMENT = 307,
    T_WHITESPACE = 308,
    T_WHITESPACE_N = 309,
    T_PRINT = 310
  };
#endif
/* Tokens.  */
#define T_VAR 258
#define T_TRUE 259
#define T_FALSE 260
#define T_NULL 261
#define T_STRINGCONSTANT 262
#define T_INTCONSTANT 263
#define T_CHARCONSTANT 264
#define T_HEXCONSTANT 265
#define T_VOID 266
#define T_INTTYPE 267
#define T_BOOLTYPE 268
#define T_STRINGTYPE 269
#define T_EQ 270
#define T_NEQ 271
#define T_GEQ 272
#define T_GT 273
#define T_LEQ 274
#define T_LT 275
#define T_PLUS 276
#define T_MINUS 277
#define T_MULT 278
#define T_DIV 279
#define T_MOD 280
#define T_NOT 281
#define T_OR 282
#define T_AND 283
#define T_ASSIGN 284
#define T_FUNC 285
#define T_RETURN 286
#define T_WHILE 287
#define T_IF 288
#define T_ELSE 289
#define T_FOR 290
#define T_BREAK 291
#define T_CONTINUE 292
#define T_COMMA 293
#define T_LSB 294
#define T_RSB 295
#define T_SEMICOLON 296
#define T_LCB 297
#define T_RCB 298
#define T_LPAREN 299
#define T_RPAREN 300
#define T_DOT 301
#define T_LEFTSHIFT 302
#define T_RIGHTSHIFT 303
#define T_ID 304
#define T_PACKAGE 305
#define T_EXTERN 306
#define T_COMMENT 307
#define T_WHITESPACE 308
#define T_WHITESPACE_N 309
#define T_PRINT 310

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 33 "yacc.y"

	char *yy_str;
	int yy_int;

#line 172 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
