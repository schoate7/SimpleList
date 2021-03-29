//
//  Task.h - Defines task objects for use across the application.
//  ParentTask -  For use as first-level object in top-level array.
//  ChildTask - for use as second-level object in a ParentTask's child array.
//
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef Task_h
#define Task_h

/* ChildTask object - Extends NSObject. Contains a task description (NSString), task id (NSNumber), parent id (int) (for association with a ParentTask).*/
@interface ChildTask : NSObject
@property NSString *taskDesc;
@property NSNumber *taskId;
@property int parentId;
@property(readwrite) BOOL requiresSecureCoding;

/* getChildTask - Accepts an NSString description and NSNumber task ID as parameters, returns ChildTask pointer */
-(id)getChildTask:(NSString*)desc taskId:(NSNumber *)tid;

/* updateDesc - Accepts an NSString description to update an existing object's description */
-(void)updateDesc:(NSString*)newDesc;

/* encodeWithCoder - Allows encoding with an encoder, sets encoder keys */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/* initWithCoder - Allows class to be initialized with coder, sets decoder keys */
-(id)initWithCoder:(NSCoder *)aDecoder;

@end


/* ParentTask object - Extends NSObject. Contains a task description (NSString), task id (NSNumber), and child task array (NSMutableArray) */
@interface ParentTask : NSObject
@property NSString *taskDesc;
@property NSNumber *taskId;
@property (retain) NSMutableArray *childTasks;
@property(readwrite) BOOL requiresSecureCoding;

/* getParentTask - Accepts NSString description, NSNumber task ID as parameters, returns ParentTask pointer */
-(id)getParentTask:(NSString *)desc taskId:(NSNumber *)tid;

/* updateDesc - Accepts NSString new description as parameter, updates description object */
-(void)updateDesc:(NSString*)newDesc;

/* addChildTasks - Accepts ChildTask object as paraemter, adds ChildTask to childTasks array */
-(void)addChildTasks:(ChildTask*)newChildTask;

/* encodeWithCoder - Allows encoding with an encoder, sets encoder keys */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/* initWithCoder - Allows class to be initialized with coder, sets decoder keys */
-(id)initWithCoder:(NSCoder *)aDecoder;

@end

#endif
