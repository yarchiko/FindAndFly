//
//  FAFCityStorage.h
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FAFCityStorageDelegate <NSObject>

- (void)updateTable;

@end

@interface FAFCityStorage : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<FAFCityStorageDelegate> cityStorageDelegate;
@property (strong, nonatomic) NSArray *cities;

- (void)getCities;
- (NSString *)getCityWithIndex:(NSUInteger)index;

@end
