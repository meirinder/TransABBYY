//
//  HTTPConnector.h
//  TransABBYY
//
//  Created by Savely on 21.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//
#define APIKEY @"MDI1NDgzNjMtNWE5My00OTcwLWJjNzgtNzYzYzliY2NhODc0OjE0N2RhYjM2YWMyNjRlMzNiYzcwZGEzOGY2ZmRiZjUw"

#import <Foundation/Foundation.h>

@interface HTTPConnector : NSObject{
    
}

- (NSString*) getTOKEN; //Retrieving a token using a post query 
- (NSData*) getJsonByToken:(NSString*) convertedStr word:(NSString*) word; //Get a JSON file using get query
@end
