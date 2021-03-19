//
//  TaskFunc.h
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef TaskFunc_h
#define TaskFunc_h

NSString *getDesc(void);

void addParentTask(NSMutableArray *parentList);

void addChildTask(NSMutableArray *parentList);

void addTask(NSMutableArray *parentList);

#endif
