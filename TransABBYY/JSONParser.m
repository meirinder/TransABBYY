//
//  JSONParser.m
//  TransABBYY
//
//  Created by Savely on 21.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser
@synthesize JSONData;


-(void) recursiveParse: (NSDictionary*) parsedFile space: (BOOL) space{
    if ([[parsedFile allKeys] containsObject: @"Items"]) {
        for (int i = 0; i<[[parsedFile valueForKey: @"Items"] count]; i++) {
            if (space) {
                resultString = [resultString stringByAppendingString:@"\n     -" ];
            }else{
                resultString = [[[resultString stringByAppendingString:@"\n  "] stringByAppendingString: [NSString stringWithFormat:@"%d", i+1]] stringByAppendingString:@") "];
            }
            [self recursiveParse:[parsedFile valueForKey:@"Items"][i] space: true];
        }
    } else if ([[parsedFile allKeys] containsObject: @"Markup"]) {
        for (int i = 0; i<[[parsedFile valueForKey: @"Markup"] count]; i++) {
            [self recursiveParse:[parsedFile valueForKey:@"Markup"][i] space: space];
        }
    }else if ([[parsedFile allKeys] containsObject: @"Text"]){
        if ([[parsedFile valueForKey:@"Text"] isEqual:@"Syn:"]) {
            resultString = [resultString stringByAppendingString:@"\n   "];
        }
        resultString = [resultString stringByAppendingString:[parsedFile valueForKey:@"Text"]];
    }
}


-(NSString*) parse{
    if (JSONData == NULL) {
        return @"";
    }
    NSError * error;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
    NSDictionary *desiredDictionary = parsedObject[0];
    if (([[desiredDictionary allKeys] containsObject: @"Body"])==false) {
        return @"";
    }
    NSArray *itemsInBodyOfdesiredDictionary = [[desiredDictionary valueForKey:@"Body"][1] valueForKey:@"Items"];
    resultString = @"";
    resultString = [resultString stringByAppendingString: [[parsedObject[0] valueForKey: @"Title"] stringByAppendingString:@"\n"]];
    for (int i = 0 ; i<itemsInBodyOfdesiredDictionary.count; i++) {
        NSArray *typesOfLanguages = [[itemsInBodyOfdesiredDictionary[i] valueForKey: @"Markup"][0] valueForKey: @"Markup"];
        NSDictionary *parsedFile = [itemsInBodyOfdesiredDictionary[i] valueForKey: @"Markup"][1];
        resultString = [[resultString stringByAppendingString: [NSString stringWithFormat:@"%d", i+1]] stringByAppendingString:@". "];
        for (int j = 0; j<[typesOfLanguages count] ; j++) {
            resultString = [resultString stringByAppendingString: [typesOfLanguages[j] valueForKey: @"Text"]];
        }
        resultString = [resultString stringByAppendingString: @"\n"];
        [self recursiveParse:parsedFile space: false];
        resultString = [resultString stringByAppendingString: @"\n"];
    }
    return resultString;
}

@end
