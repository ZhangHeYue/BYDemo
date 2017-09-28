//
//  BYNetWorkManager.m
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import "BYNetWorkManager.h"
#import "ArticleModel.h"
#import <AFNetworking.h>


static NSString *feedUrl = @"https://baleen-dev.bybieyang.com/feeds/comments";
static NSString *productUrl = @"https://5thave-dev.bybieyang.com/api/v1/product-comment/feeds/comments";

@implementation BYNetWorkManager

+ (void)fetchArticelFrom:(NSInteger)from perCount:(NSInteger)perCount completionHandler:(void (^)(NSArray<FeedModel*>*))completionHandler {
    NSDictionary *parameter = @{@"f": [NSNumber numberWithInteger:from], @"t": [NSNumber numberWithInteger:from + perCount]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"b85612b3-de4e-49ec-9238-ca8c0d3d6aab" forHTTPHeaderField:@"X-Session-Key"];
    [manager.requestSerializer setValue:@"48c85ab9-a7f5-4970-a310-f5c982fd9f4a" forHTTPHeaderField:@"X-Session-User"];
    
    __block ArticleModel *feed;
    __block ArticleModel *product;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t dispatchQueue = dispatch_queue_create("zhy.network", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        [manager GET:feedUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            feed = [[ArticleModel alloc]initWithDictionary:responseObject error:nil];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败 === %@",error);
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        [manager GET:productUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            product = [[ArticleModel alloc]initWithDictionary:responseObject error:nil];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败 === %@",error);
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_notify(dispatchGroup, dispatchQueue, ^(){
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self sortResultFeed:feed products:product completionHandler:completionHandler];
    });
}

+(void)sortResultFeed:(ArticleModel*)feed products: (ArticleModel*)product completionHandler:(void (^)(NSArray<FeedModel*>*))completionHandler {
    NSArray<FeedModel*> *result = [feed.feeds arrayByAddingObjectsFromArray:product.feeds];
    completionHandler(result);
}

@end
