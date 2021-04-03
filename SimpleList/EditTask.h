//
//  EditTask.h - Functions to edit tasks (menu, parent, child)
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#ifndef EditTask_h
#define EditTask_h

/* editChildTask - Accepts ParentTask as parameter. Prompts user for child task ID, displays current description and prompts user for input to update description. */
void editChildTask(ParentTask *pTask);

/* editParentTask - Accepts ParentTask as parameter. Displays current description and prompts user for input to update description. */
void editParentTask(ParentTask *pTask);

/* editTaskMenu - Accepts NSMutableArray parent list as parameter. Drives main submenu, prompts user for parent task, if children exist, prompts to update parent or child */
void editTaskMenu(NSMutableArray *parentList);

#endif /* EditTask_h */
