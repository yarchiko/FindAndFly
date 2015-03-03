//
//  AppDelegate.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self appearanceTudeUp];
    [self manageAFNetworking];
    
    return YES;
}

/**
 *  Настройки AFNetworking, которые нужно делать как можно раньше и одиножды.
 */
- (void)manageAFNetworking {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

/**
 *  Настройка внешнего вида.
 */
- (void)appearanceTudeUp {
    /**
     *  UILabel для tableViewCell headers
     *  В iOS 8+ по умолчанию он слишком большой.
     */
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class],nil] setFont:[UIFont boldSystemFontOfSize:11.0f]];
}

@end
