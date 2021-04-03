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
#import "FileIO.h"

//Main menu function - accept array pointer, loop through and accept user input to drive menu, call appropriate functions.
void mainMenu(NSMutableArray *parentList){
    char usrIn = ' ';
    bool quitCd = false;
    printf("\nWhat would you like to do?\n");
    while(!quitCd){
        usrIn = getChar("[V]iew All | [A]dd | [D]elete | [E]dit | [M]ove | [S]ave | [Q]uit: ");
        quitCd = (usrIn=='Q');
        switch(usrIn){
            case 'V':
                displayTaskList(parentList);
                break;
            case 'A':
                addTask(parentList);
                break;
            case 'D':
                deleteTask(parentList);
                break;
            case 'E':
                editTaskMenu(parentList);
                break;
            case 'M':
                moveTaskMenu(parentList);
                break;
            case 'S':
                saveArray(parentList);
                break;
            case 'P':
                viewSingleParent(parentList);
                break;
            case 'Q':
                printf("Goodbye!\n");
                break;
            default:
                printf("Invalid input.\n");
                break;
        }
    }
}

//Application main - print greeting, initialize parent array (from file if available), call main menu.
int main(int argc, const char * argv[]) {
    printf("Welcome to SimpleList!\n");
    printf("Logged in as: %s (%s).\n", [NSFullUserName().description UTF8String], [NSUserName().description UTF8String]);
    NSMutableArray *parentList = loadArray();
    mainMenu(parentList);
    return 0;
}
