//
//  CLAlterView.h
//  CLAlertView
//
//  Created by zqwl001 on 15/11/15.
//  Copyright © 2015年 zqwl. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CLAlterView;

@protocol CLAlterViewDelegate <NSObject>

@optional

// 当有两个按钮的时候,执行这个代理
- (void)alertView:(CLAlterView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// 当只有这一个按钮的执行这个代理;
- (void)alertViewCancel:(CLAlterView *)alertView;

@end


@interface CLAlterView : UIView
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 右边x号, 取消视图
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *backButton;
// 隔离线
@property (nonatomic, strong) UILabel *lineLabel;

//  中间显示的内容
@property (nonatomic, strong) UILabel *messageLabel;
// 中间自定义的视图
@property (nonatomic, strong) UIView *customView;
// 内容的body
@property (nonatomic, strong) UIView *contentView;
// 背景图
@property (nonatomic, strong) UIView *backgroundView;

// 是否正在显示
@property (nonatomic, assign) BOOL visible;

// 背景是否有渐变背景, 默认是YES
@property (nonatomic, assign) BOOL dimBackgroundView;

// 背景视图是否覆盖全屏幕
@property (nonatomic, assign) UIInterfaceOrientation *orientation;

// 在点击确定之后是否需要dismiss  默认是yes
@property (nonatomic, assign) BOOL sholdDismissAfterConfirm;

// 文本的对齐方式
@property (nonatomic, assign) NSTextAlignment contextAlignment;

@property (nonatomic, weak) id <CLAlterViewDelegate> delegate;

@property (nonatomic, strong) UIButton *cancelButton;


/**
 *  初始化方法, 默认的style:
 *  title :   标题
 *  message   内容
 *  delegate  代理
 *  cancleButtonTitle  取消按钮title
 *  otherButtonTitle   其他按钮 如确定 只能有一个按钮
 *
 *  @return 拼装好的URL
 */
- (UIView *)initWithTitle:(NSString *)title
                  message:(NSString *)message
                 delegate:(id)delegate
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSString *)otherButtonTitle;
- (void)hiddenTitleAndline;
- (void)show;

//- (id)initWithContentView:(UIView *)contentView;
//- (void)alterCustomDlg:(NSString *)message;
//- (void)dismissAllCustomAlerts;

@end



