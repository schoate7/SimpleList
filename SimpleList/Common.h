//
//  Common.h - Contains common functions used application-wide for processing user input.
//  SimpleList
//
//  Created by Stephen Choate on 4/7/21.
//

#ifndef Common_h
#define Common_h

#define quitChar(c,p) c==-100 && p==-100

/* isQuitChar - Accepts an input string, returns true if matches the quit sequence "-e". */
bool isQuitChar(char *input);

/* getId - Accepts NSString in #.# format as input, char type declaration (P,C), to be decomposed using a RegEx. Returns decomposed parent or child if input valid, -1 if not. */
int getId(NSString *input, char type);

/* getChar - Accepts a char* input parameter to prompt user, NSString args. Prompts user with string, if args, only return if a match found, or if quit character is found, otherwise re-prompt. If nil args, return any character input. */
char getChar(char *prompt, NSString *args);

#endif /* Common_h */
