//
//  FAFFullListOfFaresForCompany.m
//  FindAndFly
//
//  Created by Mega on 05/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFFullListOfFaresForCompany.h"
#import "FAFFareViewCell.h"

static NSString *const FARE_CELL = @"fareCell";

@interface FAFFullListOfFaresForCompany ()

@end

@implementation FAFFullListOfFaresForCompany

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_companyCode) {
        self.title = _companyCode;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fares count];
}


- (FAFFareViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAFFareViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FARE_CELL
                                                            forIndexPath:indexPath];
    NSString *fareString = [_fares[indexPath.row][@"AdultAmountCeiledRub"] stringValue];
    [cell prepareCellWithTitle:fareString];
    
    return cell;
}

@end
