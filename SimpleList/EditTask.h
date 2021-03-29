//
//  EditTask.h - Functions to edit tasks (menu, parent, child)
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#ifndef EditTask_h
#define EditTask_h

/* editChildTask - Accepts NSMutableArray parent list as parameter. Prompts user to get to child task, displays current description and prompts user for input to update description. */
void editChildTask(NSMutableArray *parentList);

/* editParentTask - Accepts NSMutableArray parent list as parameter. Prompts user for parent task, displays current description and prompts user for input to update description.*/
void editParentTask(NSMutableArray *parentList);

/* editTaskMenu - Accepts NSMutableArray parent list as parameter. Drives main submenu, prompts user to edit parent or child task, re-directs to selected function. */
void editTaskMenu(NSMutableArray *parentList);

#endif /* EditTask_h */
