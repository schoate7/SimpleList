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
-(id)getParentTask:(NSString *)desc taskId:(NSNumber *)tid{
    
    self.taskDesc = desc;
    self.taskId = tid;
    self.childTasks = [[NSMutableArray alloc]init];
    self.requiresSecureCoding = YES;
    
    return self;
}

-(void)addChildTasks:(ChildTask*)newChildTask{
    [self.childTasks addObject:newChildTask];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.taskDesc forKey:@"parenttaskdesc"];
    [aCoder encodeObject:self.taskId forKey:@"parenttaskid"];
    [aCoder encodeObject:self.childTasks forKey:@"childtaskobj"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self.taskDesc = [aDecoder decodeObjectForKey:@"parenttaskdesc"];
      self.taskId = [aDecoder decodeObjectForKey:@"parenttaskid"];
      self.childTasks = [aDecoder decodeObjectForKey:@"childtaskobj"];
  }
  return self;
}

/*
+ (BOOL)supportsSecureCoding {
   return YES;
}*/

@end


//***ChildTask implementation***
@implementation ChildTask

//Set up a child task's basic structure
-(id)getChildTask:(NSString*)desc taskId:(NSNumber *)tid{
    
    self.taskDesc = desc;
    self.taskId = tid;
    self.requiresSecureCoding = YES;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.taskDesc forKey:@"childtaskdesc"];
    [aCoder encodeObject:self.taskId forKey:@"childtaskid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
  if(self = [super init]){
      self.taskDesc = [aDecoder decodeObjectForKey:@"childtaskdesc"];
      self.taskId = [aDecoder decodeObjectForKey:@"childtaskid"];
  }
  return self;
}

/*
+ (BOOL)supportsSecureCoding {
   return YES;
}*/

@end
