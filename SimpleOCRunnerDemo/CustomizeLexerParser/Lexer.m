//
//  Lexer.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/19.
//

#import "Lexer.h"
const char *lexerRawSource;
char *sourceCursor;
int offsetCursor;
int tokenLength;
char readNextChr(){
    tokenLength++;
    sourceCursor++;
    return *sourceCursor;
}
void backUpChr(){
    tokenLength--;
    sourceCursor--;
    return;
}
TOKEN *LexerStartAnalyze(const char *source){
    lexerRawSource = source;
    sourceCursor = (char *)lexerRawSource;
    TOKEN *header = malloc(sizeof(TOKEN));
    header->type = HEADER;
    TOKEN *cur = header;
    while (*sourceCursor != EOF && *sourceCursor != '\0') {
        TOKEN_TYPE type = NONE;
        tokenLength = 1;
        switch (*sourceCursor) {
            case '0': case '1': case '2': case '3': case '4':
            case '5': case '6': case '7': case '8': case '9':
            {
                type = INT;
                char chr = readNextChr();
                while (isdigit(chr) || chr == '.') {
                    if (chr == '.') {
                        type = DOUBLE;
                    }
                    chr = readNextChr();
                }
                backUpChr();
                break;
            }
            case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G':
            case 'H': case 'I': case 'J': case 'K': case 'L': case 'M': case 'N':
            case 'O': case 'P': case 'Q': case 'R': case 'S': case 'T': case 'U':
            case 'V': case 'W': case 'X': case 'Y': case 'Z':
            case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': case 'g':
            case 'h': case 'i': case 'j': case 'k': case 'l': case 'm': case 'n':
            case 'o': case 'p': case 'q': case 'r': case 's': case 't': case 'u':
            case 'v': case 'w': case 'x': case 'y': case 'z':
            case '_':
            {
                type = IDENTIFIER;
                char chr = readNextChr();
                while (chr == '_' || [[NSCharacterSet alphanumericCharacterSet] characterIsMember:chr]) {
                    chr = readNextChr();
                }
                backUpChr();
                break;
            }
            case '(':
            case ')':
            case '{':
            case '}':
            case ',':
            case ';':
            case '+':
            case '=':
                type = SYMBOL;
                break;
                
            case ' ':
                break;
            case '\n':
                break;
            default:
                break;
        }
        if (type != NONE) {
            TOKEN *token = malloc(sizeof(TOKEN));
            token->type = type;
            char *string = malloc(sizeof(char) * (tokenLength + 1));
            memcpy(string, lexerRawSource + offsetCursor, tokenLength);
            switch (type) {
                case INT:
                    token->value.intValue = atoll(string);
                    free(string);
                    break;
                case DOUBLE:
                    token->value.doubleValue = atof(string);
                    free(string);
                    break;
                    
                default:
                    token->value.stringBuffer = string;
                    break;
            }
            cur->next = token;
            cur = token;
        }
        
        sourceCursor++;
        offsetCursor += tokenLength;
    }
    return header;
}
