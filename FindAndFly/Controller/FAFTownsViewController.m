//
//  FUFTownsViewController.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
#import "FAFTownsViewController.h"
#import "FAFCityStorage.h"
#import "FAFTNewRequest2Controller.h"

@interface FAFTownsViewController () <FAFCityStorageDelegate>

@property (strong, nonatomic) FAFCityStorage *cityStorage;

@end

@implementation FAFTownsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    
    _cityStorage = [[FAFCityStorage alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = _cityStorage;
    _cityStorage.cityStorageDelegate = self;
}

#pragma  mark - FAFCityStorageDelegate

- (void)updateTable {
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FAFTNewRequest2Controller *newRequest2Controller = [segue destinationViewController];
    NSIndexPath *selectedCellPath = [self.tableView indexPathForSelectedRow];
    NSUInteger row = selectedCellPath.row;
    newRequest2Controller.cityFrom = [_cityStorage getCityWithIndex:row];
}

- (IBAction)refreshCitiesAction:(id)sender {
    [_cityStorage getCities];
}

@end
