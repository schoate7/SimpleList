//
//  Task.h
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef Task_h
#define Task_h

//Child task object definition
@interface ChildTask : NSObject
@property NSString *taskDesc;
@property int taskId;
@property int parentId;

-(id)getChildTask:(NSString*)desc taskId:(int)tid parentTaskId:(int)pid;

@end


//Parent task object definition
@interface ParentTask : NSObject
@property NSString *taskDesc;
@property int taskId;
@property (retain) NSMutableArray *childTasks;

-(id)getParentTask:(NSString *)desc taskId:(int)tid;

-(void)addChildTasks:(ChildTask*)newChildTask;

@end

#endif
