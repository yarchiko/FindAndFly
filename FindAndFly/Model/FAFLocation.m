//
//  FAFLocation.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface FAFLocation () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation FAFLocation

/**
 *  Not permitting to create multiple instances of Singleton FAFLocation
 *
 *  @return always nil
 */
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[FAFlocation sharedLocation]" userInfo:nil];
    
    return nil;
}

+ (instancetype)sharedLocation {
    static FAFLocation *sharedLocation = nil;
    
    if (!sharedLocation) {
        sharedLocation = [[self alloc] initPrivate];
    }
    
    return sharedLocation;
}

/**
 *  First time initing - set default vals.
 *
 *  @return FAFLocation
 */
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _isLocationProvided = NO;
        _needMoreLocation = YES;
        _locationManager = [[CLLocationManager alloc] init];
        /**
         *  Точности в несколько километров нам вполне хватит, чтобы определить города с аэропортами вокруг
         */
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        // Code to check if the app can respond to the new selector found in iOS 8. If so, request it.
        /**
         *  В iOS 8 необходимо посылать ещё одно сообщение
         *  Проверяем селеектор
         *  Если откликается - посылаем сообщение
         */
        if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            /**
             *  Приложение не использует информацию о местоположении в фоновом режиме,
             *  поэтому нам хватит и этого метода.
             *  В противном случае - нужно использовать [self.locationManager requestAlwaysAuthorization];
             */
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];
        
        _locationManager.delegate = self;
        _location = [[CLLocation alloc] init];
    }
    
    return self;
}

#pragma  mark - CLLocationManagerDelegate

- (void)setLatitude:(NSString *)latitude
       andLongtitude:(NSString *)longtitude {
    _isLocationProvided = YES;
    _latitude = latitude;
    _longtitude = longtitude;
    /**
     *  Запуск делегатного метода
     */
    if (_needMoreLocation) {
        _needMoreLocation = NO;
        [_locationDelegate getResultsWithLatitude:latitude
                                    andLongtitude:longtitude];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations {
    _location = locations.lastObject;
    NSString *latitudeString = [NSString stringWithFormat:@"%f", _location.coordinate.latitude];
    NSString *longtitudeString = [NSString stringWithFormat:@"%f", _location.coordinate.longitude];
    /**
     *  Назначение параметров локации для доступа извне
     */
    [self setLatitude:latitudeString
        andLongtitude:longtitudeString];
    // NSLog(@"%@", _location.description);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    _isLocationProvided = NO;
    _locationDelegate = nil;
    NSLog(@"Error while getting location: %@", [error localizedDescription]);
}
@end
