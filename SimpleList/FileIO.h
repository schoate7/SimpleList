//
//  FileIO.h - Functions for I/O to/from task list save file.
//  SimpleList
//
//  Created by Stephen Choate on 3/19/21.
//

#ifndef FileIO_h
#define FileIO_h

/* documentsDirectory - Returns NSString to documents directory. */
NSString* documentsDirectory(void);

/* dataFilePath - Returns NSString file path. */
NSString* dataFilePath(void);

/* loadArray - Attempts to load task list from file. If file is available, initializes top-level array and returns pointer. If no file found, initializes empty array and returns pointer. */
NSMutableArray* loadArray(void);

/* saveArray - Accepts NSMutableArray pointer to top-level array. Saves array to plist in documents directory using NSKeyedArchiver. */
void saveArray(NSMutableArray *array);

#endif /* FileIO_h */
