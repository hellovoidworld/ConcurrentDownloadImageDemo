//
//  HVWDownloadImageOperation.m
//  ConcurrentDownloadImageDemo
//
//  Created by hellovoidworld on 15/1/22.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVWDownloadImageOperation.h"


@implementation HVWDownloadImageOperation

- (void)main {
    NSLog(@"====下载图片======%@", [NSThread currentThread]);
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSData *data;
    for (int i=0; i<1; i++) {
        data = [NSData dataWithContentsOfURL:url];
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    if ([self.delegate respondsToSelector:@selector(downloadImageOperation:didFinishedDownloadWithImage:)]) {
        [self.delegate downloadImageOperation:self didFinishedDownloadWithImage:image];
    }
}

@end
