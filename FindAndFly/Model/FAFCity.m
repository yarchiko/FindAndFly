//
//  FAFCity.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFCity.h"

@implementation FAFCity

/**
 *  Запрещаем вызов init
 *
 *  @return всегда nil
 */
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Stricted" reason:@"Use [[FAFCity alloc] initWithName:andCity:]" userInfo:nil];
    
    return nil;
}

-(instancetype)initWithName:(NSString *)name
                    andCity:(NSString *)city {
    self = [super init];
    if (self) {
        _name = name;
        _city = city;
    }
    return self;
}

@end
