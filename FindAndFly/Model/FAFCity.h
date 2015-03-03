//
//  FAFCity.h
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFCity : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *city;

-(instancetype)initWithName:(NSString *)name
                    andCity:(NSString *)city;

@end
