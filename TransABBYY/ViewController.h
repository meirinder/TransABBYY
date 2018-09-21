//
//  ViewController.h
//  TransABBYY
//
//  Created by Savely on 18.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPConnector.h"
#import "JSONParser.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

-(void) translate; //Main application work
-(void) getMemoryData:(NSString*) textFromSearchfield;//Get information about translation history

@end

