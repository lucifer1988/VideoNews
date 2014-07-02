//
//  VNUser.m
//  VideoNews
//
//  Created by liuyi on 14-6-26.
//  Copyright (c) 2014年 Manyu Zhu. All rights reserved.
//

#import "VNUser.h"

static NSString *kUid = @"uid";
static NSString *kName = @"name";
static NSString *kAvatar = @"avatar";
static NSString *kLocation = @"location";
static NSString *kSex = @"sex";
static NSString *kMain_uid = @"main_uid";

@implementation VNUser

- (int)uid {
    return [makeSureNotNull([self.basicDict objectForKey:kUid]) intValue];
}

- (NSString *)name {
    return makeSureNotNull([self.basicDict objectForKey:kName]);
}

- (NSString *)avatar {
    return makeSureNotNull([self.basicDict objectForKey:kAvatar]);
}

- (NSString *)location {
    return makeSureNotNull([self.basicDict objectForKey:kLocation]);
}

- (NSString *)sex {
    return makeSureNotNull([self.basicDict objectForKey:kSex]);
}

- (NSString *)main_uid {
    return makeSureNotNull([self.basicDict objectForKey:kMain_uid]);
}

@end
