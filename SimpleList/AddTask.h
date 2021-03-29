//
//  AddTask.h - Functions to add tasks to the parent list, or child array of a parent.
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef TaskFunc_h
#define TaskFunc_h

/* getDesc - Accepts no parameters, prompts user for a task description, returns initialized NSString. */
NSString *getDesc(void);

/* addParentTask - Accepts NSMutableArray parent list, calls getDesc, adds parent to array. */
void addParentTask(NSMutableArray *parentList);

/* addChildTask - Accepts NSMutableArray parent list, prompts user for parent ID, calls getDesc, adds a child to specified valid parent's child array. */
void addChildTask(NSMutableArray *parentList);

/* addTask - Accepts NSMutableArray parent list, prompts user for parent or child add */
void addTask(NSMutableArray *parentList);

#endif /* AddTask_h */
