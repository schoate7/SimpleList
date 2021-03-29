//
//  EditTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Get parent and child task ID, display existing description, prompt for input and execute replacement
void editChildTask(NSMutableArray *parentList){
    char *usrIn = (char*)malloc(64);
    int pid = 0;
    int cid = 0;
    int index = 0;
    NSString *existingDesc;
    ChildTask *toChange;
    ParentTask *parent;
    
    NSLog(@"Parent ID of child: ");
    scanf(" ");
    fgets(usrIn, 64, stdin);
    pid = atoi(usrIn);
    for(ParentTask *pt in parentList){
        if(pt.taskId.intValue == pid){
            existingDesc = pt.taskDesc;
            break;
        }else{
            index++;
        }
    }
    if(existingDesc!=nil){
        existingDesc = nil;
        parent = parentList[index];
        NSMutableArray *childList = parent.childTasks;
        NSLog(@"Child ID to edit:");
        scanf(" ");
        fgets(usrIn, 64, stdin);
        cid = atoi(usrIn);
        index = 0;
        
        for(ChildTask *ct in childList){
            if(ct.taskId.intValue == cid){
                existingDesc = ct.taskDesc;
                break;
            }else{
                index++;
            }
        }
        if(existingDesc!=nil){
            char *newDesc = (char*)malloc(4096);
            NSLog(@"Current description: %@", existingDesc);
            NSLog(@"Change to: ");
            scanf(" ");
            fgets(newDesc, 4096, stdin);
            toChange = childList[index];
            [toChange updateDesc:[NSString stringWithUTF8String:newDesc]];
        }
    }
}

//Get parent task ID, display existing description, prompt for input and execute replacement
void editParentTask(NSMutableArray *parentList){
    char *usrIn = (char*)malloc(64);
    int pid = 0;
    int index = 0;
    NSString *existingDesc;
    ParentTask *toChange;
    
    NSLog(@"Parent ID to Edit: ");
    scanf(" ");
    fgets(usrIn, 64, stdin);
    pid = atoi(usrIn);
    for(ParentTask *pt in parentList){
        if (pt.taskId.intValue == pid){
            existingDesc = pt.taskDesc;
            break;
        }else{
            index++;
        }
    }
    if (existingDesc != nil){
        char *newDesc = (char*)malloc(4096);
        NSLog(@"Current description: %@", existingDesc);
        NSLog(@"Change to: ");
        scanf(" ");
        fgets(newDesc, 4096, stdin);
        toChange = parentList[index];
        [toChange updateDesc:[NSString stringWithUTF8String:newDesc]];
    }
}

//Submenu, prompt user to edit parent or child task, re-direct to selected function
void editTaskMenu(NSMutableArray *parentList){
    bool validIn = false;
    char *usrIn = (char*)malloc(64);
    char usrId = ' ';
    while(!validIn){
        NSLog(@"Edit [P]arent or [C]hild?: ");
        scanf(" ");
        fgets(usrIn, 64, stdin);
        usrId = toupper(usrIn[0]);
        switch(usrId){
            case 'P':
                editParentTask(parentList);
                validIn = true;
                break;
            case 'C':
                editChildTask(parentList);
                validIn = true;
                break;
            default:
                NSLog(@"Invalid input, try again.");
        }
    }
}
