//
//  AddTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"
#import "Common.h"

#define TASK_PROMPT "Enter Task Description: "

//Re-usable function to get task description for either parent or child, return NSString pointer
NSString *getDesc(void){
    char* usrIn = (char*)malloc(4096);
    printf("%s", TASK_PROMPT);
    scanf(" ");
    fgets(usrIn, 4096, stdin);
    if(isQuitChar(usrIn)){
        free(usrIn);
        return nil;
    }else{
        NSString *newDesc = [NSString stringWithUTF8String:usrIn];
        free(usrIn);
        return newDesc;
    }
}

//Add new parent task to main array
void addParentTask(NSMutableArray *parentList){
    Task *newTask = [[Task alloc]init];
    NSString *tDesc = getDesc();
    if(tDesc == nil){
        printf("Exiting with no chnages.\n");
        return;
    }
    int newPID = 0;
    
    [parentList addObject:newTask];
    newPID = (int)[parentList indexOfObject:newTask] + 1;
    [newTask getParentTask:tDesc];
    
    printf("Task ID Assigned: %i\n", newPID);
}

//Add child task to a parent's child array
void addChildTask(NSMutableArray *parentList){
    Task *matchingParent;
    char *input = (char*)malloc(32);
    int pid = 0;
    int cIndex = 0;
    printf("Parent ID: ");
    scanf(" ");
    fgets(input, 32, stdin);
    if(isQuitChar(input)){
        printf("Exiting with no chnages.\n");
        free(input);
        return;
    }
    pid = atoi(input);
    pid--;
    
    if(parentList.count > pid && pid>=0){
        matchingParent = parentList[pid];
    }
    
    if(matchingParent!=nil){
        NSString *tDesc = getDesc();
        if(tDesc == nil){
            printf("Leaving unchanged.\n");
            free(input);
            return;
        }
        [matchingParent addChildTask:tDesc];
        cIndex = (int)[matchingParent.childTasks indexOfObject:tDesc]+1;
        printf("Task ID Assigned: %i.%i\n", pid+1, cIndex);
    }else{
        printf("Cannot find parent ID.\n");
    }
    free(input);
}

//Submenu, prompt user for parent or child, re-direct to appropriate function
void addTask(NSMutableArray *parentList){
    char sel = ' ';
    NSString *charArgs = [NSString stringWithUTF8String:"[PC]"];
    sel = getChar("Add [P]arent Task or [C]hild Task: ", charArgs);
    switch(sel){
        case 'P':
            addParentTask(parentList);
            break;
        case 'C':
            addChildTask(parentList);
            break;
        default:
            printf("Exiting with no chnages.\n");
            break;
    }
}
