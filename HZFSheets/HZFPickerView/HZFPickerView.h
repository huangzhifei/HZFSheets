//
//  HZFPickerView.h
//  HZFSheets
//
//  Created by huangzhifei on 2017/10/16.
//  Copyright © 2017年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HZFPickerDelegate;

@interface HZFPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, weak) id<HZFPickerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
              doneButtonTitle:(NSString *)doneButtonTitle;

- (void)show;

- (void)showInView:(UIView *)view;

- (void)hide;

@end

@protocol HZFPickerDelegate <NSObject>

@required

// 默认是单列
// 行数代理
- (NSInteger)numOfRow;
- (NSString *)titleOfRow:(NSInteger)row;

@optional

- (void)pickerCancel:(HZFPickerView *)datePicker;
- (void)picker:(HZFPickerView *)pickerView didSelectedRow:(NSInteger)row clickedButtonIndex:(NSInteger)buttonIndex;

@end
