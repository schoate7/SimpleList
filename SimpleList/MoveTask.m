//
//  MoveTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

#define TO_MOVE "Task ID to move: "
#define TO_DISPLACE "Task ID to displace: "

//Prompt for task ID to move, determine if parent or child. Prompt for task ID to displace, determine if parent or child. Insert accordingly.
void moveTask(NSMutableArray *parentList){
    ParentTask *parentToMove;
    NSMutableArray *originalChildList;
    NSMutableArray *newChildList;
    NSString *toMove;
    char *input = (char*)malloc(32);
    int tmChild, tmParent, trChild, trParent;
    
    printf("%s", TO_MOVE);
    scanf(" ");
    fgets(input, 32, stdin);
    tmChild = getId([NSString stringWithUTF8String:input], 'C');
    tmParent = getId([NSString stringWithUTF8String:input], 'P');
    tmChild--;
    tmParent--;
    
    //If no child task input detected, set up tm parent index, parent to move objects
    if(tmChild==-2){
        tmParent = atoi(input);
        tmParent--;
        if(parentList.count > tmParent){
            parentToMove = parentList[tmParent];
            toMove = parentToMove.taskDesc;
        }
    }
    
    //If parentToMove is not initialized, assume there's a child to be moved, check if child within range, set up toMove NSString
    if(parentToMove==nil && parentList.count > tmParent && tmParent>=0){
        ParentTask *origParent = parentList[tmParent];
        originalChildList = origParent.childTasks;
        if(originalChildList.count > tmChild && tmChild>=0){
            toMove = originalChildList[tmChild];
        }
    }
    
    if(toMove!=nil){
        printf("%s", TO_DISPLACE);
        scanf(" ");
        fgets(input, 32, stdin);
        trChild = getId([NSString stringWithUTF8String:input], 'C');
        trParent = getId([NSString stringWithUTF8String:input], 'P');
        
        //If both inputs are parent tasks, execute a move within main parent list
        if(trChild==-1 && parentToMove!=nil){
            trParent = atoi(input);
            trParent--;
            if(trParent == tmParent){
                printf("There's nothing to do.\n");
                return;
            }
            if(parentList.count > trParent && trParent>=0){
                ParentTask *taskToMove = parentList[tmParent];
                [parentList insertObject:taskToMove atIndex:trParent];
                (tmParent > trParent) ? [parentList removeObjectAtIndex:tmParent+1] : [parentList removeObjectAtIndex:tmParent];
                free(input);
                return;
            }else if(parentList.count == trParent && trParent>=0){ //Insert at end if index is list size
                ParentTask *taskToMove = parentList[tmParent];
                [parentList addObject:taskToMove];
                [parentList removeObjectAtIndex:tmParent];
                free(input);
                return;
            }
        }
        
        //If to move input does not have a child id, but to replace does, take desc and insert as child on dest parent at desired index
        if(trChild!=-1 && parentToMove!=nil){
            if(parentToMove.childTasks.count>0){
                printf("Cannot make a parent task with children a child task.\n");
            }else{
                trParent--;
                ParentTask *insertInto = parentList[trParent];
                NSMutableArray *newChildList = insertInto.childTasks;
                NSString *newChild = parentToMove.taskDesc;
                trChild--;
                
                (newChildList.count > trChild) ? [newChildList insertObject:newChild atIndex:trChild] : [newChildList addObject:newChild];
                [parentList removeObjectAtIndex:tmParent];
            }
            free(input);
            return;
        }
        
        //If to replace input does not have a child id, create a new parent task and insert into main list
        if(trChild==-1){
            int parentId = atoi(input);
            parentId--;
            if(parentList.count > parentId){
                NSString *desc = toMove;
                ParentTask *newPT = [[ParentTask alloc]init];
                [newPT getParentTask:desc];
                [parentList insertObject:newPT atIndex:parentId];
                [originalChildList removeObjectAtIndex:tmChild];
                free(input);
                return;
            }
        }else{
            trChild--;
            trParent--;
        }
        
        //If parent task for two child tasks is the same, move child within same parent task
        if(trParent == tmParent){
            if(originalChildList.count > trChild && trChild!=tmChild && trChild>=0){
                [originalChildList insertObject:toMove atIndex:trChild];
                (trChild > tmChild) ? [originalChildList removeObjectAtIndex:tmChild] : [originalChildList removeObjectAtIndex:tmChild+1];
            }else if (originalChildList.count <= trChild){
                [originalChildList addObject:toMove];
                [originalChildList removeObjectAtIndex:tmChild];
            }else if (trChild==tmChild && trChild>=0){
                printf("There is nothing to do.\n");
            }else{
                printf("Replacement child out of range.\n");
            }
            
        //If parent tasks are different, but both valid and in range, move child between two different parent task child arrays
        }else if(parentList.count > trParent && trParent>=0){
            ParentTask *newParent = parentList[trParent];
            newChildList = newParent.childTasks;
            if((newChildList.count == 0 && trChild>=0) || newChildList.count <=trChild){
                [newChildList addObject:toMove];
                [originalChildList removeObjectAtIndex:tmChild];
            }else if(newChildList.count > trChild && trChild >=0){
                [newChildList insertObject:toMove atIndex:trChild];
                [originalChildList removeObjectAtIndex:tmChild];
            }else{
                printf("Can't find child to displace.\n");
            }
            
        //Print error for exception scenarios
        }else if(parentList.count <= tmParent){
            printf("Cannot move child to non-existent parent.\n");
        }else if(tmParent == trParent && tmChild == trChild){
            printf("There is nothing to do.\n");
        }else{
            printf("An error occurred finding child.\n");
        }
    }else{
        printf("Cannot find task ID.\n");
    }
    free(input);
}
