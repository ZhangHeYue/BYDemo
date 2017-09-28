//
//  ViewController.m
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <MJRefresh.h>
#import "ViewController.h"
#import "ArticleModel.h"
#import "BYTableViewCell.h"
#import "BYNetWorkManager.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> 
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray<FeedModel*> *articleDataArray;
@property (nonatomic) NSInteger start;
@end

static NSInteger perCount = 5;
static NSString *cellIdentifier = @"BYTableViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self clearData];
    [self fetchData];
}

- (void)fetchData {
    __weak __typeof(self) weakself= self;
    [BYNetWorkManager fetchArticelFrom:_start perCount:perCount completionHandler:^(NSArray<FeedModel*> *models) {
        __strong __typeof(weakself) strongself= weakself;
        [strongself addNewData:models];
    }];
}

- (void)addNewData: (NSArray<FeedModel*> *) data {
    [_articleDataArray addObjectsFromArray:data];
    [_articleDataArray sortUsingComparator:^NSComparisonResult(FeedModel* obj1, FeedModel* obj2) {
        ReplyModel *r1 = obj1.replies[0];
        ReplyModel *r2 = obj2.replies[0];
        return r1.postedAt < r2.postedAt;
    }];
    _start = _start + perCount;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    });
}

- (void) configTableView {
    [_tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    _tableView.estimatedRowHeight = 88;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    __weak __typeof(self) weakself= self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof(weakself) strongself= weakself;
        [strongself clearData];
        [strongself fetchData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong __typeof(weakself) strongself= weakself;
        [strongself fetchData];
    }];
}

- (void)clearData {
    _start = 0;
    _articleDataArray = [NSMutableArray array];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell initWithFeedModel:_articleDataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_articleDataArray count];
}


@end
