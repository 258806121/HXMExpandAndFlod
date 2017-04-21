//
//  DemoModel.m
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "DemoModel.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation DemoModel

// set方法
- (void)setUserMsg:(NSString *)userMsg
{
    _userMsg = userMsg;
    _msgSize = [userMsg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 65, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    //为什么是 设置当为40的时候 改变高度，主要是头像的高度为40，label小于头像的高度的时候 也为40
    if (_msgSize.height > 40) {
        _shouldShowOpenBtn = YES;
    }else{
        _shouldShowOpenBtn = NO;
    }
    _isOpen = NO;
}

- (CGSize)msgSize
{
    if (_userMsg) {
        
    }else{
        _userMsg = @"";
    }
    _msgSize = [_userMsg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 65, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return _msgSize;
}

@end
