//
//  BZComplexCell.m
//  BZComplexDemo
//
//  Created by brandon on 2020/7/3.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "BZComplexCell.h"

@interface BZComplexCell()

@property(nonatomic,assign)NSInteger itemHW;

@property(nonatomic,assign)NSInteger itemPadding;

@property(nonatomic,strong)UILabel *line;

@end

@implementation BZComplexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.headerImageV = [[UIImageView alloc] init];
    self.headerImageV.layer.cornerRadius = 20;
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.tag = 6888;
    self.headerImageV.backgroundColor = iColor(202, 202, 202, 1);
    [self.contentView addSubview:self.headerImageV];
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.left.equalTo(@25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.nameTitleLabel = [[UILabel alloc] init];
    self.nameTitleLabel.font = [UIFont systemFontOfSize:14];
    self.nameTitleLabel.textColor = iColor(224, 108, 55, 1);
    [self.contentView addSubview:self.nameTitleLabel];
    [self.nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageV);
        make.left.mas_equalTo(self.headerImageV.mas_right).with.mas_offset(@10);
        make.right.equalTo(@0).with.mas_offset(@-25);
    }];
    
    self.deviceTitleLabel = [[UILabel alloc] init];
    self.deviceTitleLabel.font = [UIFont systemFontOfSize:10];
    self.deviceTitleLabel.textColor = iColor(90, 123, 163, 1);
    [self.contentView addSubview:self.deviceTitleLabel];
    [self.deviceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTitleLabel.mas_bottom).with.mas_offset(@5);
        make.left.mas_equalTo(self.nameTitleLabel);
        make.right.equalTo(@0).with.mas_offset(@-25);
//        make.bottom.equalTo(@0).with.mas_offset(@(-25));
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor blackColor];

    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageV.mas_bottom).with.mas_offset(@20);
        make.left.mas_equalTo(@(30));
        make.right.equalTo(@0).with.mas_offset(@-25);
    }];
    
   self.line = [[UILabel alloc] init];
   self.line.backgroundColor = iColor(231, 231, 231, 1);
   [self.contentView addSubview:self.line];
   [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.trailing.equalTo(@0);
       make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(@25);
       make.height.equalTo(@1);
       make.bottom.equalTo(@0);
   }];
    
}

- (void)updateCellWithData:(NSDictionary *)data_dict{
    self.nameTitleLabel.text = data_dict[@"UserNameString"];
    self.deviceTitleLabel.text = data_dict[@"DeviceTypeString"];
    self.contentLabel.text = data_dict[@"ContentLabelString"];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:data_dict[@"UserHeaderUrl"]]];
    self.headerImageV.image = [UIImage imageWithData:data];
//    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:data_dict[@"UserHeaderUrl"]]];
    [self layoutIfNeeded];
}

- (void)updateCellWithImageArray:(NSArray *)img_arr{
    int cols;
    int rows;
    
    [self countingRow:&rows numberOfCol:&cols imageArr:img_arr];
    if (img_arr.count == 0) {
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(@0);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(@25);
            make.height.equalTo(@1);
            make.bottom.equalTo(@0);
        }];
        [self layoutIfNeeded];
        return;
    }
    
    if (img_arr.count == 1) {
        UIImageView *img_V = [[UIImageView alloc] init];
        img_V.backgroundColor = iColor(202, 202, 202, 1);
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[0]]];
        img_V.image = [UIImage imageWithData:data];
//        [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[0]]];
        [self.contentView addSubview:img_V];
        [img_V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(150, 200));
        }];
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(@0);
            make.top.mas_equalTo(img_V.mas_bottom).with.mas_offset(@25);
            make.height.equalTo(@1);
            make.bottom.equalTo(@0);
        }];
        [self layoutIfNeeded];
        return;
    }
    
    if (img_arr.count > 1) {
        NSInteger index = 0;
        self.itemPadding = 10;
        self.itemHW = ((iScreenW-50)-((cols-1)*self.itemPadding))/cols;
        for (int i = 0; i < rows; i++) {
            
            if (i == rows-1) {
                for (int j = 0; j < img_arr.count-i*cols; j++) {
                    UIImageView *img_V = [[UIImageView alloc] init];
                    img_V.backgroundColor = iColor(202, 202, 202, 1);
//                    [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[index++]]];
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[index++]]];
                    img_V.image = [UIImage imageWithData:data];
                    [self.contentView addSubview:img_V];
                    [img_V mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(j*(self.itemHW+self.itemPadding)+25);
                        make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(20+i*(self.itemHW+self.itemPadding));
                        make.size.mas_equalTo(CGSizeMake(self.itemHW, self.itemHW));
                    }];
                    
                    if (j == img_arr.count-i*cols -1) {
                        
                        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.leading.trailing.equalTo(@0);
                            make.top.mas_equalTo(img_V.mas_bottom).with.mas_offset(@25);
                            make.height.equalTo(@1);
                            make.bottom.equalTo(@0);
                        }];
                        [self layoutIfNeeded];
                        return;
                    }
                }
                
            }
            
            for (int j = 0; j < cols; j++) {
                UIImageView *img_V = [[UIImageView alloc] init];
                img_V.backgroundColor = iColor(202, 202, 202, 1);
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[index++]]];
                img_V.image = [UIImage imageWithData:data];
//                [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[index++]]];
                [self.contentView addSubview:img_V];
                [img_V mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(j*(self.itemHW+self.itemPadding)+25);
                    make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(20+i*(self.itemHW+self.itemPadding));
                    make.size.mas_equalTo(CGSizeMake(self.itemHW, self.itemHW));
                }];
            }
        }
    }
    
    [self layoutIfNeeded];
}

- (void)countingRow:(int *)rows numberOfCol:(int *)cols imageArr:(NSArray *)img_arr{
    if (img_arr.count <= 0) {
        //无图片
        rows = 0;
        cols = 0;
    }else if (img_arr.count == 1){
        //单图放原始大小
        *rows = 1;
        *cols = 1;
    }else if (img_arr.count == 2){
        //两图按照2图，尺寸1
        *rows = 1;
        *cols = 2;
    }else if (img_arr.count <=4){
        //3-4图按照，尺寸2
        *rows = 2;
        *cols = 2;
    }else if (img_arr.count <=6){
        //5-6图，尺寸3
        *rows = 2;
        *cols = 3;
    }else if (img_arr.count <=9){
        //7-9图，尺寸4
        *rows = 3;
        *cols = 3;
    }
    
}

- (void)cleanDataForReuse{
    for (UIView *dele_V in self.contentView.subviews) {
        if ([dele_V isKindOfClass:[UIImageView class]] && dele_V.tag != 6888) {
            [dele_V removeFromSuperview];
        }
        
        if ([dele_V isKindOfClass:[UILabel class]] && dele_V.tag == 7888) {
            [dele_V removeFromSuperview];
        }
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self cleanDataForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
