//
//  Task.m
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#import <Foundation/Foundation.h>
#import "Task.h"

//ChildTask object
@implementation ChildTask

//Initialize and return a ChildTask from input description and task id
-(id)getChildTask:(NSString*)desc taskId:(NSNumber *)tid{
    self.taskDesc = desc;
    self.taskId = tid;
    self.requiresSecureCoding = YES;
    
    return self;
}

//Update description of task from input pointer to NSString
-(void)updateDesc:(NSString *)newDesc{
    self.taskDesc = newDesc;
}

//Initializes coder with encode keys
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.taskDesc forKey:@"childtaskdesc"];
    [aCoder encodeObject:self.taskId forKey:@"childtaskid"];
}

//Initializes decoder with decode keys
-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self.taskDesc = [aDecoder decodeObjectForKey:@"childtaskdesc"];
      self.taskId = [aDecoder decodeObjectForKey:@"childtaskid"];
  }
  return self;
}

@end

//ParentTask object
@implementation ParentTask

//Initialize and return a parent task from description and task id
-(id)getParentTask:(NSString *)desc taskId:(NSNumber *)tid{
    self.taskDesc = desc;
    self.taskId = tid;
    self.childTasks = [[NSMutableArray alloc]init];
    self.requiresSecureCoding = YES;
    
    return self;
}

//Update description of task from input pointer to NSString
-(void)updateDesc:(NSString*)newDesc{
    self.taskDesc = newDesc;
}

//Add a new child task to array from input pointer
-(void)addChildTasks:(ChildTask*)newChildTask{
    [self.childTasks addObject:newChildTask];
}

//Initializes coder with encode keys
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.taskDesc forKey:@"parenttaskdesc"];
    [aCoder encodeObject:self.taskId forKey:@"parenttaskid"];
    [aCoder encodeObject:self.childTasks forKey:@"childtaskobj"];
}

//Initializes decoder with decode keys
-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self.taskDesc = [aDecoder decodeObjectForKey:@"parenttaskdesc"];
      self.taskId = [aDecoder decodeObjectForKey:@"parenttaskid"];
      self.childTasks = [aDecoder decodeObjectForKey:@"childtaskobj"];
  }
  return self;
}

@end
