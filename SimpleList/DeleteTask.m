//
//  DeleteTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Delete a child task from a valid parent, if input child ID exists
void deleteChildTask(ParentTask *pTask){
    NSMutableArray *childArray = pTask.childTasks;
    int cid;
    cid = getTaskId('C');
    cid--;

    if(childArray.count > cid && cid>=0){
        [childArray removeObjectAtIndex:cid];
    }else{
        printf("Cannot find child task.\n");
    }
}

//Prompt for parent ID, prompt if children available to delete, re-direct if requested. Detele parent if no children exist.
void deleteTask(NSMutableArray *parentList){
    ParentTask *pTask;
    int pid = 0;
    bool v = false;

    pid = getTaskId('P');
    pid--;
    
    if(parentList.count > pid && pid>=0){
        pTask = parentList[pid];
    }
    
    //If there is one or more children, prompt to delete child, otherwise just delete parent
    if(pTask!=nil && [pTask.childTasks count]!=0){
        while(!v)
        {
            char sel = ' ';
            printf("Parent has child tasks.\n");
            sel = getChar("Delete [P]arent or [C]hild: ");
            v = (sel=='P' || sel=='C');
            switch (sel){
                case 'P':
                    [parentList removeObjectAtIndex:pid];
                    break;
                case 'C':
                    deleteChildTask(pTask);
                    break;
                default:
                    printf("An error occurred.\n");
                    break;
            }
        }
    }else if(pTask!=nil){
        [parentList removeObjectAtIndex:pid];
    }else{
        printf("An error ocurred.\n");
    }
}
