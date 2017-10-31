//
//  HZFActionSheet.m
//  HZFSheets
//
//  Created by huangzhifei on 2017/5/26.
//  Copyright (c) 2017年 huangzhifei. All rights reserved.
//

#import "HZFActionSheet.h"

#define MARGIN_LEFT 20
#define MARGIN_RIGHT 20
#define SPACE_SMALL 10      // 按钮和取消按钮之间的灰色空白大小
#define TITLE_FONT_SIZE 15  // 展示的标题大小
#define BUTTON_FONT_SIZE 16 // 显示的按钮标题大小

#define KButtonTittleColor [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0] // 显示文字颜色
#define KbuttonHeight 50                                                                                      // button 高度
#define KInLineColor [UIColor colorWithRed:237.0 / 255.0 green:237.0 / 255.0 blue:237.0 / 255.0 alpha:1.0]    // 内分隔线颜色
#define KOutLineColor [UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:232.0 / 255.0 alpha:1.0]   //外分隔线颜色

@interface HZFActionSheet ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation HZFActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];

        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [_buttonTitleArray addObject:otherButtonTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);

        self.backgroundColor = [UIColor clearColor];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverViewGesture:)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0.2;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];
        [self initContentView];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitlesAray:(NSArray *)buttonTittleArray {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [buttonTittleArray copy];
        self.backgroundColor = [UIColor clearColor];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverViewGesture:)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0.2;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];

        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    contentViewWidth = self.bounds.size.width;
    contentViewHeight = 0;

    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];

    _buttonView = [[UIView alloc] init];
    _buttonView.backgroundColor = [UIColor whiteColor];

    [self initTitle];
    [self initButtons];
    [self initCancelButton];

    _contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth) / 2, self.frame.size.height, contentViewWidth, contentViewHeight);
    [self addSubview:_contentView];
}

- (void)initTitle {
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, 50)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonView addSubview:_titleLabel];
        contentViewHeight += _titleLabel.frame.size.height;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, contentViewWidth, 0.5)];
        lineView.backgroundColor = KInLineColor;
        [_buttonView addSubview:lineView];
    }
}

- (void)initButtons {
    if (_buttonTitleArray.count > 0) {
        NSInteger count = _buttonTitleArray.count;
        for (int i = 0; i < count; i++) {

            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, 50)];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:KButtonTittleColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_buttonView addSubview:button];

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, contentViewWidth, 0.5)];
            [button addSubview:lineView];
            if (i == (count - 1)) {
                lineView.backgroundColor = KOutLineColor;
            } else {
                lineView.backgroundColor = KInLineColor;
            }
            contentViewHeight += button.frame.size.height;
        }
        _buttonView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
        [_contentView addSubview:_buttonView];
    }
}

- (void)initCancelButton {
    if (_cancelButtonTitle != nil) {

        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + SPACE_SMALL, contentViewWidth, 50)];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
        [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:KButtonTittleColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, 0.5)];
        lineView.backgroundColor = KOutLineColor;
        [_cancelButton addSubview:lineView];
        contentViewHeight += SPACE_SMALL + _cancelButton.frame.size.height;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = cancelButtonTitle;
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [obj removeFromSuperview];
        }
    }];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    [self addAnimation];
}

- (void)showInView:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
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

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }

    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(int)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }

    if (bgcolor != nil) {
        [button setBackgroundColor:bgcolor];
    }

    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size {
    if (color != nil) {
        [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    }

    if (bgcolor != nil) {
        [_cancelButton setBackgroundColor:bgcolor];
    }

    if (size > 0) {
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)addAnimation {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.3
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
            _backgroundView.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (void)buttonPressed:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonIndex:)]) {
        for (int i = 0; i < _buttonArray.count; i++) {
            if (button == _buttonArray[i]) {
                [_delegate actionSheet:self clickedButtonIndex:i];
                break;
            }
        }
    }
    [self hide];
}

- (void)cancelButtonPressed:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [_delegate actionSheetCancel:self];
    }
    [self hide];
}

- (void)tapCoverViewGesture:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [_delegate actionSheetCancel:self];
    }
    [self hide];
}

@end
