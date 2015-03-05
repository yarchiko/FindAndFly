//
//  DVBAlertViewGenerator.m
//  dvach-browser
//
//  Created by Mega on 13/02/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFAlertViewGenerator.h"

@interface FAFAlertViewGenerator ()

@end

@implementation FAFAlertViewGenerator
/**
 *  Метод генерирует UIAlertView с заданными заголовком и описанием кнопкой ОК
 *
 *  @param title       Заголовок
 *  @param description Описание (инструкции)
 *
 *  @return объект UIAlertView
 */
- (UIAlertView *)alertViewWithTitle:(NSString *)title
                        description:(NSString *)description {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:description
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
    /**
     *  Не смотря на то что делегат self - в данном случае не страшно, потому что отлавливать нажатия кнопки ОК не требуется.
     */
    
    return alertView;
}

@end