//
//  FAFadultsPicker.m
//  FindAndFly
//
//  Created by Mega on 04/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFAdultsPicker.h"

@interface FAFAdultsPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *adultsArray;

@end

@implementation FAFAdultsPicker

- (void)drawRect:(CGRect)rect {
    [self setupCurrentPicker];
}
/**
 *  Первичная настройка и расстановка значений
 */
- (void)setupCurrentPicker {
    _adultsArray = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.dataSource = self;
    self.delegate = self;
    _selectedValue = _adultsArray[0];
}

#pragma mark - dataSoruce

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    NSInteger countInArray = [_adultsArray count];
    return countInArray;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSString *rowTitle = _adultsArray[row];
    
    return rowTitle;
}

#pragma mark - delegate

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    NSString *selectedValueFromArray = _adultsArray[row];
    _selectedValue = selectedValueFromArray;
}

@end
