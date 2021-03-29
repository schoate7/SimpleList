//
//  MoveTask.h - Functions to move a task's location in an array, or a child from one parent to another.
//  SimpleList
//
//  Created by Stephen Choate on 3/20/21.
//

#ifndef MoveTask_h
#define MoveTask_h

/* moveChildtoOtherParent - Accepts NSMutableArray parent list pointer, NSMutableArray origChildList pointer, and ChildTask pointer as parameters. */
void moveChildtoOtherParent(NSMutableArray *parentList, NSMutableArray *origChildList, ChildTask *ctm);

/* moveChild - Accepts NSMutableArray parent list pointer as parameter. Prompts user and moves child task within a parent's array. Prompts user to move child to another parent, re-directs to moveChildtoOtherParent. */
void moveChild(NSMutableArray *parentList);

/* moveParent - Accepts NSMutableArray parent list pointer as parameter. Prompts user and moves parent task within top-level array. */
void moveParent(NSMutableArray *parentList);

/* moveTask - A submenu function, accepts NSMutableArray parent list pointer as parameter. Prompts user to delete a parent or child task, re-directs to selected function. */
void moveTask(NSMutableArray *parentList);

#endif /* MoveTask_h */
