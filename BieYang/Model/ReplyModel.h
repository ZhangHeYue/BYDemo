//
//  ReplyModel.h
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface ReplyModel : JSONModel
@property (nonatomic) NSString *id;
@property (nonatomic) NSString <Optional> *articleId;
@property (nonatomic) double postedAt;
@property (nonatomic) NSString *userLabel;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString <Optional> *userAvatar;
@end
