//
//  FeedModel.h
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "ReplyModel.h"

@protocol ReplyModel;

@interface FeedModel : JSONModel
@property (nonatomic) NSString *id;
@property (nonatomic) NSString <Optional> *articleId;
@property (nonatomic) double postedAt;
@property (nonatomic) NSString *userLabel;
@property (nonatomic) NSString <Optional> *userAvatar;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString <Optional> *articleTitle;
@property (nonatomic) NSString <Optional> *productTitle;
@property (nonatomic) NSArray<ReplyModel> *replies;
@end
