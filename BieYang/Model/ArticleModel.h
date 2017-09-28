//
//  ArticleModel.h
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "FeedModel.h"

@protocol FeedModel;

@interface ArticleModel : JSONModel
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger from;
@property (nonatomic) NSInteger to;
@property (nonatomic) NSArray <FeedModel> *feeds;
@end
