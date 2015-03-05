//
//  FAFAirlineViewCell.m
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFAirlineViewCell.h"

@interface FAFAirlineViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation FAFAirlineViewCell

- (void)prepareCellWithTitle:(NSString *)title
                   andDetail:(NSString *)detail {
    _title.text = title;
    _detail.text = detail;
}

@end
