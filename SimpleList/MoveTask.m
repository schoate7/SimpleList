//
//  MoveTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

#define PARENT_PLACE "Parent ID to place in: "
#define PARENT_DISPLACE "Parent ID to displace: "
#define CHILD_MOVE "Child ID to move: "
#define CHILD_DISPLACE "Child ID to displace: "

//Internal use function
static int sgetTaskId(char* prompt){
    char *input = (char*)malloc(32);
    int taskId = 0;
    printf("%s", prompt);
    scanf(" ");
    fgets(input, 32, stdin);
    taskId = atoi(input);
    
    return taskId;
}

//Prompt user for parent ID and child ID to place in and displace, move child task and remove from old parent.
void moveChildtoOtherParent(NSMutableArray *parentList, NSMutableArray *oChildList, NSString *ctm, int childIndex){
    NSMutableArray *nChildList;
    ParentTask *targetParent;
    int pid, tr;
    
    pid = sgetTaskId(PARENT_PLACE);
    pid--;
    
    if(parentList.count > pid && pid>=0){
        targetParent = parentList[pid];
        nChildList = targetParent.childTasks;
    }
    
    if(nChildList!=nil && nChildList.count==0){
        [nChildList addObject:ctm];
        [oChildList removeObjectAtIndex:childIndex];
    }else if(nChildList!=nil && nChildList.count!=0){
        tr = sgetTaskId(CHILD_DISPLACE);
        tr--;
        if(nChildList.count>tr && tr>=0){
            [nChildList insertObject:ctm atIndex:tr];
            [oChildList removeObjectAtIndex:childIndex];
        }else if (nChildList.count==tr){
            [nChildList addObject:ctm];
            [oChildList removeObjectAtIndex:childIndex];
        }else{
            printf("Cannot find child ID.\n");
        }
    }else{
        printf("Cannot find parent ID\n");
    }
}

//Prompt for child to move, prompt for same or different parent, re-direct and execute move. 
void moveChild(NSMutableArray *parentList, ParentTask *pTask){
    NSMutableArray *childList = pTask.childTasks;
    NSString *toMove;
    int tm, tr;
    
    tm = sgetTaskId(CHILD_MOVE);
    tm--;
    
    if(childList.count > tm && tm>=0){
        toMove = childList[tm];
        char usrResp =' ';
        bool v = false;
        while(!v){
            usrResp = getChar("Move to [S]ame parent, or [D]ifferent parent: ");
            v = (usrResp == 'S' || usrResp == 'D');
            switch(usrResp){
                case 'S':
                    break;
                case 'D':
                    moveChildtoOtherParent(parentList, childList, toMove, tm);
                    return;
                default:
                    printf("Invalid input, try again.\n");
                    break;
            }
        }
        tr = sgetTaskId(CHILD_DISPLACE);
        tr--;
    }else{
        printf("Cannot find child ID.\n");
        return;
    }
    if(childList.count > tr && tr!=tm && tr>=0){
        [childList insertObject:toMove atIndex:tr];
        (tr > tm) ? [childList removeObjectAtIndex:tm] : [childList removeObjectAtIndex:tm+1];
    }else if (childList.count == tr){
        [childList addObject:toMove];
        [childList removeObjectAtIndex:tm];
    }else if (tr==tm && tr>=0){
        printf("There is nothing to do.\n");
    }else{
        printf("Cannot find child ID.\n");
    }
}

//Prompt user for parent ID to displace, if valid and different, insert object at new index and remove from old index
void moveParent(NSMutableArray *parentList, ParentTask *pTask, int pid){
    int tr = sgetTaskId(PARENT_DISPLACE);
    tr--;
    
    if(parentList.count > tr && tr!=pid && tr>=0){
        [parentList insertObject:pTask atIndex:tr];
        (tr > pid) ? [parentList removeObjectAtIndex:pid] : [parentList removeObjectAtIndex:pid+1];
    }else if(parentList.count == tr){
        [parentList addObject:pTask];
        [parentList removeObjectAtIndex:pid];
    }else if (tr==pid && tr>=0){
        printf("There is nothing to do.\n");
    }else{
        printf("Cannot find parent to replace.\n");
    }
}

//Submenu, get parent ID. If children exist, prompt to move parent or child, otherwise, proceed to move parent.
void moveTaskMenu(NSMutableArray *parentList){
    ParentTask *pTask;
    int pid = 0;
    bool v = false;
    
    pid = getTaskId('P');
    pid--;
    
    if(parentList.count > pid && pid >= 0){
        pTask = parentList[pid];
    }
    if(pTask!=nil && [pTask.childTasks count]!=0){
        while(!v){
            char sel = ' ';
            sel = getChar("Move [P]arent or [C]hild: ");
            switch(sel){
                case 'P':
                    moveParent(parentList, pTask, pid);
                    v = true;
                    break;
                case 'C':
                    moveChild(parentList, pTask);
                    v = true;
                    break;
                default:
                    printf("Invalid input.\n");
                    break;
            }
        }
    }else if (pTask!=nil){
        moveParent(parentList, pTask, pid);
    }else{
        printf("Cannot find parent.\n");
    }
}
