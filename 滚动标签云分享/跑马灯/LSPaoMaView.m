//
//  LSPaoMaView.m
//  LSDevelopmentModel
//
//  Created by  tsou117 on 15/7/29.
//  Copyright (c) 2015年  tsou11. All rights reserved.
//

#import "LSPaoMaView.h"

@implementation LSPaoMaView
{
    
    CGRect rectMark1;//标记第一个位置
    CGRect rectMark2;//标记第二个位置
    
    NSMutableArray* labelArr;
    
    NSTimeInterval timeInterval;//时间
    
    BOOL isStop;//停止
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (LSPaoMaView *)shareLsinitWithFrame:(CGRect)frame title:(NSString *)title BackColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont {
    static LSPaoMaView * ls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ls = [[LSPaoMaView alloc] initWithFrame:frame title:title BackColor:backColor textColor:textColor textFont:textFont];
    });

    return ls;

}



- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title BackColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        title = [NSString stringWithFormat:@"  %@  ",title];//间隔
        
        timeInterval = [self displayDurationForString:title];
        
        self.backgroundColor = backColor;
        self.clipsToBounds = YES;
        
        //
        UILabel* textLb = [[UILabel alloc] initWithFrame:CGRectZero];
        textLb.textColor = [UIColor clearColor];
        
        textLb.font = [UIFont boldSystemFontOfSize:textFont];
        textLb.text = title;
        
        //计算textLb大小
        CGSize sizeOfText = [textLb sizeThatFits:CGSizeZero];
        
        rectMark1 = CGRectMake(0, 0, sizeOfText.width, self.bounds.size.height);
        rectMark2 = CGRectMake(rectMark1.origin.x+rectMark1.size.width, 0, sizeOfText.width, self.bounds.size.height);
        
        textLb.frame = rectMark1;
        [self addSubview:textLb];
        
        labelArr = [NSMutableArray arrayWithObject:textLb];

        
        //判断是否需要reserveTextLb
        BOOL useReserve = sizeOfText.width > frame.size.width ? YES : NO;
        
        if (useReserve) {
            //alloc reserveTextLb ...
            
            UILabel* reserveTextLb = [[UILabel alloc] initWithFrame:rectMark2];
            reserveTextLb.textColor = textColor;
            reserveTextLb.font = [UIFont boldSystemFontOfSize:textFont];
            reserveTextLb.text = title;
            [self addSubview:reserveTextLb];
            
            [labelArr addObject:reserveTextLb];
            
            [self paomaAnimate:textColor];
        }
  
    }
    return self;
}



- (void)paomaAnimate:(UIColor *)color{
    
    if (!isStop) {
        //
        UILabel* lbindex0 = labelArr[0];
        UILabel* lbindex1 = labelArr[1];
        
        [UIView transitionWithView:self duration:timeInterval options:UIViewAnimationOptionCurveLinear animations:^{
            //
            
            lbindex0.frame = CGRectMake(-rectMark1.size.width, 0, rectMark1.size.width, rectMark1.size.height);
            lbindex0.textColor = color;
            lbindex1.frame = CGRectMake(lbindex0.frame.origin.x+lbindex0.frame.size.width, 0, lbindex1.frame.size.width, lbindex1.frame.size.height);
            
        } completion:^(BOOL finished) {
            //
            
            lbindex0.frame = rectMark2;
            lbindex1.frame = rectMark1;
            
            [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
            [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
            
            [self paomaAnimate:color];
        }];
    }
}


- (void)start:(UIColor *)color{
    isStop = NO;
    UILabel* lbindex0 = labelArr[0];
    UILabel* lbindex1 = labelArr[1];
    
    lbindex0.frame = rectMark2;
    lbindex1.frame = rectMark1;
    
    [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
    [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
    
    [self paomaAnimate:color];
    
}
- (void)stop{
    isStop = YES;
}

- (NSTimeInterval)displayDurationForString:(NSString*)string {
    
    return string.length/4;
//    return MIN((float)string.length*0.06 + 0.5, 5.0);
}

@end
