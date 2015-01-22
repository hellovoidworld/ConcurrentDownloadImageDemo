//
//  HVWApp.m
//  ConcurrentDownloadImageDemo
//
//  Created by hellovoidworld on 15/1/22.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWApp.h"

@implementation HVWApp

- (instancetype) initWithDictionary:(NSDictionary *) dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) appWithDictionary:(NSDictionary *) dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
