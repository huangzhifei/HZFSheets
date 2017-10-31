//
//  HZFActionSheet.h
//  HZFSheets
//
//  Created by huangzhifei on 2017/5/26.
//  Copyright (c) 2017年 huangzhifei. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol HZFActionSheetDelegate;

@interface HZFActionSheet : UIView

@property (weak, nonatomic) id<HZFActionSheetDelegate> delegate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cancelButtonTitle;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitlesAray:(NSArray *)buttonTittleArray;

- (void)show;

- (void)showInView:(UIView *)view;

- (void)hide;

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(int)index;

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size;

@end

@protocol HZFActionSheetDelegate <NSObject>

@optional

- (void)actionSheetCancel:(HZFActionSheet *)actionSheet;
- (void)actionSheet:(HZFActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex;

@end
