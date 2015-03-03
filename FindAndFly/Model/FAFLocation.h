//
//  FAFLocation.h
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FAFLocationDelegate <NSObject>

- (void)getResultsWithLatitude:(NSString *)latitude andLongtitude:(NSString *)longtitude;

@end

@interface FAFLocation : NSObject

+ (instancetype)sharedLocation;

@property (weak, nonatomic) id<FAFLocationDelegate> locationDelegate;

@property (strong, nonatomic, readonly) NSString *latitude;
@property (strong, nonatomic, readonly) NSString *longtitude;
@property (assign, nonatomic, readonly) BOOL isLocationProvided;
@property (assign, nonatomic) BOOL needMoreLocation;

@end
