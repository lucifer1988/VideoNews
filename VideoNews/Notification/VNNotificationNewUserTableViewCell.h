//
//  VNNotificationNewUserTableViewCell.h
//  VideoNews
//
//  Created by 曼瑜 朱 on 14-8-17.
//  Copyright (c) 2014年 Manyu Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEventHandler)();

@interface VNNotificationNewUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *thumbnailButton;
//@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) VNMessage *message;

@property (copy, nonatomic) ClickEventHandler tapHandler;

- (void)reload;


@end
