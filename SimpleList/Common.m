//
//  Common.m
//  SimpleList
//
//  Created by Stephen Choate on 4/7/21.
//

#import <Foundation/Foundation.h>

bool isQuitChar(char *input){
    NSString *inString = [NSString stringWithUTF8String:input];
    NSError *err = nil;
    size_t inLen = [inString length];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"^[-][e]*$" options:NSRegularExpressionCaseInsensitive error:&err];
    NSUInteger numberOfMatches = [regEx numberOfMatchesInString:inString options:0 range:NSMakeRange(0, inLen)];
    
    return numberOfMatches>0;
}

//Get ID number and return from regex #.#. type c to return child, type p for parent. Returns -1 if type cannot be found in expression.
int getId(NSString *input, char type){
    NSError *err = NULL;
    size_t inLength = [input length];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"^[0-9][.][0-9]*$" options:NSRegularExpressionCaseInsensitive error:&err];
    NSUInteger numberOfMatches = [regEx numberOfMatchesInString:input options:0 range:NSMakeRange(0, inLength)];
    char *qcCheck = (char*)malloc(inLength*8);
    qcCheck = (char*)[input UTF8String];
    
    if(numberOfMatches == 1){
        NSArray *splitStringArray = [input componentsSeparatedByString:@"."];
        if (type == 'C'){
            NSString *value = splitStringArray[1];
            return value.intValue;
        }else if (type == 'P'){
            NSString *value = splitStringArray[0];
            return value.intValue;
        }else{
            printf("Error: A function is improperly using getId.\n");
        }
    }else if (numberOfMatches == 0 && type == 'P'){
        NSRegularExpression *isOnlyParent = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive error:&err];
        numberOfMatches = [isOnlyParent numberOfMatchesInString:input options:0 range:NSMakeRange(0, inLength)];
        if (numberOfMatches==1){
            return atoi([input UTF8String]);
        }else if (isQuitChar(qcCheck)){
            return -100;
        }
    }else if(isQuitChar(qcCheck)){
        return -100;
    }
    return -1;
}

//Generic function to get a character, if args exist loop requesting input until match(upper case) or escape sequence(1) found and return. Return upper case of any character input if args are nil.
char getChar(char *prompt, NSString *args){
    char *input = (char*)malloc(32);
    char c = ' ';
    bool v = false;
    
    while(!v){
        printf("%s", prompt);
        scanf(" ");
        fgets(input, 32, stdin);
        v = (args==nil);
        if(!v){
            NSError *err = nil;
            NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:args options:NSRegularExpressionCaseInsensitive error:&err];
            NSUInteger numberOfMatches = [regEx numberOfMatchesInString:[NSString stringWithUTF8String:input] options:0 range:NSMakeRange(0, 1)];
            
            v = (numberOfMatches == 1);
            if(!v){
                if(isQuitChar(input)){
                    return '!';
                }else{
                    printf("Invalid input, please try again.\n");
                }
            }
        }
    }

    if(input != NULL){
        c = toupper(input[0]);
    }
    return c;
}
