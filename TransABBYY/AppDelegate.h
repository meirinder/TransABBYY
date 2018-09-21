//
//  AppDelegate.h
//  TransABBYY
//
//  Created by Savely on 18.09.2018.
//  Copyright © 2018 Savely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

