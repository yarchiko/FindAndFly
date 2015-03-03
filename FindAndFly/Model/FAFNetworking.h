//
//  FAFNetworking.h
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFNetworking : NSObject

/**
 *  Использование сервиса AirportFinder из задания
 *
 *  @param latitude   из CoreLocation
 *  @param longtitude из CoreLocation
 *  @param completion Dictionary ответа с сервера
 */
- (void)getTownsFromNetworkWithLatitude:(NSString *)latitude
                          andLongtitude:(NSString *)longtitude
                          andCompletion:(void (^)(NSDictionary *))completion;

/**
 *  Использование сервиса NewRequest2 из задания
 *
 *  @param date       из ViewController
 *  @param cityFrom   из ViewController
 *  @param cityTo     из ViewController
 *  @param ad         из ViewController
 *  @param cn         из ViewController
 *  @param inn        из ViewController
 *  @param sc         из ViewController
 *  @param completion Dicitonary ответа с сервера
 */
- (void)getTicketsWith:(NSString *)date
           andCityFrom:(NSString *)cityFrom
             andCityTo:(NSString *)cityTo
                 andAd:(NSUInteger)ad
                 andCn:(NSUInteger)cn
                 andIn:(NSUInteger)inn
                 andSc:(NSString *)sc
         andCompletion:(void (^)(NSDictionary *))completion;
/**
 *  Использование сервиса RequestState из задания
 *
 *  @param idSynonim  из сервиса NewRequest2
 *  @param completion ответ с сервера
 */
- (void)getStateOfSearchWith:(NSString *)idSynonim
               andCompletion:(void (^)(NSDictionary *))completion;
@end
