//
//  main.m
//  SimpleList - A simple command line task list management tool with two task levels (parent and child), basic modification functions, and file save.
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"
#import "AddTask.h"
#import "DeleteTask.h"
#import "EditTask.h"
#import "MoveTask.h"
#import "ViewTaskList.h"
#import "FileIO.h"

//Main menu function - accept array pointer, loop through and accept user input to drive menu, call appropriate functions.
void mainMenu(NSMutableArray *parentList){
    char *usrIn = (char*)malloc(8);
    bool quitCd = false;
    NSLog(@"Main Menu:");
    NSLog(@"What would you like to do?");
    while(!quitCd){
        NSLog(@"[V]iew All, [P]arent, [A]dd, [E]dit, [D]elete, [M]ove, [S]ave, [Q]uit.");
        scanf(" %c", usrIn);
        *usrIn = toupper(*usrIn);
        quitCd = (*usrIn=='Q');
        switch(*usrIn){
            case 'V':
                displayTaskList(parentList);
                break;
            case 'A':
                addTask(parentList);
                break;
            case 'E':
                editTaskMenu(parentList);
                break;
            case 'D':
                deleteTask(parentList);
                break;
            case 'M':
                moveTask(parentList);
                break;
            case 'P':
                viewSingleParent(parentList);
                break;
            case 'S':
                saveArray(parentList);
                break;
            case 'Q':
                NSLog(@"Goodbye!");
                break;
            default:
                NSLog(@"Invalid input.");
                break;
        }
    }
}

//Application main - print greeting, initialize parent array (from file if available), call main menu.
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Welcome to Simple Task List");
        NSMutableArray *parentList = loadArray();
        mainMenu(parentList);
        return 0;
    }
}
