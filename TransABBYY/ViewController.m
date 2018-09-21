//
//  ViewController.m
//  TransABBYY
//
//  Created by Savely on 18.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//



#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *resultField;

@property (strong, nonatomic) IBOutlet UITextField *searchField;


@end

@implementation ViewController


-(void) getMemoryData:(NSString*) textFromSearchfield{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastSearchReqests = [userDefaults objectForKey:@"lastSearchReqest"];
    if ([[lastSearchReqests componentsSeparatedByString:@" "] count]>9) {
        NSArray *arrayOfLastSearchReqests = [lastSearchReqests componentsSeparatedByString:@" "];
        lastSearchReqests = [lastSearchReqests substringWithRange:NSMakeRange([arrayOfLastSearchReqests[0] length]+1,
                                                    lastSearchReqests.length-([arrayOfLastSearchReqests[0] length]+1))];
    }
    if ([textFromSearchfield length]!=0) {
        lastSearchReqests = [[lastSearchReqests stringByAppendingString: @" "] stringByAppendingString:textFromSearchfield];
    }
    [userDefaults setObject:lastSearchReqests forKey:@"lastSearchReqest"];
    [userDefaults synchronize];
}


-(void) translate{
    NSString* token;
    HTTPConnector *httpConnector = [[HTTPConnector alloc] init];
    token = [httpConnector getTOKEN];
    NSData *responseData = [httpConnector getJsonByToken:token word:[_searchField text]];
    JSONParser * json = [[JSONParser alloc] init];
    [json setJSONData:responseData];
    NSString *resultString = [json parse];
    [_resultField setText:resultString];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self getMemoryData:textField.text];
    [self translate];
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_searchField setDelegate:self];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastSearchReqests = [userDefaults objectForKey:@"lastSearchReqest"];
    lastSearchReqests = [lastSearchReqests stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    _resultField.text = [@"Раньше вы искали: \n" stringByAppendingString: lastSearchReqests];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
