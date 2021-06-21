//
//  Kanban.h - A Kanban board feature to display task status. Contains menu driver, board display, and status set functions.
//  SimpleList
//
//  Created by Stephen Choate on 4/23/21.
//

#ifndef Kanban_h
#define Kanban_h

/* setStatus - Prompt user for status, display existing status (if exists) set status on task. */
void setStatus(NSMutableArray *parentList);

/* displayBoard - Display kanban board to user, separated by status */
void displayBoard(NSMutableArray *parentList);

/* kanbanMenu - Menu driver for kanban feature. */
void kanbanMenu(NSMutableArray *parentList);

#endif /* Kanban_h */
