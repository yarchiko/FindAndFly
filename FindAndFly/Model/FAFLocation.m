//
//  FAFLocation.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "FAFLocation.h"
#import "FAFAlertViewGenerator.h"

@interface FAFLocation () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) FAFAlertViewGenerator *alertViewGenenerator;

@end

@implementation FAFLocation

/**
 *  Запрещаем создавать несколько FAFLocation
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
 *  Первый инит - первичная настройка
 *
 *  @return FAFLocation
 */
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _alertViewGenenerator = [[FAFAlertViewGenerator alloc] init];
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
        
        if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
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
    NSString *alertTitle = NSLocalizedString(@"Локация недоступна", "Заголовок alertView, сообщающий о том, что пользователю не включил локацию в настройках");
    NSString *alertDescription = NSLocalizedString(@"Если ваше устройство поддерживает сервис Локации, разрешите использование локации в настройках телефона", @"Описание ошибки определния локации (alertView description)");
    UIAlertView *locationErrorAlertView = [_alertViewGenenerator alertViewWithTitle:alertTitle description:alertDescription];
    [locationErrorAlertView show];
    _isLocationProvided = NO;
    _locationDelegate = nil;
    NSLog(@"Error while getting location: %@", [error localizedDescription]);
}
@end
