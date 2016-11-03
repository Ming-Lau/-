//
//  LSPaoMaView.h
//  LSDevelopmentModel
//
//  Created by  tsou117 on 15/7/29.
//  Copyright (c) 2015年  tsou11. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXTCOLOR RGBA(0,211,190,1)
#define TEXTFONTSIZE 20

@interface LSPaoMaView : UIView

+ (LSPaoMaView *)shareLsinitWithFrame:(CGRect)frame title:(NSString*)title BackColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title BackColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont;


- (void)start:(UIColor *)color;//开始跑马
- (void)stop;//停止跑马

@end
