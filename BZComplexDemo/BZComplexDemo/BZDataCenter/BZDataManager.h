//
//  BZDataManager.h
//  BZComplexDemo
//
//  Created by brandon on 2020/7/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BZDataManager : NSObject

+ (instancetype)shared;

- (void)loadData;

//在数据中心中处理数据
@property(nonatomic,strong)NSArray *data;

@end

NS_ASSUME_NONNULL_END
