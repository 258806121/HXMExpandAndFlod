//
//  DemoTBVCell.m
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "DemoTBVCell.h"
#import "DemoModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DemoTBVCell ()

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;

// lbl
@property (strong, nonatomic)  UILabel *msgboard;

// 展开
@property (weak, nonatomic) IBOutlet UIButton *showMoreBtn;

// 名字
@property (weak, nonatomic) IBOutlet UILabel *lblName;

// 时间
@property (weak, nonatomic) IBOutlet UILabel *lbltime;

@end

@implementation DemoTBVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _showMoreBtn.hidden = YES;
    _msgboard = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _msgboard.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_msgboard];
    _msgboard.numberOfLines = 0;
    _msgboard.lineBreakMode = NSLineBreakByTruncatingTail;
    
    // 头像样式
    _headIcon.layer.cornerRadius = 20;
    _headIcon.layer.masksToBounds = YES;
}

// set方法
- (void)setModel:(id)model
{
    DemoModel * ttmodel  = (DemoModel *)model;
    _model = ttmodel;
    // 头像
    _headIcon.image = [UIImage imageNamed:ttmodel.userIcon];
    // 文字
    _msgboard.text = ttmodel.userMsg;
    // 展开按钮
    _showMoreBtn.hidden = !ttmodel.shouldShowOpenBtn;
    if (!ttmodel.isOpen) {
        _msgboard.frame = CGRectMake(60, 30,SCREEN_WIDTH - 65,40);
        [_showMoreBtn setTitle:@"展开" forState:0];
    }else{
        _msgboard.frame = CGRectMake(60, 30,SCREEN_WIDTH - 65,ttmodel.msgSize.height);
        [_showMoreBtn setTitle:@"收起" forState:0];
    }
}

// 显示更多方法
- (IBAction)showMore:(id)sender
{
    DemoModel * ttmodel  = _model;
    if (ttmodel.isOpen) {
        _ttRefreshBlock(_model,1,1);
    }else{
        _ttRefreshBlock(_model,0,1);
    }
}

// 刷新
- (void)doRefreshModel:(TTRefreshBlock)ttRefreshBlock
{
    _ttRefreshBlock = ttRefreshBlock;
}

@end
