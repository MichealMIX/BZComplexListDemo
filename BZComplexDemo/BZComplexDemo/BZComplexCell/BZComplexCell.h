//
//  BZComplexCell.h
//  BZComplexDemo
//
//  Created by brandon on 2020/7/3.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BZComplexCell : UITableViewCell

//@property(nonatomic,strong)UIImageView *headerImageV;
@property(nonatomic,strong)CALayer *imageLayer;

//@property(nonatomic,strong)UILabel *nameTitleLabel;

@property(nonatomic,strong)CATextLayer *nameTitleLayer;

//@property(nonatomic,strong)UILabel *deviceTitleLabel;

@property(nonatomic,strong)CATextLayer *deviceTitleLayer;

//@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)CATextLayer *contentLayer;

- (void)updateCellWithData:(NSDictionary *)data_dict;

- (void)updateCellWithData:(NSDictionary *)data titleH:(CGFloat)titleLabel_H deviceH:(CGFloat)deviceLabel_H contentH:(CGFloat)contentH;

- (void)updateCellWithImageArray:(NSArray *)img_arr;

@end

NS_ASSUME_NONNULL_END
