//
//  ViewController.m
//  StingComponent
//
//  Created by zhangqq on 2018/1/18.
//  Copyright © 2018年 张强. All rights reserved.
//

#import "ViewController.h"
#import "XDYStringComponent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 300)];
    bgView.layer.borderColor = [UIColor blackColor].CGColor;
    bgView.layer.borderWidth = 1;
    [self.view addSubview:bgView];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 100)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.numberOfLines = 0;
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    [bgView addSubview:label1];
    
    //第一种使用方式
    XDYStringComponent *com1 = [[XDYStringComponent alloc] init];
    com1.COMText(@"第一段文字红色,").COMFont([UIFont systemFontOfSize:14]).COMColor([UIColor redColor]).COMLineSpace(@(10)).COMSeperateSpace(@(4));
    
    XDYStringComponent *com2 = [[XDYStringComponent alloc] init];
    com2.COMText(@"第二段文字是黑色,").COMFont([UIFont systemFontOfSize:18]).COMColor([UIColor blackColor]).COMLineSpace(@(10)).COMSeperateSpace(@(4));
    
    XDYStringComponent *com3 = [[XDYStringComponent alloc] init];
    com3.COMText(@"第三段文字是蓝色,").COMFont([UIFont systemFontOfSize:12]).COMColor([UIColor blueColor]).COMLineSpace(@(10)).COMSeperateSpace(@(4));
    
    XDYStringComponent *com4 = [[XDYStringComponent alloc] init];
    com4.COMText(@"第四段文字是黄色加图片").COMFont([UIFont systemFontOfSize:12]).COMAttachImage([UIImage imageNamed:@"t4_chexian_title_baoxian"]).COMLineSpace(@(10)).COMSeperateSpace(@(4));
    
    XDYStringComponent *com = [[XDYStringComponent alloc] init];
    [com appendingStringWithString:[com1 appendingStringWithString:[com2 appendingStringWithString:[com3 appendingStringWithString:com4]]]];
    //3连上4作为一个段落 2连上3和4的结合作为一个段落 1连上2和3的结合作为一个新的段落。最后赋值给label
    label1.attributedText = com.attribuString;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width-40, 100)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.numberOfLines = 0;
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    [bgView addSubview:label2];
    
    XDYStringComponent *newCom = [XDYStringComponent addComponentWithStyleArray:@[
                            @{@"font":[UIFont systemFontOfSize:12],@"text":@"第一段文字红色,",@"color":[UIColor redColor]},
                            @{@"font":[UIFont systemFontOfSize:16],@"text":@"第二段文字是蓝色,",@"color":[UIColor blueColor]},
                            @{@"font":[UIFont systemFontOfSize:18],@"text":@"第二段文字是默认的白色,"},
                            @{@"font":[UIFont systemFontOfSize:14],@"text":@"第四段文字是黄色加图片",@"attach":[UIImage imageNamed:@"t4_share_icon_weixin"],@"color":[UIColor cyanColor]}
                            ]];
    label2.attributedText = newCom.attribuString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
