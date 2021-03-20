//
//  FileIO.h
//  SimpleList
//
//  Created by Stephen Choate on 3/19/21.
//

#ifndef FileIO_h
#define FileIO_h

NSString* documentsDirectory(void);

NSString* dataFilePath(void);

NSMutableArray* loadArray(void);

void saveArray(NSMutableArray *array);

#endif /* FileIO_h */
