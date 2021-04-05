//
//  EditTask.h - Functions to edit tasks (menu, parent, child)
//  SimpleList
//
//  Created by Stephen Choate on 3/29/21.
//

#ifndef EditTask_h
#define EditTask_h

/* editChildTask - Accepts childList and childIndex from menu as as parameters. Displays existing description, prompts user for replacement text. */
void editChildTask(NSMutableArray *childList, int childIndex);

/* editParentTask - Accepts ParentTask as parameter. Displays current description and prompts user for input to update description. */
void editParentTask(ParentTask *pTask);

/* editTaskMenu - Accepts NSMutableArray parent list as parameter. Drives main submenu, prompts user for task ID. If regex processed to have a child task, proceed to edit child task. Else, edit parent task. */
void editTaskMenu(NSMutableArray *parentList);

#endif /* EditTask_h */
