//
//  Task.h - Defines task objects for use across the application, contains display functions.
//  ParentTask -  For use as first-level object in top-level array.
//  ChildTask - for use as second-level object in a ParentTask's child array.
//
//  SimpleList
//
//  Created by Stephen Choate on 3/16/21.
//
#ifndef Task_h
#define Task_h

/* ParentTask object - Extends NSObject. Contains a task description (NSString) and child task array (NSMutableArray) */
@interface ParentTask : NSObject <NSSecureCoding>
@property (retain) NSString *taskDesc;
@property (retain) NSMutableArray *childTasks;
@property (readwrite) BOOL requiresSecureCoding;

/* getParentTask - Accepts NSString description as parameter, returns ParentTask pointer */
-(id)getParentTask:(NSString *)desc;

/* updateDesc - Accepts NSString new description as parameter, updates description object */
-(void)updateDesc:(NSString*)newDesc;

/* addChildTasks - Accepts NSString  as paraemter, adds to childTasks array */
-(void)addChildTask:(NSString*)newChildTask;

/* encodeWithCoder - Allows encoding with encoder, sets encoder keys */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/* initWithCoder - Allows class to be initialized with decoder, sets decoder keys */
-(id)initWithCoder:(NSCoder *)aDecoder;

/* supportsSecureCoding - Return true to NSKeyedArchiver */
+(BOOL)supportsSecureCoding;

@end

/* getChar - Accepts a char* input parameter to prompt user. Prompts user with string, returns input character. */
char getChar(char *prompt);

/* getTaskId - Accepts a char taskType parameter to determine parent or child prompt. Prompts user for task ID, returns integer value. */
int getTaskId(char taskType);

/* viewSingleParent - Accepts NSMutableArray parent list as parameter. Prompts user for parent task ID, displays parent and any children. */
void viewSingleParent(NSMutableArray *parentList);

/* displayTaskList - Accepts NSMutableArray parent list as parameter. Displays all parents and their children. */
void displayTaskList(NSMutableArray *parentList);

#endif
