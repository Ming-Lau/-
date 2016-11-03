//
//  ViewController.m
//  滚动标签云分享
//
//  Created by 刘明 on 16/3/15.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "ViewController.h"
#import "LSPaoMaView.h"
#import "DBSphereView.h"

@interface ViewController ()
@property (nonatomic, strong) DBSphereView *sphereView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor redColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    LSPaoMaView *paoMaView = [LSPaoMaView shareLsinitWithFrame:CGRectMake(0, 0, 200, 40) title:@"dsadassadasdhkjasdhkjashdjkashdkjashd" BackColor:[UIColor clearColor] textColor:color textFont:15];
    self.navigationItem.titleView = paoMaView;
    
    self.sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 20; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        button.frame = CGRectMake(0, 0, 100, 50);
        [button setTitle:[NSString stringWithFormat:@"P%ld", i] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [array addObject:button];
        [_sphereView  addSubview:button];
        
    }
    
    [_sphereView setCloudTags:array];
    [self.view addSubview:_sphereView];

}


-(void)buttonAction:(UIButton *)button{
    [_sphereView timerStop];
    [UIView animateWithDuration:0.3 animations:^{
        button.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformMakeScale(2, 2);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
