//
//  main.m
//  SimpleList - A simple command line task list management tool with two task levels (parent and child), basic modification functions, and file save.
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import <unistd.h>
#import "Task.h"
#import "AddTask.h"
#import "DeleteTask.h"
#import "EditTask.h"
#import "MoveTask.h"
#import "Common.h"
#import "FileIO.h"
#import "Kanban.h"

#define charArgs @"[LADEMSQTK]"
#define argsSave @"[ADEM]"
#define optArgs "ladempick"

static bool interactiveMode = false;

//Function to print list of accepted command line arguments to user
void commandList(void){
    printf("-------------------------------\n");
    printf("Command List: \n");
    printf("L - List all active tasks.\n");
    printf("T - Print a single task and children.\n");
    printf("A - Add a task.\n");
    printf("D - Delete a task.\n");
    printf("E - Edit a task.\n");
    printf("M - Move a task.\n");
    printf("K - Kanban menu.\n");
    printf("I - Interactive mode (with menu).\n");
    printf("C - Command list (this).\n");
    printf("\"-e\"  - Exit any prompt.\n");
    printf("Single commands with argument auto-save.\n");
    printf("-------------------------------\n");
}

//Main menu function - accept array pointer, loop through and accept user input to drive menu, call appropriate functions.
void mainMenu(NSMutableArray *parentList, int opt){
    char sel = ' ';
    bool quitCd = false;
    if(interactiveMode){
        printf("Welcome to SimpleList!\n");
        printf("Logged in as: %s (%s).\n", [NSFullUserName().description UTF8String], [NSUserName().description UTF8String]);
        printf("**Changes in interactive mode must be saved before quitting.**");
        printf("\nWhat would you like to do?\n");
    }
    
    while(!quitCd){
        sel = (interactiveMode) ? getChar("[L]ist | [A]dd | [D]elete | [E]dit | [M]ove | [S]ave | [Q]uit: ", charArgs) : toupper(opt);
        quitCd = (sel=='Q' || sel == '!' || !interactiveMode);
        switch(sel){
            case 'L':
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
                moveTask(parentList);
                break;
            case 'S':
                saveArray(parentList);
                break;
            case 'T':
                viewSingleParent(parentList);
                break;
            case 'C':
                (!interactiveMode) ? commandList() : nil;
                break;
            case 'K':
                kanbanMenu(parentList);
                break;
            case 'Q': case '!':
                printf("Goodbye!\n");
                break;
            default:
                (interactiveMode) ? printf("Invalid input.\n") : printf("Usage: [-lpademi], \"-c\" for help \n");
                break;
            }
        if(!interactiveMode){
            for(int i=0; i<argsSave.length; i++){
                if(sel == [argsSave characterAtIndex:i]){
                    saveArray(parentList);
                }
            }
        }
    }
}

//Application main - handle arg input for single-command use, 'i' for interactive menu
int main(int argc, char *argv[]){
    int opt = 0;
    NSMutableArray *parentList = loadArray();
    opt = getopt(argc, argv, optArgs);
    interactiveMode = (opt == 'i');
    mainMenu(parentList, opt);
    return 0;
}
