//
//  XDYStringComponent.h
//  XDYCar
//
//  Created by zhangqq on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XDYStringOffset : NSObject

@property (nonatomic, unsafe_unretained)  CGFloat x;
@property (nonatomic, unsafe_unretained) CGFloat y;

@end

@interface XDYStringComponent : NSObject

typedef XDYStringComponent *(^StringComponentChain)(id);

@property(nonatomic, strong) NSMutableAttributedString *attribuString;

-(StringComponentChain)COMFont;
-(StringComponentChain)COMText;
-(StringComponentChain)COMColor;

-(StringComponentChain)COMTextAlignment;
-(StringComponentChain)COMSeperateSpace;// 字间距
-(StringComponentChain)COMLineSpace;// 行间距

//shadow
-(StringComponentChain)COMShadowColor;
-(StringComponentChain)COMShadowOffSet;
-(StringComponentChain)COMBlurRadius;

//icon
-(StringComponentChain)COMAttachImage;

-(XDYStringComponent *)appendingStringWithString:(XDYStringComponent *)com;

+(XDYStringComponent *)addComponentWithStyleArray:(NSArray <NSDictionary *>*)styleArray;
@end
