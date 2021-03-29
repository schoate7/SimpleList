//
//  ViewTaskList.h - Functions for displaying the task list.
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//
#ifndef ViewTaskList_h
#define ViewTaskList_h
#include "Task.h"

/* viewSingleParent - Accepts NSMutableArray parent list as parameter. Prompts user for parent task ID, displays parent and any children. */
void viewSingleParent(NSMutableArray *parent);

/* displayTaskList - Accepts NSMutableArray parent list as parameter. Displays all parents and their children. */
void displayTaskList(NSMutableArray *parent);

#endif /* ViewTaskList_h */
