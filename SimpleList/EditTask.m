//
//  EditTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Get child ID, display existing description, prompt for input and execute replacement
void editChildTask(ParentTask *pTask){
    NSMutableArray *childList = pTask.childTasks;
    NSString *curDesc;
    int cid = 0;
    
    cid = getTaskId('C');
    cid--;
        
    if(childList.count > cid && cid>=0){
        char *newDesc = (char*)malloc(4096);
        curDesc = childList[cid];
        printf("Current description: %s", [curDesc UTF8String]);
        printf("Change to: ");
        scanf(" ");
        fgets(newDesc, 4096, stdin);
        if(newDesc!=nil){
            childList[cid] = [NSString stringWithUTF8String:newDesc];
        }else{
            printf("Leaving description unchanged.\n");
        }
    }else{
        printf("Cannot find child ID.\n");
    }
}

//Display existing description for parent ID parameter, prompt for input and execute replacement
void editParentTask(ParentTask *pTask){
    NSString *existingDesc = pTask.taskDesc;
    char *newDesc = (char*)malloc(4096);
    
    printf("Current description: %s", [existingDesc UTF8String]);
    printf("Change to: ");
    scanf(" ");
    fgets(newDesc, 4096, stdin);
    
    if(newDesc!=nil){
        [pTask updateDesc:[NSString stringWithUTF8String:newDesc]];
    }else{
        printf("Leaving description unchanged.\n");
    }
    free(newDesc);
}

//Submenu, prompt user to edit parent or child task, re-direct to selected function
void editTaskMenu(NSMutableArray *parentList){
    ParentTask *pTask;
    int pid = 0;
    bool v = false;
    
    pid = getTaskId('P');
    pid--;
    
    if(parentList.count > pid && pid>=0){
        pTask = parentList[pid];
    }
    
    if(pTask!=nil && [pTask.childTasks count]!=0){
        while(!v){
            char sel = ' ';
            sel = getChar("Edit [P]arent or [C]hild?: ");
            v = (sel == 'P' || sel == 'C');
            switch(sel){
                case 'P':
                    editParentTask(pTask);
                    break;
                case 'C':
                    editChildTask(pTask);
                    break;
                default:
                    printf("Invalid input.\n");
                    break;
            }
        }
    }else if (pTask!=nil){
        editParentTask(pTask);
    }else{
        printf("Cannot find parent task.\n");
    }
}
