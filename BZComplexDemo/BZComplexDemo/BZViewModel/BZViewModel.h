//
//  BZViewModel.h
//  BZComplexDemo
//
//  Created by brandon on 2020/7/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BZViewModelDataDelegate

+ (NSInteger)numberOfTableRow;

+ (nonnull __kindof UITableViewCell *)cellFrom:(UITableView *)tableview forIndex:(NSIndexPath*)indexPath;

+(void)registerCellsFor:(UITableView *)tv;

+ (void)getListViewData:(void (^)(void))complete;

+ (CGFloat)heightOfRowAt:(NSIndexPath*)indexPath;

@end

@interface BZViewModel : NSObject<BZViewModelDataDelegate>

@end

NS_ASSUME_NONNULL_END
