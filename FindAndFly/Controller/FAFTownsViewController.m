//
//  FUFTownsViewController.m
//  FindAndFly
//
//  Created by Mega on 03/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
#import "FAFTownsViewController.h"
#import "FAFCityStorage.h"

@interface FAFTownsViewController () <FAFCityStorageDelegate>

@property (strong, nonatomic) FAFCityStorage *cityStorage;

@end

@implementation FAFTownsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    
    _cityStorage = [[FAFCityStorage alloc] init];
    self.tableView.delegate = _cityStorage;
    self.tableView.dataSource = _cityStorage;
    _cityStorage.cityStorageDelegate = self;
}

#pragma  mark - FAFCityStorageDelegate

- (void)updateTable {
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
