//
//  HVWDownloadImageOperation.h
//  ConcurrentDownloadImageDemo
//
//  Created by hellovoidworld on 15/1/22.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HVWDownloadImageOperation;

@protocol HVWDownloadImageOperationDelegate <NSObject>

@optional
- (void) downloadImageOperation:(HVWDownloadImageOperation *) operation didFinishedDownloadWithImage:(UIImage *) image;

@end

@interface HVWDownloadImageOperation : NSOperation

@property(nonatomic, strong) NSString *url;

@property(nonatomic, strong) NSIndexPath *indexPath;

@property(nonatomic, weak) id<HVWDownloadImageOperationDelegate> delegate;

@end
