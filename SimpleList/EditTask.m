//
//  EditTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Display existing child task description, prompt for replacement string and insert into parent's childTasks array.
void editChildTask(NSMutableArray *childList, int childIndex){
    char *input = (char*)malloc(4096);
    NSString *existingDesc = childList[childIndex];
    
    printf("Current description: %s", [existingDesc UTF8String]);
    printf("Change to:");
    scanf(" ");
    fgets(input, 4096, stdin);
    
    if(input!=nil){
        childList[childIndex] = [NSString stringWithUTF8String:input];
    }else{
        printf("Leaving description unchanged.\n");
    }
    free(input);
}

//Display parent task description from input parameter, prompt for replacement string and insert.
void editParentTask(ParentTask *pTask){
    char *input = (char*)malloc(4096);
    NSString *existingDesc = pTask.taskDesc;

    printf("Current description: %s", [existingDesc UTF8String]);
    printf("Change to: ");
    scanf(" ");
    fgets(input, 4096, stdin);
    
    if(input!=nil){
        [pTask updateDesc:[NSString stringWithUTF8String:input]];
    }else{
        printf("Leaving description unchanged.\n");
    }
    free(input);
}

//Submenu, prompt user for task ID, if a child is found direct to child editor, else assume editing parent.
void editTaskMenu(NSMutableArray *parentList){
    char *input = (char*)malloc(32);
    
    printf("Enter task ID to edit: ");
    scanf(" ");
    fgets(input, 32, stdin);
    NSString *inputString = [NSString stringWithUTF8String:input];
    
    int childIndex = getId(inputString, 'C');
    int parentIndex = getId(inputString, 'P');
    
    if(childIndex == -1){
        parentIndex = atoi(input);
        parentIndex--;
        if(parentList.count > parentIndex){
            editParentTask(parentList[parentIndex]);
        }else{
            printf("No parent task at %i.\n", parentIndex+1);
        }
    }else if (childIndex != -1 && parentIndex != -1){
        parentIndex--;
        childIndex--;
        if(parentList.count > parentIndex){
            ParentTask *pt = parentList[parentIndex];
            NSMutableArray *cl = pt.childTasks;
            if(cl.count > childIndex){
                editChildTask(cl,childIndex);
            }else{
                printf("No child task at %i.%i\n", parentIndex+1, childIndex+1);
            }
        }
        
    }else{
        printf("Unknown error.");
    }
}
