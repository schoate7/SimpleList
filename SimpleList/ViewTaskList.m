//
//  ViewTaskList.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//
#import <Foundation/Foundation.h>
#include "Task.h"

#define PARENT_LABEL @"Task ID: %@ | Description: %@"
#define CHILD_LABEL @"Child ID: %@ | Description: %@"

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
