//
//  DemoVC.m
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "DemoVC.h"

// 头视图
#import "HeadView.h"
#import "UIView+Position.h"
#import "SDCycleScrollView.h"
#import "ExpandLabel.h"
#import "DemoTBVCell.h"
#import "DemoModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DemoVC ()<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

// 头视图
@property (strong, nonatomic) HeadView *headView;
// 轮播图
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
// 展开lbl
@property (strong, nonatomic) ExpandLabel *expandLab;

// 库存数
@property (weak, nonatomic) IBOutlet UILabel *lblKuCun;

// -
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;

// 数量
@property (weak, nonatomic) IBOutlet UILabel *lblNum;

// +
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

//全局变量 --- 现有库存数量
@property (assign,nonatomic) NSInteger intKuCun;

// 数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation DemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    // 库存
    self.intKuCun = 10;
    // 数组初始化
    _dataArray = [NSMutableArray array];
    // 初始化
    [self setupTable];
    // 模拟数据
    [self getDataFromNet];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
    [self.cycleScrollView adjustWhenControllerViewWillAppera];
}

//模拟数据
-(void)getDataFromNet
{
    NSArray * text = @[@"《红楼梦》开篇以神话形式介绍作品的由来，说女娲炼三万六千五百零一块石补天，只用了三万六千五百块，剩余一块未用，弃在青埂峰下。剩一石自怨自愧，日夜悲哀。一僧一道见它形体可爱，便给它镌上数字，携带下凡。不知过了几世几劫，空空道人路过，见石上刻录了一段故事，便受石之托，抄写下来传世。辗转传到曹雪芹手中，经他批阅十载、增删五次而成书。",@"阅金陵十二钗正册、副册、又副册判词",@"书中故事发生在京城贾府，为宁国公、荣国公之家宅。据冷子兴演说，宁国公长孙名贾敷，八九岁上死了；次贾敬袭官，而一味好道，把世袭的官爵让给了儿子贾珍，自己出家修道；贾珍无法无天，寻欢作乐，生贾蓉，儿媳秦可卿。荣国公长孙名贾赦，生贾琏，儿媳王熙凤；次贾政；女贾敏，嫁林如海，中年而亡，仅遗一女林黛玉。贾政娶王夫人，生长子贾珠，娶了妻（李纨），生了子（贾兰），一病就死了；生女元春，入宫为妃；次又得子，衔玉而诞，玉上有字，因名贾宝玉。人人都以为贾宝玉来历不小，贾母尤其溺爱",@"贾宝玉长到七八岁，聪明绝人，然生性钟爱女子，常说“女儿是水作的骨肉，男人是泥作的骨肉”。人人皆以为他将来不过是个色鬼，贾政也不大喜欢他，对他管教甚严，因为都不知他是正邪两赋而来",@"阅金陵十二钗正册、副册、又副册判词",@"金陵十二钗36位女儿，除了贾府本家的几位姑娘、奶奶和丫鬟外，还有亲戚家的女孩，如黛玉、宝钗，都寄居于贾府，史湘云也是常客，妙玉则在大观园栊翠庵修行",@"故事起始于贾敏病逝，贾母怜惜黛玉无依傍，又多病，于是接到贾府抚养。黛玉小贾宝玉一岁。后又有王夫人外甥女薛宝钗也到贾府，大贾宝玉二岁，长得端方美丽。贾宝玉在孩提之间，性格纯朴，深爱二人无偏心，黛玉便有些醋意，宝钗却浑然不觉。贾宝玉与黛玉同在贾母房中坐卧，所以比别的姊妹略熟惯些",@"一天，贾宝玉在秦可卿卧房午睡，梦入太虚幻境，遇警幻仙子，阅金陵十二钗正册、副册、又副册判词，有图有诗，只是不解其意。警幻命仙女演奏新制《红楼梦》套曲十四支，其收尾一支名《飞鸟各投林》，词云“落了片白茫茫大地真干净”。然而贾宝玉仍不解，警幻更将妹妹可卿许配与他，二人难分难解，入迷津而惊醒。",@"阅金陵十二钗正册、副册、又副册判词",@"元春被选为贵妃，荣国府愈加贵盛，为之建造大观园，迎接省亲，家人团圆，极天伦之乐。贾宝玉长到十二三岁，在外结交秦钟、蒋玉函，在内则周旋于姊妹中表以及丫鬟如袭人、晴雯、平儿、紫鹃等之间，亲昵且敬爱她们，极尽小心谨慎，深恐违逆她们的心意，所爱的女儿多，自己身心劳倦，而忧患也与日俱增。一次听紫鹃说黛玉要回原籍（苏州）去，贾宝玉便唬傻了，闹得满宅惊慌，直到紫鹃说明缘由才好了",@"阅金陵十二钗正册、副册、又副册判词"];
    for (int i = 0 ; i < 10; i ++) {
        DemoModel * model = [DemoModel new];
        NSInteger randNum = arc4random()%4 + 1;
        model.userIcon = [NSString stringWithFormat:@"%ld",(long)randNum];
        model.userMsg = text[i];
        [_dataArray addObject:model];
    }
}

#pragma mark - Data And UI

- (void)setupTable
{
    // 加载头视图
    _headView = [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil].firstObject;
    // 设置高度
    _headView.height = 420;
    // 设置头视图
    _table.tableHeaderView = _headView;
    // 代理人
    _table.delegate = self;
    _table.dataSource = self;
    // 注册cell
    [_table registerNib:[UINib nibWithNibName:NSStringFromClass([DemoTBVCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DemoTBVCell class])];
    
    
    NSArray *arrImgs = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    // 轮播图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2) shouldInfiniteLoop:YES imageNamesGroup:arrImgs];
    // 代理人
    _cycleScrollView.delegate = self;
    
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter; // 默认居中
    _cycleScrollView.autoScrollTimeInterval = 3;// 自定义轮播时间间隔
    // 打开用户交互
    self.headView.iv.userInteractionEnabled = YES;
    [_headView.iv addSubview:_cycleScrollView];
    
    
    // 图书介绍
    __block typeof(self) ws = self;
    
    // 可展开的文字 初始化
    self.expandLab = [[ExpandLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, _headView.viewForLbl.height)];
    [_expandLab setLabelText:@"我国现代诗人、文学评论家何其芳曾说：“诗是一种最集中地反映社会生活的文学样式，它饱和着丰富的想象和感情，常常以直接抒情的方式来表现，而且在精炼与和谐的程度上，特别是在节奏的鲜明上，它的语言有别于散文的语言。”这个定义性的说明，实际上概括了诗歌的几个基本特点." expandBlock:^{
        
        NSLog(@"%.2f",ws.expandLab.height);
        // 设置高度
        ws.headView.constraintOfViewForLblHeight.constant = ws.expandLab.height;
        ws.headView.height = SCREEN_WIDTH / 2 +5+20+5+20+5+30+5+ws.expandLab.height + 5+5 + 30;
        // 重新设置头视图
        ws.table.tableHeaderView = ws.headView;
        
    }];
    [self.headView.viewForLbl addSubview:_expandLab];
    
}

#pragma mark - Datasource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DemoTBVCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArray.count > indexPath.row) {
        cell.model = _dataArray[indexPath.row];
    }
    
    [cell doRefreshModel:^(id model, NSInteger rowNum, NSInteger sectionNum) {
        DemoModel * ttmodel = (DemoModel *)model;
        ttmodel.isOpen = !ttmodel.isOpen;
        //刷新选中的某一行
        [_dataArray replaceObjectAtIndex:indexPath.row withObject:ttmodel];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoModel * model = _dataArray[indexPath.row];
    if (model.isOpen) {
        //如果是打开的状态  就显示实际需要的高度
        return model.msgSize.height + 40;
    }else{
        //如果需要显示 展开的按钮 就返回100的高度  如果不需要 就返回70的高度
        if (model.shouldShowOpenBtn) {
            return 100;
        }else{
            return 70;
        }
    }
}

#pragma mark -TTRefreshCellDelegate
- (void)refreshCellHeght
{
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
    [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Cycle Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}

#pragma mark - 自定义方法
// 减法
- (IBAction)btnMinus:(id)sender
{
    int valueOfNum = [_lblNum.text intValue];
    int valueOfKuCun = [_lblKuCun.text intValue];
    if (valueOfNum <= 0) {
        _lblNum.text = @"0";
        return;
    } else {
        valueOfNum --;
        valueOfKuCun ++;
        _lblNum.text = [NSString stringWithFormat:@"%d",valueOfNum];
        _lblKuCun.text = [NSString stringWithFormat:@"%d",valueOfKuCun];
        
        [self setTabbarBadgeValueWithNum:valueOfNum];
    }
}

// 加法
- (IBAction)btnAdd:(id)sender
{
    int valueOfNum = [_lblNum.text intValue];
    int valueOfKuCun = [_lblKuCun.text intValue];
    if (valueOfNum < _intKuCun ) {
        valueOfNum ++;
        valueOfKuCun --;
        _lblNum.text = [NSString stringWithFormat:@"%d",valueOfNum];
        _lblKuCun.text = [NSString stringWithFormat:@"%d",valueOfKuCun];
        
        [self setTabbarBadgeValueWithNum:valueOfNum];
    }
}

// 设置底部tabbar的数量
- (void)setTabbarBadgeValueWithNum:(int)valueOfNum
{
    [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d",valueOfNum]];
    if (valueOfNum == 0) {
        [self.tabBarController.tabBar.items objectAtIndex:0].badgeColor = [UIColor clearColor];
    } else {
        [self.tabBarController.tabBar.items objectAtIndex:0].badgeColor = [UIColor redColor];
    }
}

@end
