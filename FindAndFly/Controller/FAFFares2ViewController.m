//
//  FAFFares2ViewController.m
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFFares2ViewController.h"
#import "FAFNetworking.h"
#import "FAFAirlineViewCell.h"
#import "FAFAirCompany.h"
#import "FAFFullListOfFaresForCompany.h"

static NSString *const AIRLINE_COMPANY_CELL = @"airCompanyCell";
static NSString *const SEGUE_TO_LIST_OF_FARES_FOR_COMPANY = @"segueToFullListOfFaresForCompany";

@interface FAFFares2ViewController ()

@property (strong, nonatomic) FAFNetworking *networking;
@property (strong, nonatomic) NSArray *companies;
@property (strong, nonatomic) NSArray *faresToPassTonextController;

@end

@implementation FAFFares2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _networking = [[FAFNetworking alloc] init];
    [self getFares];
    
}
- (void)getFares {
    NSMutableArray *arrayOfCompanies = [NSMutableArray array];
    [_networking getFaresWithWithR:_idSynonim
                     andCompletion:^(NSDictionary *faresCompletion) {
        NSArray *airlines = faresCompletion[@"Airlines"];
        for (id airline in airlines) {
            NSString *code = airline[@"Code"];
            NSArray *faresTmp = airline[@"Fares"];
            
            NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"AdultAmountCeiledRub" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
            NSArray *fares = [faresTmp sortedArrayUsingDescriptors:sortDescriptors];
            NSString *minFareString = [fares[0][@"AdultAmountCeiledRub"] stringValue];
            
            FAFAirCompany *airCompany = [[FAFAirCompany alloc] initWithCode:code
                                                                 andMinFare:minFareString
                                                                   andFares:fares];
            [arrayOfCompanies addObject:airCompany];
        }
        _companies = arrayOfCompanies;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [_companies count];
    return count;
}


- (FAFAirlineViewCell *)tableView:(UITableView *)tableView
            cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAFAirlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AIRLINE_COMPANY_CELL
                                                            forIndexPath:indexPath];
    FAFAirCompany *airCompany = _companies[indexPath.row];
    NSString *code = airCompany.code;
    NSString *minFare = airCompany.minFare;
    [cell prepareCellWithTitle:code andDetail:minFare];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FAFAirCompany *airCompany = _companies[indexPath.row];
    _faresToPassTonextController = airCompany.fares;
    [self performSegueWithIdentifier:SEGUE_TO_LIST_OF_FARES_FOR_COMPANY sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SEGUE_TO_LIST_OF_FARES_FOR_COMPANY]) {
        FAFFullListOfFaresForCompany *fullListOfFaresForCompany = segue.destinationViewController;
        fullListOfFaresForCompany.fares = _faresToPassTonextController;
    }
}

@end
