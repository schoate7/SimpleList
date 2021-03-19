//
//  ViewTaskList.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//
#import <Foundation/Foundation.h>
#include "Task.h"

void displayTaskList(NSMutableArray *parent){
    for(ParentTask *task in parent){
        NSLog(@"Task ID: %i | Description: %@", task.taskId, task.taskDesc);
        if(task.childTasks!=nil){
            for(ChildTask *ctask in task.childTasks){
                NSLog(@"Child ID: %i | Description: %@", ctask.taskId, ctask.taskDesc);
            }
        }
    }
}
