//
//  XDYStringComponent.m
//  XDYCar
//
//  Created by zhangqq on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import "XDYStringComponent.h"

@implementation XDYStringOffset


@end

@interface XDYStringComponent ()

@property (nonatomic, unsafe_unretained)  UIFont *font;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) UIColor *color;
@property (nonatomic, unsafe_unretained)  CGFloat blurRadius;
@property(nonatomic, strong) UIImage *attachImage;
@property(nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, unsafe_unretained)  NSTextAlignment alignment;
@property (nonatomic, unsafe_unretained)  CGFloat  seperateNum;
@property (nonatomic, unsafe_unretained)  CGFloat lineSpace;
@property (nonatomic, unsafe_unretained)  XDYStringOffset  *shadowOffSet;
@end

@implementation XDYStringComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }else{
        @throw [[NSException alloc] initWithName:@"请把该类初始化后使用" reason:@"" userInfo:nil];
    }
    return self;
}

-(NSMutableAttributedString *)attribuString{
    
    if (!_attribuString) {
        NSMutableDictionary *defaultDic = [NSMutableDictionary dictionary];
        defaultDic[NSForegroundColorAttributeName] = self.color;
        defaultDic[NSFontAttributeName] = self.font;
        
        if (self.shadowOffSet && self.shadowColor) {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowColor = self.shadowColor;
            shadow.shadowOffset = CGSizeMake(self.shadowOffSet.x, self.shadowOffSet.y);
            shadow.shadowBlurRadius = self.blurRadius;
            defaultDic[NSShadowAttributeName] = shadow;
        }
        
        NSTextAttachment *attchment = nil;
        if (self.attachImage) {
            attchment = [[NSTextAttachment alloc] init];
            attchment.image = self.attachImage;
            attchment.bounds = CGRectMake(0, 0, 13, 13);
        }
        
        if (self.alignment || self.lineSpace) {
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.alignment = self.alignment;
            style.lineSpacing = self.lineSpace;
            defaultDic[NSParagraphStyleAttributeName] = style;
        }
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        if (defaultDic.allValues.count > 0) {
            attr = [[NSMutableAttributedString alloc] initWithString:self.text attributes:defaultDic];
        }else if(self.text.length > 0){
            attr = [[NSMutableAttributedString alloc] initWithString:self.text];
        }else{
            attr = [[NSMutableAttributedString alloc] init];
        }

        if (attchment != nil) {
            [attr appendAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attchment]];
        }
        
        _attribuString = attr;
    }
    return _attribuString;
}

-(StringComponentChain)COMFont{
    return ^(id font){
        self.font = font;
        return self;
    };
}

-(StringComponentChain)COMText{
    return ^(id text){
        self.text = text;
        return self;
    };
}

-(StringComponentChain)COMColor{
    return ^(id color){
        self.color = color;
        return self;
    };
}

-(StringComponentChain)COMShadowColor{
    return ^(id color){
        self.color = color;
        return self;
    };
}

-(StringComponentChain)COMShadowOffSet{
    return ^(id offset){
        self.shadowOffSet = offset;
        return self;
    };
}

-(StringComponentChain)COMBlurRadius{
    return ^(id blurRadius){
        self.blurRadius = [blurRadius floatValue];
        return self;
    };
}

-(StringComponentChain)COMAttachImage{
    return ^(id image){
        self.attachImage = image;
        return self;
    };
}

-(StringComponentChain)COMSeperateSpace{
    return ^(id seperate){
        self.seperateNum = [seperate floatValue];
        return self;
    };
}

-(StringComponentChain)COMTextAlignment{
    return ^(id alignment){
        self.alignment = [alignment integerValue];
        return self;
    };
}

-(StringComponentChain)COMLineSpace{
    return ^(id lineNum){
        self.lineSpace = [lineNum floatValue];
        return self;
    };
}

-(XDYStringComponent *)appendingStringWithString:(XDYStringComponent *)com{
    XDYStringComponent *newcom = [XDYStringComponent new];
    [self.attribuString appendAttributedString:com.attribuString];
    newcom.attribuString = self.attribuString;
    return newcom;
}

+(XDYStringComponent *)addComponentWithStyleArray:(NSArray <NSDictionary *>*)styleArray{
    //这个方法从外面调用的时候是不是看着有点变态，感觉又乱又没规律，其实从写好富文本的类之后可以写一种方法始终不乱，比如我写一个123，1是黄色，那么我写如下代码
    /*
     XDYStringComponent *com1 = [[XDYStringComponent alloc] init];
     com1.COMFont(font(13)).COMText(@"1").COMColor(COLOR(yellowColor));
     XDYStringComponent *com2 = [[XDYStringComponent alloc] init];
     com1.COMFont(font(13)).COMText(@"23").COMColor(COLOR(blackColor));
     XDYStringComponent *com3 = [[XDYStringComponent alloc] init];
     [com3 appendingStringWithString:[com2 appendingStringWithString:com1]];
     */
    //上面的com3就是我们需要的样式，这样写看着貌似很有规律，也不太乱，弄到一个方法里貌似还很不错，但是当文本内容变多，数量变多，加入图片的时候等等，就会大量的写重复的代码，其实完全没有必要的。所以在这里规定传入一个数组，你要什么样式你自己在外面拼写，给我的数组里就是你拼好段的字典，字典内包含你想要的各段样式，我只负责组合就OK
    
    NSMutableArray *comArray = [NSMutableArray array];
    for (NSInteger i = 0; i < styleArray.count; i++) {
        XDYStringComponent *com = [[XDYStringComponent alloc] init];
        NSDictionary *dic = styleArray[i];
        if (dic[@"font"]) {
            com.COMFont(dic[@"font"]);
        }else{
            com.COMFont([UIFont systemFontOfSize:13]);
        }
        if (dic[@"color"]) {
            com.COMColor(dic[@"color"]);
        }else{
            com.COMColor([UIColor blackColor]);
        }
        if (dic[@"text"]) {
            com.COMText(dic[@"text"]);
        }
        if (dic[@"attach"]) {
            com.COMAttachImage(dic[@"attach"]);
        }
        [comArray addObject:com];
    }
    
    if (comArray.count >=2) {
        XDYStringComponent *newCom = [[XDYStringComponent alloc] init];
        for (NSInteger i = 0;i<comArray.count;i++) {
            newCom = [newCom appendingStringWithString:comArray[i]];
        }
        return newCom;
    }else if (comArray.count == 1){
        return comArray[0];
    }else{
        return nil;
    }
}
@end
