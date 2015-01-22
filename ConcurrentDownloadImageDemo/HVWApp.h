//
//  HVWApp.h
//  ConcurrentDownloadImageDemo
//
//  Created by hellovoidworld on 15/1/22.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWApp : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *download;

- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) appWithDictionary:(NSDictionary *) dict;

@end
