//
//  FileIO.m
//  SimpleList
//
//  Created by Stephen Choate on 3/19/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Get logged in user's documents directory.
NSString* documentsDirectory(void)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

//Get data file path for read/write.
NSString* dataFilePath(void)
{
    return [documentsDirectory() stringByAppendingPathComponent:@"taskListFile.plist"];
}

//Load array from file, check for errors. If successful, return pointer to array, else, initialize and return a blank array.
NSMutableArray* loadArray(void)
{
    NSMutableArray *array;
    NSString *path = dataFilePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSSet *classes = [NSSet setWithObjects:[NSMutableArray class], [Task class],nil];
        NSError *err=nil;
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&err];
        [unarchiver setRequiresSecureCoding:YES];
        array = [unarchiver decodeObjectOfClasses:classes forKey:@"tasklist"];
        [unarchiver finishDecoding];
        if(err!=nil){
            NSLog(@"Error loading file, error code: %@",err);
        }
    } else {
        array = [[NSMutableArray alloc]init];
    }
    return array;
}

//Save list to plist file using NSKeyedArchiver.
void saveArray(NSMutableArray *array)
{
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
    [archiver encodeObject:array forKey:@"tasklist"];
    [archiver finishEncoding];
    NSData* data = [archiver encodedData];
    [data writeToFile:dataFilePath() atomically:YES];
}
