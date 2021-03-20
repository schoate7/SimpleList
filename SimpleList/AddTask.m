//
//  TaskFunc.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"

#define TASK_PROMPT @"\nEnter Task Description: "

//Re-usable function to get task description for either parent or child, return NSString pointer
NSString *getDesc(){
    char* usrIn = (char*)malloc(4096);
    NSLog(TASK_PROMPT);
    scanf("%s", usrIn);
    NSString *newDesc = [NSString stringWithUTF8String:usrIn];
    free(usrIn);
    return newDesc;
}

//Function to add a new parent task off of main parent
void addParentTask(NSMutableArray *parentList){
    ParentTask *newTask = [[ParentTask alloc]init];
    NSString *tDesc = getDesc();
    int newPID = 0;
    
    [parentList addObject:newTask];
    newPID = (int)[parentList indexOfObject:newTask] + 1;
    NSNumber *pidNS = [NSNumber numberWithInt:newPID];
    [newTask getParentTask:tDesc taskId:pidNS];
    
    NSLog(@"Task ID Assigned: %@", newTask.taskId);
}

//Add child task off top level parent
void addChildTask(NSMutableArray *parentList){
    ChildTask *newChild = [[ChildTask alloc]init];
    ParentTask *matchingParent;
    int parentIdIn = 0;
    int indexId = 0;
    int nsIndex=0;
    NSLog(@"Enter the parent task ID: ");
    scanf("%i", &parentIdIn);
    NSNumber *parentId = [NSNumber numberWithInt:parentIdIn];
    
    for(ParentTask *pTask in parentList){
        if(pTask.taskId.intValue==parentId.intValue){
            matchingParent = pTask;
            nsIndex = (int)[parentList indexOfObject:matchingParent];
            break;
        }
    }
    if(matchingParent!=nil){
        NSString * tDesc = getDesc();
        [matchingParent addChildTasks:newChild];
        indexId = (int)[matchingParent.childTasks indexOfObject:newChild];
        NSNumber *indexNS = [NSNumber numberWithInt:indexId+1];
        [newChild getChildTask:tDesc taskId:indexNS];
    }else{
        NSLog(@"An error occurred finding parent");
    }
}

//Submenu function for adding a task, prompt for parent or child by char input
void addTask(NSMutableArray *parentList){
    char *usrIn = malloc(8);
    bool validIn = false;
    while(!validIn){
        NSLog(@"What do you want to add?");
        NSLog(@"[P]arent Task, [C]hild Task");
        scanf(" %c", usrIn);
        *usrIn = toupper(*usrIn);
        validIn = (*usrIn == 'P' || *usrIn == 'C');
    }
    switch(*usrIn){
        case 'P':
            addParentTask(parentList);
            break;
        case 'C':
            addChildTask(parentList);
            break;
        default:
            NSLog(@"An error has occurred.");
            break;
    }
}
