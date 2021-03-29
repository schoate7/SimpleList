//
//  FileIO.m
//  SimpleList
//
//  Created by Stephen Choate on 3/19/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

//Get logged in user's documents directory.
NSString* documentsDirectory()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

//Get data file path for read/write.
NSString* dataFilePath()
{
    return [documentsDirectory() stringByAppendingPathComponent:@"taskListFile.plist"];
}

//Load array from file, check for errors. If successful, return pointer to array, else, initialize and return a blank array.
NSMutableArray* loadArray()
{
    NSMutableArray *array;
    NSString *path = dataFilePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *err=nil;
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&err];
        [unarchiver setRequiresSecureCoding:NO];
        array = [unarchiver decodeObjectOfClass:[NSMutableArray class] forKey:@"tasklist"];
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
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:NO];
    [archiver encodeObject:array forKey:@"tasklist"];
    [archiver finishEncoding];
    NSData* data = [archiver encodedData];
    [data writeToFile:dataFilePath() atomically:YES];
}
