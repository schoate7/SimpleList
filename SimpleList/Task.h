//
//  Task.h
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef Task_h
#define Task_h

//Child task object definition
@interface ChildTask : NSObject ///<NSSecureCoding>
@property NSString *taskDesc;
@property NSNumber *taskId;
@property int parentId;
@property(readwrite) BOOL requiresSecureCoding;

-(id)getChildTask:(NSString*)desc taskId:(NSNumber *)tid;

-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id)initWithCoder:(NSCoder *)aDecoder;

///+(BOOL)supportsSecureCoding;

@end


//Parent task object definition
@interface ParentTask : NSObject ///<NSSecureCoding>
@property NSString *taskDesc;
@property NSNumber *taskId;
@property (retain) NSMutableArray *childTasks;
@property(readwrite) BOOL requiresSecureCoding;

-(id)getParentTask:(NSString *)desc taskId:(NSNumber *)tid;

-(void)addChildTasks:(ChildTask*)newChildTask;

-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id)initWithCoder:(NSCoder *)aDecoder;

///+(BOOL)supportsSecureCoding;

@end

#endif
