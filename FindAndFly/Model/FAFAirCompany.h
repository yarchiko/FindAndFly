//
//  FAFAirCompany.h
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFAirCompany : NSObject

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *minFare;
@property (strong, nonatomic) NSArray *fares;

- (instancetype)initWithCode:(NSString *)code
                  andMinFare:(NSString *)minFare
                    andFares:(NSArray *)fares;

@end
