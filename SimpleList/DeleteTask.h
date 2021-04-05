//
//  DeleteTask.h - Functions to delete tasks from main parent array or a parent's child array.
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#ifndef DeleteTask_h
#define DeleteTask_h

/* deleteTask - Accepts NSMutableArray parent list as a parameter, prompts for task ID to delete. Deletes if available, prompts user to confirm if deleting a parent with child tasks. */
void deleteTask(NSMutableArray *parentList);

#endif /* DeleteTask_h */
