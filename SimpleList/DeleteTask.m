//
//  DeleteTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//
//TO BUILD:
//Add a function to print just the parent and children.

#import <Foundation/Foundation.h>
#import "Task.h"

//Re-index the taskId for parent tasks when a parent task is deleted
void reIndexParents(NSMutableArray *parentList){
    int index = 1;
    for (ParentTask *p in parentList){
        p.taskId = [NSNumber numberWithInt:index];
        index++;
    }
}

//Re-index the taskId for parent and children tasks when a child task is deleted
void reIndexChildren(NSMutableArray *parentList){
    NSMutableArray *c;
    reIndexParents(parentList);
    int index = 1;
    for (ParentTask *p in parentList){
        c = (p.childTasks!=nil) ? p.childTasks : nil;
        if(c!=nil){
            for (ChildTask *ct in c){
                ct.taskId = [NSNumber numberWithInt:index];
                index++;
            }
            index = 1;
        }
    }
}

//Delete a child task from a valid parent
void deleteChildTask(ParentTask *pTask){
    NSMutableArray *childArray = pTask.childTasks;
    ChildTask *cTask;
    int cid;
    NSLog(@"Enter the child ID to delete: ");
    scanf("%i", &cid);
    NSUInteger nsn = 0;
    NSNumber *cns = [NSNumber numberWithInt:cid];
    
    for(ChildTask *child in childArray){
        if(child.taskId.intValue == cns.intValue){
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

//Main delete task function, includes routine for simple parent task deletion
void deleteTask(NSMutableArray *parentList){
    char usrIn = (char)malloc(8);
    int pid = 0;
    bool v = false;

    NSLog(@"Enter Parent ID: ");
    scanf("%i", &pid);
    NSUInteger nsn = 0;
    NSNumber *pns = [NSNumber numberWithInt:pid];
    ParentTask *pTask;
    
    for (ParentTask *task in parentList){
        if (task.taskId.intValue == pns.intValue){
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
                reIndexParents(parentList);
                break;
            case 'C':
                deleteChildTask(pTask);
                reIndexChildren(parentList);
                break;
            default:
                NSLog(@"An error occurred");
                break;
        }
    }else if(pTask!=nil){
        [parentList removeObjectAtIndex:nsn];
        reIndexParents(parentList);
    }else{
        NSLog(@"An error ocurred");
    }
}
