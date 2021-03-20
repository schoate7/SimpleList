//
//  main.m
//  SimpleList - A simple task command line list management tool with child tasks.
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "AddTask.h"
#import "ViewTaskList.h"
#import "DeleteTask.h"
#import "FileIO.h"

//
void mainMenu(NSMutableArray *parentList){
    char *usrIn = (char*)malloc(8);
    bool quitCd = false;
    NSLog(@"Main Menu:");
    NSLog(@"What would you like to do?");
    while(!quitCd){
        NSLog(@"[V]iew tasks, [A]dd task, [D]elete task, [S]ave, [L]oad, [Q]uit.");
        scanf(" %c", usrIn);
        *usrIn = toupper(*usrIn);
        quitCd = (*usrIn=='Q');
        switch(*usrIn){
            case 'Q':
                NSLog(@"Goodbye!");
                break;
            case 'A':
                addTask(parentList);
                break;
            case 'D':
                deleteTask(parentList);
                break;
            case 'V':
                displayTaskList(parentList);
                break;
            case 'S':
                saveArray(parentList);
                break;
        }
    }
}

//Main
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Welcome to Simple Task List");
        NSMutableArray *parentList = loadArray();
        mainMenu(parentList);
        return 0;
    }
}
