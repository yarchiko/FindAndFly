//
//  FAFClassPicker.m
//  FindAndFly
//
//  Created by Mega on 04/03/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import "FAFClassPicker.h"

@interface FAFClassPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *classesArray;
@property (strong, nonatomic) NSArray *classesCodesArray;

@end

@implementation FAFClassPicker

- (void)drawRect:(CGRect)rect {
    [self setupCurrentPicker];
}

/**
 *  Первичная настройка и расстановка значений
 */
- (void)setupCurrentPicker {
    _classesArray = [[NSArray alloc] initWithObjects:@"Эконом", @"Стандарт", @"Все", nil];
    _classesCodesArray = [[NSArray alloc] initWithObjects:@"E", @"B", @"A", nil];
    self.dataSource = self;
    self.delegate = self;
    _selectedValue = _classesCodesArray[0];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    NSInteger countInArray = [_classesArray count];
    return countInArray;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSString *rowTitle = _classesArray[row];
    
    return rowTitle;
}

#pragma mark - delegate

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (row==2) {
        [self selectRow:1 inComponent:0 animated:YES];
    }
    else {
        NSString *selectedValueFromArray = _classesCodesArray[row];
        _selectedValue = selectedValueFromArray;
    }
    
}

@end
