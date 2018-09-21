//
//  JSONParser.h
//  TransABBYY
//
//  Created by Savely on 21.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif
#import <Foundation/Foundation.h>

@interface JSONParser : NSObject{
    NSData *JSONData;
    NSString *resultString;
}
@property NSData *JSONData;

-(void) recursiveParse: (NSDictionary*) parsed space: (BOOL) space; // Recursively parses the file and fills the result string
-(NSString*) parse;//Entry point and start of file analysis

@end
