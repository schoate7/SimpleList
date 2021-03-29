//
//  MoveTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "DeleteTask.h"

//Prompt user for parent ID and child ID to place in and displace, move child task and remove from old parent.
void moveChildtoOtherParent(NSMutableArray *parentList, NSMutableArray *origChildList, ChildTask *ctm){
    int r = 0;
    NSLog(@"Parent ID to place in: ");
    scanf("%i",&r);
    for (ParentTask *pt in parentList){
        if (pt.taskId.intValue == r){
            int td = 0;
            NSMutableArray *cl = pt.childTasks;
            NSLog(@"Child ID to displace: ");
            scanf("%i", &r);
            for (ChildTask *ct in cl){
                td = (ct.taskId.intValue == r) ? ct.taskId.intValue : td;
            }
            if(td!=0){
                [pt.childTasks insertObject:ctm atIndex:td-1];
                int index=0;
                for (ChildTask *cld in origChildList){
                    if (cld != ctm){
                        index++;
                        
                    }else{
                        break;
                    }
                }
                [origChildList removeObjectAtIndex:index];
                reIndexChildren(parentList);
                return;
            }else{
                NSLog(@"An error occurred.");
            }
        }
    }
    return;
}

//Take parent ID input, if children exist, get child IDs, move child task if displacement is different than task to move
void moveChild(NSMutableArray *parentList){
    ParentTask *pTask;
    ChildTask *toMove;
    ChildTask *toDisplace;
    int usrIn, ptid, tm, td;
    NSLog(@"Enter parent task ID: ");
    scanf("%i",&usrIn);
    ptid=usrIn;
    for (ParentTask *pt in parentList){
        pTask = (pt.taskId.intValue==ptid) ? pt : pTask;
    }
    if(pTask!=nil){
        NSMutableArray *childList = pTask.childTasks;
        NSLog(@"Child ID to move: ");
        scanf("%i", &usrIn);
        tm=usrIn;
        for (ChildTask *ct in childList){
            toMove = (ct.taskId.intValue==tm) ? ct : toMove;
        }
        if(toMove!=nil){
            char usrResp =' ';
            int validIn=0;
            while(!validIn){
                NSLog(@"Move to [S]ame parent, or [D]ifferent parent?: ");
                scanf(" %c", &usrResp);
                usrResp = toupper(usrResp);
                validIn = (usrResp == 'S' || usrResp == 'D') ? 1 : 0;
                switch(usrResp){
                    case 'S':
                        break;
                    case 'D':
                        moveChildtoOtherParent(parentList, childList, toMove);
                        return;
                        break;
                    default:
                        NSLog(@"Invalid input, try again");
                        break;
                }
            }
            NSLog(@"Child ID to displace: ");
            scanf("%i", &usrIn);
            td=usrIn;
            for(ChildTask *ct in childList){
                toDisplace = (ct.taskId.intValue==td) ? ct : toDisplace;
            }
            if(toDisplace!=nil && tm != td){
                [childList insertObject:toMove atIndex:td-1];
                (td > tm) ? [childList removeObjectAtIndex:tm-1] : [childList removeObjectAtIndex:tm];
                reIndexChildren(parentList);
            }else if (tm == td){
                NSLog(@"There is nothing to do.");
            }else{
                NSLog(@"Can't find child task to displace.");
            }
        }else{
            NSLog(@"Can't find child task to move.");
        }
    }else{
        NSLog(@"Can't find parent ID.");
    }
}

//Prompt user for parent ID to move and replace, if valid and different, insert object at new index and remove from old index
void moveParent(NSMutableArray *parentList){
    ParentTask *toMove;
    ParentTask *toDisplace;
    int usrIn, tm, tr;
    NSLog(@"Enter parent task ID to move: ");
    scanf("%i", &usrIn);
    tm = usrIn;
    for (ParentTask *pt in parentList){
        toMove = (pt.taskId.intValue == tm) ? pt : toMove;
    }
    if (toMove!=nil){
        NSLog(@"What task ID to displace?: ");
        scanf("%i",&usrIn);
        tr=usrIn;
        for (ParentTask *pt in parentList){
            toDisplace = (pt.taskId.intValue == tr) ? pt : toDisplace;
        }
        if (toDisplace!=nil && tr != tm){
            [parentList insertObject:toMove atIndex:tr-1];
            (tr > tm) ? [parentList removeObjectAtIndex:tm-1] : [parentList removeObjectAtIndex:tm];
            reIndexParents(parentList);
        }else if(tr==tm){
                NSLog(@"There is nothing to do.");
        }else{
                NSLog(@"Not a valid ID to replace.");
            }
    }else{
        NSLog(@"Not a valid parent ID");
    }
}

//Submenu, prompt user to move parent or child, call requested function
void moveTask(NSMutableArray *parentList){
    @autoreleasepool {
        char *usrIn = malloc(8);
        NSLog(@"Move [P]arent or [C]hild Task?: ");
        scanf(" %c", usrIn);
        *usrIn = toupper(*usrIn);
        switch (*usrIn){
            case 'P':
                moveParent(parentList);
                break;
            case 'C':
                moveChild(parentList);
                break;
            default:
                NSLog(@"Invalid input.");
                break;
        }
    }
}
