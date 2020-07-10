//
//  BZDataManager.m
//  BZComplexDemo
//
//  Created by brandon on 2020/7/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "BZDataManager.h"

@implementation BZDataManager

+ (instancetype)shared{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)loadData{
    self.data = iRes4ary(@"BZListData.plist");
}

- (NSDictionary *)getDataWithIndex:(NSInteger)index{
    NSDictionary *dict = self.data[index];
    return dict;
}

- (NSArray *)data{
    return iRes4ary(@"BZListData.plist");
}

@end
