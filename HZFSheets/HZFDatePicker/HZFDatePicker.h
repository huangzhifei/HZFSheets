//
//  HZFDatePicker.h
//  HZFSheets
//
//  Created by huangzhifei on 2017/6/27.
//  Copyright © 2017年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HZFDatePickerDelegate;

@interface HZFDatePicker : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) id<HZFDatePickerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
              doneButtonTitle:(NSString *)doneButtonTitle;

- (void)show;

- (void)showInView:(UIView *)view;

- (void)hide;

@end

@protocol HZFDatePickerDelegate <NSObject>

@optional

- (void)datePickerCancel:(HZFDatePicker *)datePicker;
- (void)datePicker:(HZFDatePicker *)datePicker clickedButtonIndex:(NSInteger)buttonIndex;

@end
