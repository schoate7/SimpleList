//
//  DeleteTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Common.h"

//Prompt for task ID to delete. If a parent, if children exist, prompt to confirm. If a child or parent without children, delete.
void deleteTask(NSMutableArray *parentList){
    char *input = (char*)malloc(32);
    printf("Task ID to Delete: ");
    scanf(" ");
    fgets(input, 32, stdin);
    NSString *inputString = [NSString stringWithUTF8String:input];
    
    int childIndex = getId(inputString, 'C');
    int parentIndex = getId(inputString, 'P');
    
    if(quitChar(childIndex, parentIndex)){
        printf("Exiting with no chnages.\n");
        free(input);
        return;
    }
    
    //If no child task in regex, assume parent task
    if(childIndex == -1){
        parentIndex = atoi(input);
        parentIndex--;
        if(parentList.count > parentIndex){
            Task *pt = parentList[parentIndex];
            if(pt.childTasks.count > 0){
                NSString *commandArgs = [NSString stringWithUTF8String:"[YN]"];
                char confirm = getChar("Child tasks detected, confirm delete [Y/N]: ", commandArgs);
                if(confirm == 'Y'){
                    [parentList removeObjectAtIndex:parentIndex];
                }else{
                    printf("Leaving parent %i unchanged.\n", parentIndex+1);
                }
            }else{
                [parentList removeObjectAtIndex:parentIndex];
            }
        }else{
            printf("No parent task at %i.\n", parentIndex+1);
        }
    
    //If regex decomposed into child and parent, process child deletion
    }else if(childIndex != -1 && parentIndex != -1){
        parentIndex--;
        if(parentList.count > parentIndex){
            Task *parent = parentList[parentIndex];
            NSMutableArray *childList = parent.childTasks;
            childIndex--;
            if(childList.count > childIndex){
                [childList removeObjectAtIndex:childIndex];
            }else{
                printf("No child task at %i.%i.\n",parentIndex+1,childIndex+1);
            }
        }else{
            printf("No parent task at %i.\n", parentIndex+1);
        }
    }else{
        printf("Unknown error.\n");
    }
    free(input);
}
