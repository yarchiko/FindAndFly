//
//  FAFCityViewCell.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFCityViewCell.h"

@interface FAFCityViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation FAFCityViewCell

- (void)prepareCellWithCity:(FAFCity *)city {
    
    NSString *name = city.name;
    _nameLabel.text = name;
}

@end
