//
//  MoveTask.h - Functions to move a task's location in an array, or a child from one parent to another.
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#ifndef MoveTask_h
#define MoveTask_h

/* moveChildtoOtherParent - Accepts NSMutableArray parent list pointer, NSMutableArray origChildList pointer, ChildTask to be moved pointer, and child task's index as parameters. Prompts for new parent, moves child to new parent. */
void moveChildtoOtherParent(NSMutableArray *parentList, NSMutableArray *oChildList, NSString *ctm, int childIndex);

/* moveChild - Accepts NSMutableArray parent list, ParentTask pointers as parameters. Prompts user for child task, and if move is to another parent. Moves child task within same parent's array or re-directs to moveChildtoOtherParent. */
void moveChild(NSMutableArray *parentList, ParentTask *pTask);

/* moveParent - Accepts NSMutableArray parent list, ParentTask as pointers, integer index of parent as parameters. Prompts user and moves parent task within top-level array. */
void moveParent(NSMutableArray *parentList, ParentTask *pTask, int pid);

/* moveTask - A submenu function, accepts NSMutableArray parent list pointer as parameter. Prompts user for parent ID, if children, prompts for moving parent or child. Re-directs to selected function. */
void moveTaskMenu(NSMutableArray *parentList);

#endif /* MoveTask_h */
