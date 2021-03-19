//
//  DeleteTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//
//TO BUILD:
//Add a function to print just the parent and children.
//Function to re-index assigned task ids (parent and child)

#import <Foundation/Foundation.h>
#import "Task.h"

//
void deleteChildTask(ParentTask *pTask){
    NSMutableArray *childArray = pTask.childTasks;
    ChildTask *cTask;
    int cid;
    NSLog(@"Enter the child ID to delete: ");
    scanf("%i", &cid);
    NSUInteger nsn = 0;
    
    for(ChildTask *child in childArray){
        if(child.taskId == cid){
            cTask = child;
            break;
        }
        nsn++;
    }
    
    if(cTask!=nil){
        [childArray removeObjectAtIndex:nsn];
    }else{
        NSLog(@"Cannot find child task by ID.");
    }
}

//
void deleteTask(NSMutableArray *parentList){
    char usrIn = (char)malloc(8);
    int pid = 0;
    bool v = false;

    NSLog(@"Enter Parent ID: ");
    scanf("%i", &pid);
    NSUInteger nsn = 0;
    ParentTask *pTask;;
    
    for (ParentTask *task in parentList){
        if (task.taskId == pid){
            pTask = task;
            break;
        }
        nsn++;
    }
    
    if(pTask!=nil && [pTask.childTasks count]!=0){
        while(!v){
            NSLog(@"Delete a [P]arent or [C]hild: ");
            scanf(" %c", &usrIn);
            usrIn = toupper(usrIn);
            v = (usrIn=='P' || usrIn=='C');
        }
        switch (usrIn){
            case 'P':
                [parentList removeObjectAtIndex:nsn];
                break;
            case 'C':
                deleteChildTask(pTask);
                break;
            default:
                NSLog(@"An error occurred");
                break;
        }
    }else if(pTask!=nil){
        [parentList removeObjectAtIndex:nsn];
    }else{
        NSLog(@"An error ocurred");
    }
}
