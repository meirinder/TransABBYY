//
//  HTTPConnector.m
//  TransABBYY
//
//  Created by Savely on 21.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//

#import "HTTPConnector.h"

@implementation HTTPConnector

- (NSString*) getTOKEN{
    NSURL *theURL = [NSURL URLWithString:@"https://developers.lingvolive.com/api/v1/authenticate"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"text/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:[@"Basic " stringByAppendingString: APIKEY] forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    
    NSString * token =[[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
    token =[token stringByReplacingOccurrencesOfString:@"\"" withString:@""];

    return token;
    
}



-(NSData*) getJsonByToken:(NSString*) token word:(NSString*) word{
    if ([[word componentsSeparatedByString:@" "] count]>1) {
        return NULL;
    }
    NSString *firstPartOfURL = @"https://developers.lingvolive.com/api/v1/Translation/?text=";
    NSString *lastPartOfURL = @"&srcLang=1033&dstLang=1049";
    NSString *requestAdress = [[firstPartOfURL stringByAppendingString: word] stringByAppendingString:lastPartOfURL];
    NSURL *theURL = [NSURL URLWithString:requestAdress];

    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    [theRequest setHTTPMethod:@"GET"];
    [theRequest setValue:@"text/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"text/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:[@"Bearer " stringByAppendingString: token] forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    return   theResponseData;
}
@end
