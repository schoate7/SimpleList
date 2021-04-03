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

char getChar(char *prompt){
    char *input = (char*)malloc(32);
    char c = ' ';
    printf("%s", prompt);
    scanf(" ");
    fgets(input, 32, stdin);
    
    if(input != NULL){
        c = toupper(input[0]);
    }
    return c;
}

int getTaskId(char taskType){
    char *input = (char*)malloc(32);
    int taskId = 0;
    if(taskType == 'P'){
        printf("Parent task ID: ");
    }else if(taskType == 'C'){
        printf("Child task ID: ");
    }else{
        printf("An error occurred.\n");
        return taskId;
    }
    scanf(" ");
    fgets(input, 32, stdin);
    taskId = atoi(input);
    
    return taskId;
}


//Prompt user for a parent ID, if valid, print the contents of the single parent.
void viewSingleParent(NSMutableArray *parentList){
    int index;
    index = getTaskId('P');
    index--;
    if (parentList.count < index+1 || index < 0){
        printf("Task id not found");
    }else if(parentList[index]!=nil){
        ParentTask *task = parentList[index];
        printf(PARENT_LABEL, index+1, [task.taskDesc UTF8String]);
        if(task.childTasks!=nil){
            int cid = 1;
            for(NSString *ct in task.childTasks){
                printf(CHILD_LABEL, index+1, cid, [ct UTF8String]);
                cid++;
            }
        }
    }else{
        printf("An unknown error occurred.\n");
    }
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
