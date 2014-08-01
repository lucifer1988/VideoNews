//
//  VNNewsDetailViewController.h
//  VideoNews
//
//  Created by liuyi on 14-6-30.
//  Copyright (c) 2014年 Manyu Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SourceViewControllerType) {
    SourceViewControllerTypeHome = 0,
    SourceViewControllerTypeCategory = 1,
    SourceViewControllerTypeNotification = 2,
    SourceViewControllerTypeProfile = 3,
    SourceViewControllerTypeMineProfile=4,
    SourceViewControllerTypeSearch=5
};

@interface VNNewsDetailViewController : UIViewController

@property (strong, nonatomic) VNNews *news;
@property (strong, nonatomic) VNMedia *media;
@property (strong, nonatomic) VNMedia *vedioMedia;
@property (assign, nonatomic) SourceViewControllerType controllerType;
@property (strong, nonatomic) NSNumber *pid;
@property (strong, nonatomic) NSString *sender_id;
@property (strong, nonatomic) NSString *sender_name;

@end
