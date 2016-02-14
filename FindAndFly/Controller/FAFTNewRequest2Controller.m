//
//  FAFTNewRequest2Controller.m
//  FindAndFly
//
//  Created by Andy on 04/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFTNewRequest2Controller.h"
#import "FAFNetworking.h"
#import "FAFAdultsPicker.h"
#import "FAFClassPicker.h"
#import "FAFFares2ViewController.h"

static NSString *const SEGUE_TO_FARES2 = @"segueToFares2";

@interface FAFTNewRequest2Controller ()

@property (strong, nonatomic) FAFNetworking *networking;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSString *idSynonim;
@property (strong, nonatomic) NSTimer *timerForTicketsFinding;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateOfDeparturePicker;
@property (weak, nonatomic) IBOutlet FAFAdultsPicker *adultsPicker;
@property (weak, nonatomic) IBOutlet FAFClassPicker *classPicker;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyButton;

@end

@implementation FAFTNewRequest2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
    _networking = [[FAFNetworking alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    /**
     *  Если мы уходим с этого ViewController то нужно отключить таймер
     */
    [_timerForTicketsFinding invalidate];
}

- (void)setupDatePicker {
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1];
    NSDate *maxDate = [_calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [_dateOfDeparturePicker setMinimumDate:currentDate];
    [_dateOfDeparturePicker setMaximumDate:maxDate];
}
- (IBAction)datePickerValueChanged:(id)sender {
    // NSDate *date = _dateOfDeparturePicker.date;
}
- (IBAction)doneBtnAction:(id)sender {
    [self findTicketsWithParams];
}

- (void)findTicketsWithParams {
    NSDate *date = _dateOfDeparturePicker.date;
    unsigned unitFlags = NSDayCalendarUnit  | NSMonthCalendarUnit;
    NSDateComponents *components = [_calendar components: unitFlags fromDate: date];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    
    NSString *dateForApi = [[NSString alloc] initWithFormat:@"%02ld%02ld", (long)day, (long)month];
    
    NSString *adults = _adultsPicker.selectedValue;
    NSString *class = _classPicker.selectedValue;
    
    [self turnOffControls];
    
    [_networking getTicketsWith:dateForApi andCityFrom:_cityFrom andCityTo:@"LON" andAd:adults andCn:@"0" andIn:@"0" andSc:class andCompletion:^(NSDictionary *ticketsComplition) {
        if (ticketsComplition[@"Error"] == [NSNull null]) {
            _idSynonim = ticketsComplition[@"IdSynonym"];
            // NSString *id = ticketsComplition[@"Id"];
            
            /**
             *  В реальном проекте поставил бы сюда 3 секунды, чтобы так часто не запрашивать
             *  Здесь проставлено 1 скорее ради более наглядного изменение ProgressView
             */
            _timerForTicketsFinding =  [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self selector:@selector(checkAirlinesBySynonim:) userInfo:nil repeats:YES];
        }
    }];
    
}

- (void)checkAirlinesBySynonim:(NSTimer *)timer {
    [_networking getStateOfSearchWith:_idSynonim andCompletion:^(NSDictionary *stateCompletion) {
        if (stateCompletion[@"Error"] == [NSNull null]) {
            CGFloat progress = [stateCompletion[@"Completed"] floatValue];
            progress = progress / 100;
            _progressView.progress = progress;
            
            BOOL istaskCompleted = (progress == 1.0);
            if (istaskCompleted) {
                [_timerForTicketsFinding invalidate];
                [self turnOnControls];
                [self performSegueWithIdentifier:SEGUE_TO_FARES2 sender:self];
            }
        }
    }];
}

- (void)turnOffControls {
    _progressView.hidden = NO;
    _readyButton.enabled = NO;
    _dateOfDeparturePicker.enabled = NO;
    _adultsPicker.userInteractionEnabled = NO;
    _classPicker.userInteractionEnabled = NO;
}

- (void)turnOnControls {
    _progressView.progress = 0;
    _progressView.hidden = YES;
    _readyButton.enabled = YES;
    _dateOfDeparturePicker.enabled = YES;
    _adultsPicker.userInteractionEnabled = YES;
    _classPicker.userInteractionEnabled = YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SEGUE_TO_FARES2]) {
        /**
         *  И тут отключаем таймер (на всякий случай)
         */
        [_timerForTicketsFinding invalidate];
        FAFFares2ViewController *fares2ViewController = segue.destinationViewController;
        fares2ViewController.idSynonim = _idSynonim;
    }
}

@end
