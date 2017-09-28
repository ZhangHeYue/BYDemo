//
//  BYTableViewCell.h
//  BieYang
//
//  Created by 张和悦 on 2017/9/26.
//  Copyright © 2017年 com.ZHY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedModel.h"

@interface BYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *replyAvatar;
@property (weak, nonatomic) IBOutlet UILabel *replyName;
@property (weak, nonatomic) IBOutlet UILabel *replyTime;
@property (weak, nonatomic) IBOutlet UILabel *replyContent;
@property (weak, nonatomic) IBOutlet UIImageView *originAvatar;
@property (weak, nonatomic) IBOutlet UILabel *originName;
@property (weak, nonatomic) IBOutlet UILabel *originTime;
@property (weak, nonatomic) IBOutlet UILabel *originContent;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

- (void)initWithFeedModel: (FeedModel*) feed;
@end
