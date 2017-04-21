//
//  DemoTBVCell.h
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TTRefreshBlock)(id model,NSInteger rowNum,NSInteger sectionNum);

@interface DemoTBVCell : UITableViewCell

@property (nonatomic,strong) id model;

@property (nonatomic,copy) TTRefreshBlock ttRefreshBlock;

// 刷新
- (void)doRefreshModel:(TTRefreshBlock)ttRefreshBlock;

@end
