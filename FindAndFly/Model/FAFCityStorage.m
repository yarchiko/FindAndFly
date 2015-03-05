//
//  FAFCityStorage.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FAFCityStorage.h"
#import "FAFLocation.h"
#import "FAFNetworking.h"
#import "FAFCity.h"
#import "FAFCityViewCell.h"

static NSString *const CITY_CELL_REUSE_IDENTIFIER = @"cityViewCell";

@interface FAFCityStorage () <FAFLocationDelegate>

@property (strong, nonatomic) NSMutableArray *privateCities;
@property (strong, nonatomic) FAFLocation *location;
@property (strong, nonatomic) FAFNetworking *networking;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longtitude;

@end

@implementation FAFCityStorage

- (instancetype)init {
    self = [super init];
    if (self) {
        _privateCities = [NSMutableArray array];
        [self launchLocationGetting];
        _networking = [[FAFNetworking alloc] init];
    }
    
    return self;
}

- (void)launchLocationGetting {
    _location = [FAFLocation sharedLocation];
    _location.locationDelegate = self;
}

- (void)getCities {
    if (_latitude && _longtitude) {
        [self getResultsWithLatitude:_latitude andLongtitude:_longtitude];
    }
    else {
        NSLog(@"Error - no longtitude and (or) latitude");
    }
}

#pragma mark - FAFLocationDelegate

- (void)getResultsWithLatitude:(NSString *)latitude
                 andLongtitude:(NSString *)longtitude {
    _latitude = latitude;
    _longtitude = longtitude;
    [_networking getTownsFromNetworkWithLatitude:latitude
                                   andLongtitude:longtitude
                                   andCompletion:^(NSDictionary *citiesAnswer)
    {
        NSArray *countries = citiesAnswer[@"Countries"];

        NSArray *cities = countries[0][@"Cities"];
        for (id cityJSONObject in cities) {
            NSString *city = cityJSONObject[@"City"];
            NSString *name = cityJSONObject[@"NameRu"];
            
            FAFCity *fafCity = [[FAFCity alloc] initWithName:name
                                                  andCity:city];
            [_privateCities addObject:fafCity];
        }
        _cities = _privateCities;
        [_cityStorageDelegate updateTable];
        _privateCities = [NSMutableArray array];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [_cities count];
}

- (FAFCityViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAFCityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CITY_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    FAFCity *city = _cities[row];
    [cell prepareCellWithCity:city];

    return cell;
}

- (NSString *)getCityWithIndex:(NSUInteger)index {
    FAFCity *city = _cities[index];
    NSString *cityString = city.city;
    
    return cityString;
}

@end
