//
//  CLAlterView.m
//  CLAlertView
//
//  Created by zqwl001 on 15/11/15.
//  Copyright © 2015年 zqwl. All rights reserved.
//

#import "CLAlterView.h"
#define leftBtnImage             [UIImage imageNamed:@"button_white_normal.png"]
#define rightBtnImage            [UIImage imageNamed:@"button_orange_normal.png"]
#define titleColor               [UIColor blackColor]
#define messageColor             [UIColor blackColor]
#define titleFont                [UIFont systemFontOfSize:15]
#define messageFont              [UIFont systemFontOfSize:15]
#define rightBtnTitleColor       [UIColor blackColor]
#define leftBtnTitleColor        [UIColor redColor]
#define lineLabelColor           [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]
@interface CLAlterView()

@property (nonatomic, assign) NSInteger clickedButtonIndex;
@property (nonatomic, strong) UIButton *otherButton;
@end

@implementation CLAlterView

- (void)dealloc {
    _delegate = nil;
    
}
//
//- (void)initData {
//    
//    _sholdDismissAfterConfirm = YES;
//    _dimBackgroundView = YES;
//    
//    self.backgroundColor = [UIColor clearColor];
//    _contextAlignment = NSTextAlignmentCenter;
//    
//
////    [self addObserver:self
////           forKeyPath:@"dimBackground"
////              options:NSKeyValueObservingOptionNew
////              context:NULL];
////    
////    [self addObserver:self
////           forKeyPath:@"contentAlignment"
////              options:NSKeyValueObservingOptionNew
////              context:NULL];
////}
//////
//////// 监听属性的变化
////- (void)observeValueForKeyPath:(NSString *)keyPath
////                      ofObject:(id)object
////                        change:(NSDictionary<NSString *,id> *)change
////                       context:(void *)context
////{
////    if ([keyPath isEqualToString:@"dimBackground"]) {
////        [self setNeedsDisplay];
////    } else if ([keyPath isEqualToString:@"contentAlignment"] ){
////        self.bodyTextLabel.textAlignment = self.contextAlignment;
////        self.bodyTextView.textAlignment  = self.contextAlignment;
////    }
////    
//}

- (UIView *)initWithTitle:(NSString *)title
                  message:(NSString *)message
                 delegate:(id)delegate
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSString *)otherButtonTitle {
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:(0) green:0 blue:0 alpha:0.2];
       
        // 默认的样式
        
        if (![title length]) {
            title = @"提示";
        }
        
//        NSLog(@"%@", NSStringFromCGRect(self.bounds));
        
        
        CGFloat bgViewHeight = 200;
        CGFloat bgViewWidth  = self.frame.size.width - 40;
        CGFloat centerY      = self.frame.size.height * 0.35;
        CGFloat centerX      = self.frame.size.width / 2;
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgViewWidth, bgViewHeight)];
    
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundView.layer.cornerRadius = 10;
        self.backgroundView.layer.masksToBounds = YES;
        [self addSubview:self.backgroundView];
        self.backgroundView.center = CGPointMake(centerX, centerY);
        
        
        
        CGFloat titleWidth = bgViewWidth;
        CGFloat titleHight = 50;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleHight)];
        self.titleLabel.font = titleFont;
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = titleColor;
        [self.backgroundView addSubview:self.titleLabel];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleHight + 1, titleWidth, 0.5)];
        self.lineLabel.backgroundColor = lineLabelColor;
        [self.backgroundView addSubview:self.lineLabel];

        
        
        CGFloat backHight = 50;
        CGFloat backWidth = 50;
        CGFloat backX     = self.titleLabel.frame.size.width - 50;
        CGFloat backY     = 0;
        
        
        
        
        CGFloat messageWidht = self.titleLabel.frame.size.width;
        CGFloat messageX     =  0;
        CGFloat messageY     = self.lineLabel.frame.size.height + self.lineLabel.frame.origin.y;
        NSDictionary *dic =  @{NSFontAttributeName:messageFont};
        
        
        // message label 的大小
        CGRect messageRect = [message boundingRectWithSize:CGSizeMake(messageWidht, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:NULL];
        CGFloat messageHight = messageRect.size.height + 50;
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(messageX , messageY, messageWidht, messageHight)];
        self.messageLabel.font = messageFont;
        self.messageLabel.text = message;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.textColor = messageColor;
        self.messageLabel.numberOfLines=0;
        [self.backgroundView addSubview:self.messageLabel];
        
        
        
        // backButton
        self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cancelicon"]];
        self.backImageView.frame = CGRectMake(self.titleLabel.frame.size.width - 40, 10, 30, 30);
        [self.backgroundView addSubview:self.backImageView];
        
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(dissmissSelf) forControlEvents:UIControlEventTouchUpInside];
        self.backButton.frame = CGRectMake(backX, backY, backWidth, backHight);
        [self.backgroundView addSubview:self.backButton];
        
        
        // 无按钮, 只是提示...
        if (cancelButtonTitle == nil) {
            
        }
        
        
        if (otherButtonTitle && cancelButtonTitle) {
            
            CGFloat otherX       =  -5;
            CGFloat otherY       =  self.backgroundView.frame.size.height - 50;
            CGFloat otherWidth   =  self.backgroundView.frame.size.width / 2 + 4.5;
            CGFloat otherHight   =  55;
            
            CGFloat cancelX      = otherWidth - 4.5 + 0.5;
            CGFloat cancelY      = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth  = self.backgroundView.frame.size.width / 2 + 5;
            CGFloat cancelHight  = 55;
            
            self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.otherButton.frame = CGRectMake(otherX, otherY, otherWidth, otherHight);
            self.otherButton.layer.borderWidth = 0.5;
            self.otherButton.layer.borderColor = lineLabelColor.CGColor;
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            self.otherButton.titleLabel.font = titleFont;
            self.otherButton.tag = 1;
            [self.otherButton setTitleColor:leftBtnTitleColor forState:UIControlStateNormal];
            [self.otherButton setBackgroundColor:[UIColor whiteColor]];
            [self.otherButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.backgroundView addSubview:self.otherButton];
            
            
            self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelButton.tag = 0;
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
            self.cancelButton.layer.borderWidth = 0.5;
            self.cancelButton.layer.borderColor = lineLabelColor.CGColor;
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            self.cancelButton.titleLabel.font = titleFont;
            [self.cancelButton setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];
            [self.cancelButton setBackgroundColor:[UIColor whiteColor]];
            [self.backgroundView addSubview:self.cancelButton];
            [self.cancelButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

        
        } else if (cancelButtonTitle) {
            
            
            CGFloat cancelX     = -5;
            CGFloat cancelY     = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth = self.backgroundView.frame.size.width + 10;
            CGFloat cancelHight = 55;
            
            self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelButton.layer.borderWidth = 0.5;
            self.cancelButton.tag = 0;
            self.cancelButton.layer.borderColor = lineLabelColor.CGColor;
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            self.cancelButton.titleLabel.font = titleFont;
            [self.cancelButton setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];

            [self.cancelButton setBackgroundColor:[UIColor whiteColor]];
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
            [self.backgroundView addSubview:self.cancelButton];
            [self.cancelButton addTarget:self action:@selector(CancelbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
        } else if (otherButtonTitle) {
            
            CGFloat cancelX     = -5;
            CGFloat cancelY     = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth = self.backgroundView.frame.size.width + 10;
            CGFloat cancelHight = 55;
            
            self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelButton.layer.borderWidth = 0.5;
            self.cancelButton.tag = 0;
            self.cancelButton.layer.borderColor = lineLabelColor.CGColor;
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            self.cancelButton.titleLabel.font = titleFont;
            [self.cancelButton setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];
            [self.cancelButton setBackgroundColor:[UIColor whiteColor]];
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
            [self.backgroundView addSubview:self.cancelButton];
            [self.cancelButton addTarget:self action:@selector(CancelbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        
        
        self.backgroundView.bounds = CGRectMake(self.backgroundView.bounds.origin.x, self.backgroundView.bounds.origin.y, self.backgroundView.bounds.size.width, self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height + 50);
        
        if (otherButtonTitle && cancelButtonTitle) {
            
            CGFloat otherX       =  -5;
            CGFloat otherY       =  self.backgroundView.frame.size.height - 50;
            CGFloat otherWidth   =  self.backgroundView.frame.size.width / 2 + 4.75;
            CGFloat otherHight   =  55;
            
            CGFloat cancelX      = otherWidth - 5 - 0.25;
            CGFloat cancelY      = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth  = self.backgroundView.frame.size.width / 2 + 5;
            CGFloat cancelHight  = 55;
            self.otherButton.frame = CGRectMake(otherX, otherY, otherWidth, otherHight);
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
            
        } else if (cancelButtonTitle) {
            
            
            CGFloat cancelX     = 0;
            CGFloat cancelY     = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth = self.backgroundView.frame.size.width;
            CGFloat cancelHight = 50;
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
        } else if (otherButtonTitle) {
            CGFloat cancelX     = 0;
            CGFloat cancelY     = self.backgroundView.frame.size.height - 50;
            CGFloat cancelWidth = self.backgroundView.frame.size.width;
            CGFloat cancelHight = 50;
            self.cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHight);
        }
        
        
        /*
         // 标题
         @property (nonatomic, strong) UILabel *titleLabel;
         // 右边x号, 取消视图
         @property (nonatomic, strong) UIButton *backButton;
         //  中间显示的内容
         @property (nonatomic, strong) UILabel *bodyTextLabel;
         // 中间自定义的视图
         @property (nonatomic, strong) UIView *customView;
         // 内容的body
         @property (nonatomic, strong) UIView *contentView;
         // 背景图
         @property (nonatomic, strong) UIView *backgroundView;
         */
        
    }
    
    return self;
}



- (void)buttonTap:(UIButton *)button {
    
    NSInteger tag = button.tag;
    
//    if ([_delegate conformsToProtocol:@protocol(CLAlterViewDelegate)]) {
    if ([_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:self clickedButtonAtIndex:tag];
//    }
    }
    [self dismiss];
}


- (void)CancelbuttonAction:(UIButton *)button {
//    if ([_delegate conformsToProtocol:@protocol(CLAlterViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
            [_delegate alertViewCancel:self];
    }
    [self dismiss];
}


// 隐藏title 和 linelabel
- (void)hiddenTitleAndline{
    
    self.titleLabel.hidden = YES;
    self.lineLabel.hidden  = YES;
    self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y - self.titleLabel.frame.size.height / 2, self.messageLabel.frame.size.width, self.messageLabel.frame.size.height + self.titleLabel.frame.size.height / 2);
    
}


- (void)dissmissSelf{
    [self dismiss];
}

- (void)show {
    
    // 判断是否正在显示
    if (_visible) {
        return;
    }
    _visible = YES;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    self.center = CGPointMake(keyWindow.bounds.size.width/2.0f,
                              keyWindow.bounds.size.height/2.0f);
    [self fadeIn];
}


- (void)dismiss {
  
    if (_visible == YES) {
        [self fadeOut];
        _visible = NO;
    }
}


- (void)fadeIn
{
//    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
//        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.15 animations:^{
//        self.transform = CGAffineTransformMakeScale(0.0, 0.0);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}



@end
