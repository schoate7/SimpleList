//
//  DeleteTask.h
//  SimpleList
//
//  Created by Stephen Choate on 3/18/21.
//

#ifndef DeleteTask_h
#define DeleteTask_h

void reIndexParents(NSMutableArray *parentList);

void reIndexChildren(NSMutableArray *parentList);

void deleteChildTask(ParentTask *pTask, int parentId);

void deleteTask(NSMutableArray *parentList);

#endif /* DeleteTask_h */
