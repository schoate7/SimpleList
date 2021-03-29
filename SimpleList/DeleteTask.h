//
//  DeleteTask.h - Functions to delete tasks from main parent array or a parent's child array.
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#ifndef DeleteTask_h
#define DeleteTask_h

/* reIndexParents - Accepts NSMutableArray top-level parent list as parameter, re-indexes task ID of parents according to index in array. */
void reIndexParents(NSMutableArray *parentList);

/*reIndexChildren - Accepts NSMutableArray top-level parent list as parameter, re-indexes all children of all parents. */
void reIndexChildren(NSMutableArray *parentList);

/* deleteChildTask - Accepts ParentTask pointer as parameter, prompts for ID and deletes a valid child ID. */
void deleteChildTask(ParentTask *pTask);

/* deleteTask - Accepts NSMutableArray parent list as a parameter, prompts to delete a parent task or re-direct to deleteChildTask */
void deleteTask(NSMutableArray *parentList);

#endif /* DeleteTask_h */
