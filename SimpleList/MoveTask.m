//
//  MoveTask.m
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Common.h"

#define TO_MOVE "Task ID to move: "
#define TO_DISPLACE "Task ID to displace (end to put at end): "

static bool insertAtChildEnd(char *input){
    NSString *inString = [NSString stringWithUTF8String:input];
    NSError *err = nil;
    size_t inLen = [inString length];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"^[0-9][.][e][n][d]*$" options:NSRegularExpressionCaseInsensitive error:&err];
    NSUInteger numberOfMatches = [regEx numberOfMatchesInString:inString options:0 range:NSMakeRange(0, inLen)];
    
    return (numberOfMatches>0);
}

static bool insertAtEnd(char *input){
    NSString *inString = [NSString stringWithUTF8String:input];
    NSError *err = nil;
    size_t inLen = [inString length];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"^[e][n][d]*$" options:NSRegularExpressionCaseInsensitive error:&err];
    NSUInteger numberOfMatches = [regEx numberOfMatchesInString:inString options:0 range:NSMakeRange(0, inLen)];
    
    return (numberOfMatches>0);
}

//Move a parent task to another position within the parent list
static void parentToParent(NSMutableArray *parentList, int tmParent, int trParent){
    if(trParent == tmParent){
        printf("There's nothing to do.\n");
    }
    if(parentList.count > trParent && trParent>=0){
        Task *taskToMove = parentList[tmParent];
        [parentList insertObject:taskToMove atIndex:trParent];
        (tmParent > trParent) ? [parentList removeObjectAtIndex:tmParent+1] : [parentList removeObjectAtIndex:tmParent];
    }else if(parentList.count == trParent && trParent>=0){ //Insert at end if index is list size
        Task *taskToMove = parentList[tmParent];
        [parentList addObject:taskToMove];
        [parentList removeObjectAtIndex:tmParent];
    }
}

//Make a parent task a child of another parent if parent does not have any child tasks
static void parentToChild(NSMutableArray *parentList, int tmParent, int trParent, int trChild){
    Task *parentToMove = parentList[tmParent];
    if(parentToMove.childTasks.count>0){
        printf("Cannot make a parent task with children a child task.\n");
    }else{
        Task *insertInto = parentList[trParent];
        NSMutableArray *newChildList = insertInto.childTasks;
        NSString *newChild = parentToMove.taskDesc;

        (newChildList.count > trChild) ? [newChildList insertObject:newChild atIndex:trChild] : [newChildList addObject:newChild];
        [parentList removeObjectAtIndex:tmParent];
    }
}

//Convert a child task to a parent task
static void childToParent(NSMutableArray *parentList, NSString *toMove, NSMutableArray *originalChildList, int parentId, int tmChild){
    Task *newPT = [[Task alloc]init];
    [newPT getParentTask:toMove];
    if(parentList.count > parentId){
        [parentList insertObject:newPT atIndex:parentId];
        [originalChildList removeObjectAtIndex:tmChild];
    }else if(parentList.count<=parentId){
        [parentList addObject:newPT];
        [originalChildList removeObjectAtIndex:tmChild];
    }
}

//Move child task within a the same parent task
static void childToChild(NSMutableArray *childList, NSString *toMove, int tmChild, int trChild){
    if(childList.count > trChild && trChild!=tmChild && trChild>=0){
        [childList insertObject:toMove atIndex:trChild];
        (trChild > tmChild) ? [childList removeObjectAtIndex:tmChild] : [childList removeObjectAtIndex:tmChild+1];
    }else if (childList.count <= trChild){
        [childList addObject:toMove];
        [childList removeObjectAtIndex:tmChild];
    }else if (trChild==tmChild && trChild>=0){
        printf("There is nothing to do.\n");
    }else{
        printf("Replacement child out of range.\n");
    }
}

//Move child task to be a child of another parent task
static void childToOtherChild(NSMutableArray *originalChildList, NSMutableArray *newChildList, NSString *toMove, int tmChild, int trChild){
    if((newChildList.count == 0 && trChild>=0) || newChildList.count <=trChild){
        [newChildList addObject:toMove];
        [originalChildList removeObjectAtIndex:tmChild];
    }else if(newChildList.count > trChild && trChild >=0){
        [newChildList insertObject:toMove atIndex:trChild];
        [originalChildList removeObjectAtIndex:tmChild];
    }else{
        printf("Can't find child to displace.\n");
    }
}

//Move task, prompts for task IDs, intercepts exit characters, tests for 'end' text, moves tasks throughout list
void moveTask(NSMutableArray *parentList){
    Task *pt;
    NSMutableArray *originalChildList;
    NSMutableArray *newChildList;
    NSString *descriptionToMove;
    char *input = (char*)malloc(32);
    int moveChild, moveParent, replaceChild, replaceParent;
    
    printf("%s", TO_MOVE);
    scanf(" ");
    fgets(input, 32, stdin);
    moveChild = getId([NSString stringWithUTF8String:input], 'C');
    moveParent = getId([NSString stringWithUTF8String:input], 'P');
    
    if(quitChar(moveChild, moveParent)){
        printf("Exiting with no changes.\n");
        free(input);
        return;
    }else{
        moveChild--;
        moveParent--;
    }
    
    if(moveChild == -2 && moveParent == -2){
        printf("Invalid task ID, exiting.\n");
        free(input);
        return;
    }else if (moveParent > parentList.count){
        printf("Parent ID out of range.\n");
        free(input);
        return;
    }else if (moveChild > -1){
        pt = parentList[moveParent];
        originalChildList = pt.childTasks;
        if(moveChild > originalChildList.count){
            printf("Child ID out of range.\n");
            free(input);
            return;
        }else{
            descriptionToMove = originalChildList[moveChild];
        }
    }else{
        pt = parentList[moveParent];
    }
    
    printf("%s", TO_DISPLACE);
    scanf(" ");
    fgets(input, 32, stdin);
    replaceChild = getId([NSString stringWithUTF8String:input], 'C');
    replaceParent = getId([NSString stringWithUTF8String:input], 'P');
    
    if(quitChar(replaceChild, replaceParent)){
        printf("Exiting with no changes.\n");
        free(input);
        return;
    }else{
        replaceChild--;
        replaceParent--;
    }
    
    if (replaceChild == -2 && replaceParent == -2){
        if(insertAtChildEnd(input)){
            NSString *strIn = [NSString stringWithUTF8String:input];
            NSArray *strComponents = [strIn componentsSeparatedByString:@"."];
            NSString *newParentReplaceValue = strComponents[0];
            replaceParent = newParentReplaceValue.intValue-1;
            pt = parentList[replaceParent];
            newChildList = pt.childTasks;
            replaceChild = (int)pt.childTasks.count;
        }else if(insertAtEnd(input)){
            replaceParent = (int)parentList.count;
        }else{
            printf("Invalid task ID, exiting.\n");
            free(input);
            return;
        }
    }else if (replaceParent > parentList.count){
        printf("Parent ID out of range.\n");
        free(input);
        return;
    }else if (replaceChild>-1){
        pt = parentList[replaceParent];
        newChildList = pt.childTasks;
        if(replaceChild > newChildList.count){
            printf("Child ID out of range.\n");
            free(input);
            return;
        }
    }
    
    if ((moveParent>-1 && replaceParent>-1) && (moveChild==-2 && replaceChild==-2)){
        parentToParent(parentList, moveParent, replaceParent);
    }
    else if((moveParent>-1 && replaceParent>-1) && (moveChild>-1 && replaceChild==-2)){
        childToParent(parentList, descriptionToMove, originalChildList, replaceParent, moveChild);
    }
    else if ((moveParent>-1 && replaceParent>-1) && (moveChild==-2 && replaceChild>-1)){
        parentToChild(parentList, moveParent, replaceParent, replaceChild);
    }else if ((moveParent>-1 && replaceParent>-1 && moveChild>-1 && replaceChild>-1)){
        if(moveParent == replaceParent){
            childToChild(originalChildList, descriptionToMove, moveChild, replaceChild);
        }else{
            childToOtherChild(originalChildList, newChildList, descriptionToMove, moveChild, replaceChild);
        }
    }else{
        printf("An error has occurred, no changes made.\n");
    }
    free(input);
}
