//
//  BYNetWorkManager.h
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface BYNetWorkManager : NSObject

+ (void)fetchArticelFrom:(NSInteger)from perCount:(NSInteger)perCount completionHandler:(void (^)(NSArray<FeedModel*>*))completionHandler;

@end
