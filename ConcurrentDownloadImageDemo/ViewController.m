//
//  ViewController.m
//  ConcurrentDownloadImageDemo
//
//  Created by hellovoidworld on 15/1/22.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "ViewController.h"
#import "HVWApp.h"
#import "HVWDownloadImageOperation.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HVWDownloadImageOperationDelegate>

@property(nonatomic, strong) NSArray *apps;

@property(nonatomic, strong) NSOperationQueue *queue;

@property(nonatomic, strong) NSMutableDictionary *operations;
@property(nonatomic, strong) NSMutableDictionary *images;

@end

@implementation ViewController

- (NSArray *)apps {
    if (nil == _apps) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HVWApp *app = [HVWApp appWithDictionary:dict];
            [appArray addObject:app];
        }
        _apps = appArray;
    }
    return _apps;
}

- (NSOperationQueue *)queue {
    if (_queue == nil ) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

- (NSMutableDictionary *)operations {
    if (nil == _operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSMutableDictionary *)images {
    if (nil == _images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"AppCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    HVWApp *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    // 占位图片
    cell.imageView.image = [UIImage imageNamed:@"a9ec8a13632762d0092abc3ca2ec08fa513dc619"];
    
    // 如果没有图片，准备开启线程下载图片
    UIImage *image = self.images[app.icon];
    
    if (image) {
        // 如果图片存在，不需要重复下载，直接设置图片
        cell.imageView.image = image;
    } else {
        
        // 如果图片不存在，看看是不是正在下载
        HVWDownloadImageOperation *operation = self.operations[app.icon];
        
        if (operation) {
            // 如果图片正在下载，不必要开启线的线程再进行下载
        } else {
            
            // 没有在下载，创建一个新的任务进行下载
            operation = [[HVWDownloadImageOperation alloc] init];
            // 设置代理
            operation.delegate = self;
            // 传送url
            operation.url = app.icon;
            // 记录indexPath
            operation.indexPath = indexPath;
            
            [self.queue addOperation:operation];
            
            // 记录正在下载的任务
            [self.operations setObject:operation forKey:operation.url];
        }
    }
    
    return cell;
}

#pragma mark - HVWDownloadImageOperationDelegate
- (void)downloadImageOperation:(HVWDownloadImageOperation *)operation didFinishedDownloadWithImage:(UIImage *)image {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:operation.indexPath];
    cell.imageView.image = image;
    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 存储图片到内存
    if (image) {
        [self.images setObject:image forKey:operation.url];
    }
    
    NSLog(@"已经下载的图片数==========>%d", self.images.count);
}

@end
