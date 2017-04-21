//
//  HeadView.h
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

// imgView
@property (weak, nonatomic) IBOutlet UIImageView *iv;

// 标题
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

// age
@property (weak, nonatomic) IBOutlet UILabel *lblAge;

// 放置文字的视图
@property (weak, nonatomic) IBOutlet UIView *viewForLbl;

// 放置文字的视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfViewForLblHeight;




@end
