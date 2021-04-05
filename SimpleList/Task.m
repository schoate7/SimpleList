//
//  Task.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"

//Define standardized output format string literals for printing list
#define PARENT_LABEL "%i: %s"
#define CHILD_LABEL "%i.%i: %s"

//ParentTask object
@implementation ParentTask

//Initialize and return a parent task from description and task id
-(id)getParentTask:(NSString *)desc{
    self.taskDesc = desc;
    self.childTasks = [[NSMutableArray alloc]init];
    self.requiresSecureCoding = YES;
    return self;
}

//Update description of task from input pointer to NSString
-(void)updateDesc:(NSString*)newDesc{
    self.taskDesc = newDesc;
}

//Add a new child task to array from input pointer
-(void)addChildTask:(NSString*)newChildTask{
    [self.childTasks addObject:newChildTask];
}

//Initializes coder with encode keys
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self forKey:@"parenttask"];
    [aCoder encodeObject:self.taskDesc forKey:@"parenttaskdesc"];
    [aCoder encodeObject:self.childTasks forKey:@"childtasks"];
}

//Initializes decoder with decode keys
-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self = [aDecoder decodeObjectOfClass:[ParentTask class] forKey:@"parenttask"];
      self.taskDesc = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"parenttaskdesc"];
      self.childTasks = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"childtasks"];
  }
  return self;
}

//Return true for NSKeyedArchiver
+(BOOL)supportsSecureCoding {
   return YES;
}
@end

//Get ID number and return from regex #.#. type c to return child, type p for parent. Returns -1 if type cannot be found in expression.
int getId(NSString *input, char type){
    NSError *err = NULL;
    unsigned long inLength = [input length];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"^[0-9][.][0-9]*$" options:NSRegularExpressionCaseInsensitive error:&err];
    NSUInteger numberOfMatches = [regEx numberOfMatchesInString:input options:0 range:NSMakeRange(0, inLength)];
    
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
    }
    return -1;
}

//Generic function to get a character, loop until input matches a character in args string, return any char if args are nil
char getChar(char *prompt, NSString *args){
    char *input = (char*)malloc(32);
    char c = ' ';
    bool v = false;
    
    while(!v){
        printf("%s", prompt);
        scanf(" ");
        fgets(input, 32, stdin);
        if(args==nil){
            v = true;
        }else if(args!=nil){
            size_t argLen = args.length;
            for(int i=0; i<argLen; i++){
                if([args characterAtIndex:i] == toupper(input[0])){
                    v = true;
                }
            }
            if(v==false){
                printf("Invalid input, please try again.\n");
            }
        }
    }

    if(input != NULL){
        c = toupper(input[0]);
    }
    
    return c;
}

//Prompt user for a parent ID, if valid, print the contents of the single parent.
void viewSingleParent(NSMutableArray *parentList){
    char *input = (char*)malloc(32);
    int index;
    printf("Parent ID: ");
    scanf(" ");
    fgets(input, 32, stdin);
    index = atoi(input);
    index--;
    if (parentList.count < index+1 || index < 0){
        printf("Task id not found");
    }else if(parentList[index]!=nil){
        ParentTask *task = parentList[index];
        printf("-------------------------------\n");
        printf(PARENT_LABEL, index+1, [task.taskDesc UTF8String]);
        if(task.childTasks!=nil){
            int cid = 1;
            for(NSString *ct in task.childTasks){
                printf(CHILD_LABEL, index+1, cid, [ct UTF8String]);
                cid++;
            }
            printf("-------------------------------\n");
        }
    }else{
        printf("An unknown error occurred.\n");
    }
    free(input);
}

//Print the entire list (parents and children) from array passed in.
void displayTaskList(NSMutableArray *parentList){
    if(parentList.count>0){
        int tid = 1;
        printf("\nActive Tasks:\n");
        printf("---------------\n");
        for(ParentTask *task in parentList){
            printf(PARENT_LABEL, tid, [task.taskDesc UTF8String]);
            if(task.childTasks!=nil){
                int cid = 1;
                for(NSString *ct in task.childTasks){
                    printf(CHILD_LABEL, tid, cid, [ct UTF8String]);
                    cid++;
                }
            }
            tid++;
            printf("-------------------------------\n");
        }
        printf("\n");
    }else{
        printf("List is empty.\n");
    }
}
