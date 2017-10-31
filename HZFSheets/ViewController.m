//
//  ViewController.m
//  HZFSheets
//
//  Created by eric on 2017/10/30.
//  Copyright © 2017年 huangzhifei. All rights reserved.
//

#import "ViewController.h"
#import "HZFDatePicker.h"
#import "HZFActionSheet.h"
#import "HZFPickerView.h"

@interface ViewController ()<HZFPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickPickerView:(id)sender {
    HZFPickerView *pickerView = [[HZFPickerView alloc] initWithTitle:@"PickerView" delegate:self cancelButtonTitle:@"取消" doneButtonTitle:@"确定"];
    [pickerView show];
}

- (IBAction)onClickActionSheet:(id)sender {
    HZFActionSheet *actionSheet = [[HZFActionSheet alloc] initWithTitle:@"ActionSheet"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                  otherButtonTitlesAray:@[@"item1", @"item2"]];
    [actionSheet show];
}

- (IBAction)onClickDatePicker:(id)sender {
    HZFDatePicker *datePicker = [[HZFDatePicker alloc] initWithTitle:@"DatePicker" delegate:self cancelButtonTitle:@"取消" doneButtonTitle:@"确定"];
    [datePicker show];
}

#pragma mark - HZFPickerDelegate

- (NSInteger)numOfRow {
    return 2;
}

- (NSString *)titleOfRow:(NSInteger)row {
    return @"item";
}

@end
