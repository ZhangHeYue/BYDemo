//
//  BYTableViewCell.m
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import "BYTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _replyAvatar.layer.cornerRadius = 15;
    _replyAvatar.layer.masksToBounds = true;
    _originAvatar.layer.cornerRadius = 10;
    _originAvatar.layer.masksToBounds = true;
}

- (void)initWithFeedModel:(FeedModel *)feed {
    ReplyModel *reply = feed.replies[0];
    _replyName.text = reply.userLabel;
    _replyTime.text = [self formatTimeStamp: reply.postedAt];
    _replyContent.text = reply.content;
    [_replyAvatar sd_setImageWithURL:[NSURL URLWithString:reply.userAvatar]];
    
    _originName.text = feed.userLabel;
    _originTime.text = [self formatTimeStamp: feed.postedAt];
    _originContent.text = feed.content;
    [_originAvatar sd_setImageWithURL:[NSURL URLWithString:feed.userAvatar]];
    
    _sourceLabel.text = [self setSourceLabelTextByFeed:feed];
}

- (NSString*)formatTimeStamp: (double)timeStamp {
    NSTimeInterval interval = timeStamp / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate: date];
}

- (NSString*)setSourceLabelTextByFeed: (FeedModel*) model {
    if (model.productTitle != nil) {
        return [NSString stringWithFormat:@"来自商品-%@", model.productTitle];
    }
    if (model.articleTitle != nil) {
        return [NSString stringWithFormat:@"来自文章-%@", model.articleTitle];
    }
    return @"";
}

@end
