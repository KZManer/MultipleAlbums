//
//  KZAlbumViewController.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "KZGroupInfo.h"
#import "KZGroupCell.h"
#import "MacroDefinition.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface KZAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ALAssetsLibrary *_assetsLibrary;
    NSMutableArray *_groupArr;
    UITableView *_tableView;
}
@end

@implementation KZAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self addTableView];
    [self loadAssetsLibrary];
}
//
- (void)setNavigationBar{
    self.title = @"照片";
    [[UINavigationBar appearance] setBarTintColor:kColor(57, 56, 60)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(18),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClicked)];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:kFont(15),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)addTableView{
    CGRect frame = self.view.bounds;
    _tableView = [[UITableView alloc]initWithFrame:frame];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = groupCellHeight;
    [_tableView registerNib:[UINib nibWithNibName:@"KZGroupCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    
     _groupArr = [NSMutableArray arrayWithCapacity:20];
}
- (void)loadAssetsLibrary{
    _assetsLibrary = [[ALAssetsLibrary alloc]init];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if ([group numberOfAssets]>0) {
                KZGroupInfo *groupInfo = [KZGroupInfo groupInitWithGroup:group];
                [_groupArr addObject:groupInfo];
            }
        } else {
            //将数组中的相册进行反向排序，使默认的相册排在最上面
            _groupArr = (NSMutableArray *)[[_groupArr reverseObjectEnumerator]allObjects];
            [_tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error-%@",error);
    }];
}
- (void)cancelBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _groupArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KZGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KZGroupInfo *groupInfo = _groupArr[indexPath.row];
    [cell setContentView:groupInfo];
    return cell;
}
#pragma mark-UITableViewDelegate
//UITableView 分割线不靠左(未补全),删除多余分割线问题
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
