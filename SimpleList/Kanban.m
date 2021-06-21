//
//  Kanban.m
//  SimpleList
//
//  Created by Stephen Choate on 4/23/21.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "Task.h"

#define lineHandler(i) if(i==0){printf("\n");}else{i=0;}

void setStatus(NSMutableArray *parentList){
    char *input = (char*)malloc(32);
    printf("Task ID to Set: ");
    scanf(" ");
    fgets(input, 32, stdin);
    NSString *inputString = [NSString stringWithUTF8String:input];
    
    int parentIndex = getId(inputString, 'P');
    parentIndex--;
    
    if(parentIndex<parentList.count){
        Task *pt = parentList[parentIndex];
        printf("-------------------------------\n");
        printf("Task name: %s", [pt.taskDesc UTF8String]);
        if(pt.taskStatus!=nil){
            printf("Current status: %s\n", [pt.taskStatus UTF8String]);
        }
        printf("-------------------------------\n");
        char newStatus = getChar("Set as [T]o-do, [D]oing, or Do[n]e: ", @"[TDN]");
        switch(newStatus){
            case 'T':
                [pt setTaskStatus:@"To-Do"];
                break;
            case 'D':
                [pt setTaskStatus:@"Doing"];
                break;
            case 'N':
                [pt setTaskStatus:@"Done"];
                break;
            case '!':
                printf("Exiting with no changes.\n");
                break;
            default:
                printf("An error occurred, no changes made.\n");
                break;
        }
    }else{
        printf("Invalid task ID.\n");
    }
}

void displayBoard(NSMutableArray *parentList){
    int i = 0;
    int tid = 1;
    NSArray *taskStatuses = @[@"To-Do", @"Doing", @"Done"];
    printf("\nTo-Do:\n");
    for(Task *tsk in parentList){
        if ([tsk.taskStatus isEqualTo:taskStatuses[0]]){
            printf("%i: %s", tid, [tsk.taskDesc UTF8String]);
            i++;
        }
        tid++;
    }
    lineHandler(i);
    tid = 1;
    
    printf("-------------------------------\n");
    printf("Doing:\n");
    for(Task *tsk in parentList){
        if([tsk.taskStatus isEqualTo:taskStatuses[1]]){
            printf("%i: %s", tid, [tsk.taskDesc UTF8String]);
            i++;
        }
        tid++;
    }
    lineHandler(i);
    tid = 1;
    
    printf("-------------------------------\n");
    printf("Done:\n");
    for(Task *tsk in parentList){
        if([tsk.taskStatus isEqualTo:taskStatuses[2]]){
            printf("%i: %s", tid, [tsk.taskDesc UTF8String]);
            i++;
        }
        tid++;
    }
    
    lineHandler(i);
    printf("-------------------------------\n");
}


void kanbanMenu(NSMutableArray *parentList){
    NSString *inputArgs = [NSString stringWithUTF8String:"[DSQ]"];
    char input = ' ';
    bool v = false;

    printf("Welcome to the Kanban Menu:\n");
    while(!v){
        input = getChar("[D]isplay board, [S]et task status, [Q]uit: ", inputArgs);
        v = (input == 'Q' || input == '!');
        switch(input){
            case 'D':
                displayBoard(parentList);
                break;
            case 'S':
                setStatus(parentList);
                break;
            case 'Q': case '!':
                printf("Returning to main menu...\n\n");
                break;
        }
    }
}
