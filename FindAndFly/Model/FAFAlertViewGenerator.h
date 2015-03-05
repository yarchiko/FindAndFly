//
//  DVBAlertViewGenerator.h
//  dvach-browser
//
//  Created by Mega on 13/02/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FAFAlertViewGenerator : NSObject

- (UIAlertView *)alertViewWithTitle:(NSString *)title
                        description:(NSString *)description;

@end
