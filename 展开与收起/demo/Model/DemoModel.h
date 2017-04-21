//
//  DemoModel.h
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DemoModel : NSObject

@property (nonatomic,strong) NSString * userIcon; // 头像

@property (nonatomic,strong) NSString * userMsg; // 信息

@property (nonatomic,assign) CGSize msgSize; // 大小

@property (nonatomic,assign) BOOL shouldShowOpenBtn; // 显示展开按钮

@property (nonatomic,assign) BOOL isOpen; // 是否打开

@end
