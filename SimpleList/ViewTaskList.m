//
//  ViewTaskList.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#import <Foundation/Foundation.h>
#include "Task.h"

//Define standardized output format string literals for printing list
#define PARENT_LABEL @"Task ID: %@ | Description: %@"
#define CHILD_LABEL @"Child ID: %@ | Description: %@"

//Prompt user for a parent ID, if valid, print the contents of the single parent.
void viewSingleParent(NSMutableArray *parent){
    int usrIn;
    NSLog(@"Enter parent task ID: ");
    scanf("%i",&usrIn);
    if(parent[usrIn-1]!=nil){
        ParentTask *pt = parent[usrIn-1];
        NSLog(PARENT_LABEL, pt.taskId, pt.taskId);
        if(pt.childTasks!=nil){
            for(ChildTask *ct in pt.childTasks){
                NSLog(CHILD_LABEL, ct.taskId, ct.taskDesc);
            }
        }
    }
}

//Print the entire list (parents and children) from array passed in.
void displayTaskList(NSMutableArray *parent){
    for(ParentTask *task in parent){
        NSLog(PARENT_LABEL, task.taskId, task.taskDesc);
        if(task.childTasks!=nil){
            for(ChildTask *ctask in task.childTasks){
                NSLog(CHILD_LABEL, ctask.taskId, ctask.taskDesc);
            }
        }
    }
}
