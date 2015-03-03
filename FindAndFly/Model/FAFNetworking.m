//
//  FAFNetworking.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFNetworking.h"
#import "AFNetworking.h"

static NSString *const URL_BASE_FOR_AIRPORT_FINDING = @"https://www.anywayanyday.com/AirportFinder/";
static NSString *const URL_BASE_FOR_TICKETS_FINDING = @"https://www.anywayanyday.com/api/NewRequest2/";
static NSString *const URL_BASE_FOR_STATE_REQUEST = @"https://www.anywayanyday.com/api/RequestState/";

@implementation FAFNetworking

- (void)getTownsFromNetworkWithLatitude:(NSString *)latitude
                          andLongtitude:(NSString *)longtitude
                          andCompletion:(void (^)(NSDictionary *))completion {
    
    /**
     *  При первом запросе с AFNetworking используем такую конструкцию - для успешного дальнейшего мониторинга состояния сети.
     */
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
            NSDictionary *citiesParameters = @{@"Latitude":latitude, @"Longitude":longtitude, @"Radius":@"500", @"_Serialize":@"JSON"};
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects: @"text/plain",nil]];
            [manager GET:URL_BASE_FOR_AIRPORT_FINDING parameters:citiesParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completion(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error: %@", error);
                completion(nil);
            }];
        }
        else {
            NSLog(@"Internet is not here");
        }
    }];
}

- (void)getTicketsWith:(NSString *)date
           andCityFrom:(NSString *)cityFrom
             andCityTo:(NSString *)cityTo
                 andAd:(NSUInteger)ad
                 andCn:(NSUInteger)cn
                 andIn:(NSUInteger)inn
                 andSc:(NSString *)sc
         andCompletion:(void (^)(NSDictionary *))completion {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSString *routeParam = [NSString stringWithFormat:@"%@%@%@AD%@CN%@IN%@SC%@", date, cityFrom, cityTo, [@(ad) stringValue], [@(cn) stringValue], [@(inn) stringValue], sc];
        NSDictionary *ticketsParameters = @{@"Route":routeParam, @"_Serialize":@"JSON"};
        
        NSLog(@"tickets parameters: %@", ticketsParameters);

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        /**
         *  Чтобы получать всегда самые свежие результаты, отключаем локальное кеширование.
         */
        [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects: @"text/plain",nil]];
        [manager GET:URL_BASE_FOR_TICKETS_FINDING parameters:ticketsParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completion(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", error);
            completion(nil);
        }];
    }
    else {
        
    }
}

- (void)getStateOfSearchWith:(NSString *)idSynonim
               andCompletion:(void (^)(NSDictionary *))completion {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSDictionary *stateParameters = @{@"R":idSynonim, @"_Serialize":@"JSON"};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        /**
         *  Чтобы получать всегда самые свежие результаты, отключаем локальное кеширование.
         */
        [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects: @"text/plain",nil]];
        [manager GET:URL_BASE_FOR_STATE_REQUEST parameters:stateParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completion(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", error);
            completion(nil);
        }];
    }
    else {
        NSLog(@"There is no internet right now");
    }
}

@end
