//
//  FAFAirCompany.m
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFAirCompany.h"

@implementation FAFAirCompany

/**
 *  Запрещаем вызов init
 *
 *  @return всегда nil
 */
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Stricted" reason:@"Use [[FAFAirCompany alloc] initWithName:andCity:]" userInfo:nil];
    
    return nil;
}

- (instancetype)initWithCode:(NSString *)code
                  andMinFare:(NSString *)minFare
                    andFares:(NSArray *)fares {
    self = [super self];
    if (self) {
        _code = code;
        _minFare = minFare;
        _fares = fares;
    }
    
    return self;
}

@end
