//
//  FAFFareViewCell.m
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFFareViewCell.h"

@interface FAFFareViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation FAFFareViewCell

- (void)prepareCellWithTitle:(NSString *)title {
    _title.text = title;
}

@end
