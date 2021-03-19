//
//  Task.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"

//***ParentTask implementation***
@implementation ParentTask

//Set up a parent task's basic structure
-(id)getParentTask:(NSString *)desc taskId:(int)tid{
    
    self.taskDesc = desc;
    self.taskId = tid;
    self.childTasks = [[NSMutableArray alloc]init];
    
    return self;
}

-(void)addChildTasks:(ChildTask*)newChildTask{
    [self.childTasks addObject:newChildTask];
}
@end


//***ChildTask implementation***
@implementation ChildTask

//Set up a child task's basic structure
-(id)getChildTask:(NSString*)desc taskId:(int)tid parentTaskId:(int)pid{
    
    self.taskDesc = desc;
    self.taskId = tid;
    self.parentId = pid;
    
    return self;
}
@end
