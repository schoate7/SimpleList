//
//  Task.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"
#import "Common.h"

//Define standardized output format string literals for printing list
#define PARENT_LABEL "%i: %s"
#define CHILD_LABEL "%i.%i: %s"

//ParentTask object
@implementation Task

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

//Prints content of self, and any child tasks if existing
-(void)displayParent:(int)indexId{
    printf(PARENT_LABEL, indexId, [_taskDesc UTF8String]);
    if(_childTasks != nil){
        int childIndex = 1;
        for(NSString *childDesc in _childTasks){
            printf(CHILD_LABEL, indexId, childIndex, [childDesc UTF8String]);
            childIndex++;
        }
    }
    printf("-------------------------------\n");
}

//Initializes decoder with decode keys
-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self = [aDecoder decodeObjectOfClass:[Task class] forKey:@"parenttask"];
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

//Prompt user for a parent ID, if valid, print the contents of the single parent.
void viewSingleParent(NSMutableArray *parentList){
    char *input = (char*)malloc(32);
    int index;
    printf("Parent ID: ");
    scanf(" ");
    fgets(input, 32, stdin);
    if(isQuitChar(input)){
        printf("Exiting...\n");
        return;
    }
    index = atoi(input);
    index--;
    if (parentList.count < index+1 || index < 0){
        printf("Task id not found");
    }else if(parentList[index]!=nil){
        Task *task = parentList[index];
        printf("\nTask Display:\n");
        printf("-------------------------------\n");
        [task displayParent:index+1];

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
        printf("-------------------------------\n");
        for(Task *task in parentList){
            [task displayParent:tid];
            tid++;
        }
        printf("\n");
    }else{
        printf("List is empty.\n");
    }
}
