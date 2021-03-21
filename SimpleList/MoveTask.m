//
//  MoveTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "DeleteTask.h"

//moveChild goes here

void moveParent(NSMutableArray *parentList){
    ParentTask *toMove;
    ParentTask *replaced;
    int usrIn;
    int tm;
    int tr;
    NSLog(@"Enter parent task to move ID: ");
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
            replaced = (pt.taskId.intValue == tr) ? pt : replaced;
        }
        if (replaced!=nil){
            if(tr != tm){
                [parentList insertObject:toMove atIndex:tr-1];
                (tr > tm) ? [parentList removeObjectAtIndex:tm-1] : [parentList removeObjectAtIndex:tm];
                reIndexParents(parentList);
            }else{
                NSLog(@"There is nothing to do.");
            }
        }
    }else{
        NSLog(@"Not a valid parent ID");
    }
}

//Main menu for moving task
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
                //child routines
            default:
                NSLog(@"Invalid input.");
        }
    }
}
