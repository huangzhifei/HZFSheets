//
//  HZFDatePicker.m
//  HZFSheets
//
//  Created by huangzhifei on 2017/6/27.
//  Copyright © 2017年 huangzhifei. All rights reserved.
//

#import "HZFDatePicker.h"

@interface HZFDatePicker()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cancelButtonTitle;
@property (strong, nonatomic) NSString *doneButtonTitle;
@property (assign, nonatomic) CGFloat contentViewWidth;
@property (assign, nonatomic) CGFloat contentViewHeight;

@end

@implementation HZFDatePicker

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
              doneButtonTitle:(NSString *)doneButtonTitle {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _doneButtonTitle = doneButtonTitle;
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0.2;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tap];
        [self addSubview:_backgroundView];
        
        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    self.contentViewWidth = self.bounds.size.width;
    self.contentViewHeight = 0;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    
    _buttonView = [[UIView alloc] init];
    
    [self initButtons];
    
    [self initDatePicker];
    
    _contentView.frame = CGRectMake(0,
                                    self.frame.size.height,
                                    self.contentViewWidth,
                                    self.contentViewHeight);
    [self addSubview:_contentView];
}

- (void)initButtons {
    if (self.cancelButtonTitle.length) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 60, 30)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000;
        [_buttonView addSubview:button];
    }
    
    if (self.doneButtonTitle.length) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.contentViewWidth - 60, 10, 60, 30)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:self.doneButtonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1001;
        [_buttonView addSubview:button];
    }
    
    if (self.cancelButtonTitle.length || self.doneButtonTitle.length) {
        _buttonView.frame = CGRectMake(0, 0, self.contentViewWidth, 50);
    }
    [_contentView addSubview:_buttonView];
    self.contentViewHeight += 50;
}

- (void)initDatePicker {
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, self.contentViewWidth, 160)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [_contentView addSubview:_datePicker];
    self.contentViewHeight += 180;
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [obj removeFromSuperview];
        }
    }];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    [self addAnimation];
}

- (void)showInView:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [obj removeFromSuperview];
        }
    }];
    [view addSubview:self];
    [view bringSubviewToFront:self];
    [self addAnimation];
}

- (void)hide {
    [self removeAnimation];
}

- (void)addAnimation {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.3 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)buttonPressed:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:clickedButtonIndex:)]) {
        [_delegate datePicker:self clickedButtonIndex:button.tag - 1000];
    }
    [self hide];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerCancel:)]) {
        [_delegate datePickerCancel:self];
    }
    [self hide];
}

@end

