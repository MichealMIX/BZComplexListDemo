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

@property(nonatomic,strong)NSDictionary *data;

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

    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(25, 25, 40, 40);
    self.imageLayer.cornerRadius = 20;
    self.imageLayer.masksToBounds = YES;
    self.imageLayer.contentsGravity = kCAGravityResizeAspect;
    [self.contentView.layer addSublayer:self.imageLayer];
        
    
    
    
    self.nameTitleLayer = [CATextLayer layer];
    //设置分辨率
    self.nameTitleLayer.contentsScale = [UIScreen mainScreen].scale;
    //字体的大小
    self.nameTitleLayer.fontSize = 14.f;
    //字体的对齐方式
    self.nameTitleLayer.alignmentMode = kCAAlignmentLeft;
    //字体的颜色
    self.nameTitleLayer.foregroundColor = iColor(224, 108, 55, 1).CGColor;
    [self.contentView.layer addSublayer:self.nameTitleLayer];
    
    
    self.deviceTitleLayer = [CATextLayer layer];
    //设置分辨率
    self.deviceTitleLayer.contentsScale = [UIScreen mainScreen].scale;
    //字体的大小
    self.deviceTitleLayer.fontSize = 10.f;
    //字体的对齐方式
    self.deviceTitleLayer.alignmentMode = kCAAlignmentLeft;
    //字体的颜色
    self.deviceTitleLayer.foregroundColor = iColor(90, 123, 163, 1).CGColor;
    [self.contentView.layer addSublayer:self.deviceTitleLayer];
    
    /*self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor blackColor];

    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@80).with.mas_offset(@20);
        make.left.mas_equalTo(@(30));
        make.right.equalTo(@0).with.mas_offset(@-25);
    }];*/
    
    self.contentLayer = [CATextLayer layer];
    //设置分辨率
    self.contentLayer.contentsScale = [UIScreen mainScreen].scale;
    //字体的大小
    self.contentLayer.fontSize = 16.f;
    //字体的对齐方式
    self.contentLayer.alignmentMode = kCAAlignmentLeft;
    //字体的颜色
    self.contentLayer.foregroundColor = [UIColor blackColor].CGColor;
    self.contentLayer.wrapped = YES;
    [self.contentView.layer addSublayer:self.contentLayer];
    
   self.line = [[UILabel alloc] init];
   self.line.backgroundColor = iColor(231, 231, 231, 1);
   [self.contentView addSubview:self.line];
//   [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.leading.trailing.equalTo(@0);
//       make.top.mas_equalTo(self.contentLabel.mas_bottom).with.mas_offset(@25);
//       make.height.equalTo(@1);
//       make.bottom.equalTo(@0);
//   }];
    
}

- (void)updateCellWithData:(NSDictionary *)data_dict{
//    self.nameTitleLabel.text = data_dict[@"UserNameString"];
    
    self.nameTitleLayer.string = data_dict[@"UserNameString"];
    self.deviceTitleLayer.string = data_dict[@"DeviceTypeString"];
    //self.contentLabel.text = data_dict[@"ContentLabelString"];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:data_dict[@"UserHeaderUrl"]]];
    self.imageLayer.contents = (__bridge id _Nullable)([UIImage imageWithData:data].CGImage);
//    self.headerImageV.image = [UIImage imageWithData:data];
//    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:data_dict[@"UserHeaderUrl"]]];
    [self layoutIfNeeded];
}

- (void)updateCellWithData:(NSDictionary *)data titleH:(CGFloat)titleLabel_H deviceH:(CGFloat)deviceLabel_H contentH:(CGFloat)contentH{
    NSData * imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:data[@"UserHeaderUrl"]]];
    self.imageLayer.contents = (__bridge id _Nullable)([UIImage imageWithData:imgdata].CGImage);
    self.nameTitleLayer.string = data[@"UserNameString"];
    self.nameTitleLayer.frame = CGRectMake(75, 25, 200, titleLabel_H);
    self.deviceTitleLayer.string = data[@"DeviceTypeString"];
    self.deviceTitleLayer.frame = CGRectMake(75, 25+titleLabel_H+5, 200, deviceLabel_H);
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:data[@"ContentLabelString"]];
    
    // 创建NSMutableParagraphStyle实例
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;       //字间距5
    paragraphStyle.paragraphSpacing = 5;       //行间距是20
    paragraphStyle.alignment = NSTextAlignmentLeft;   //对齐方式为居中对齐
    
    [fontAttributeNameStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, fontAttributeNameStr.length)];
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, fontAttributeNameStr.length)];
    self.contentLayer.string = fontAttributeNameStr;
    self.contentLayer.frame = CGRectMake(20, 25+titleLabel_H+5+deviceLabel_H+25, iScreenW-40, contentH);
    
    [self updateCellWithImageArray:data[@"ContentImageArray"] originY:25+titleLabel_H+5+deviceLabel_H+25+contentH];
    [self layoutIfNeeded];
}

- (void)updateCellWithImageArray:(NSArray *)img_arr originY:(CGFloat)originY{
    int cols;
    int rows;
    
    [self countingRow:&rows numberOfCol:&cols imageArr:img_arr];
    if (img_arr.count == 0) {

        self.line.frame = CGRectMake(0, originY+20, iScreenW, 1);
        [self layoutIfNeeded];
        return;
    }
    
    if (img_arr.count == 1) {
        UIImageView *img_V = [[UIImageView alloc] initWithFrame:CGRectMake(25, originY+25, 150, 200)];
        img_V.backgroundColor = iColor(202, 202, 202, 1);
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[0]]];
        img_V.image = [UIImage imageWithData:data];
//        [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[0]]];
        [self.contentView addSubview:img_V];
        
        self.line.frame = CGRectMake(0, originY+25+200+20, iScreenW, 1);
//        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.leading.trailing.equalTo(@0);
//            make.top.mas_equalTo(img_V.mas_bottom).with.mas_offset(@25);
//            make.height.equalTo(@1);
//            make.bottom.equalTo(@0);
//        }];
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
                    UIImageView *img_V = [[UIImageView alloc] initWithFrame:CGRectMake(j*(self.itemHW+self.itemPadding)+25, 20+i*(self.itemHW+self.itemPadding)+originY, self.itemHW, self.itemHW)];
                    img_V.backgroundColor = iColor(202, 202, 202, 1);
//                    [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[index++]]];
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[index++]]];
                    img_V.image = [UIImage imageWithData:data];
                    [self.contentView addSubview:img_V];
//                    [img_V mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.mas_equalTo(j*(self.itemHW+self.itemPadding)+25);
//                        make.top.mas_equalTo(originY).with.mas_offset(20+i*(self.itemHW+self.itemPadding));
//                        make.size.mas_equalTo(CGSizeMake(self.itemHW, self.itemHW));
//                    }];

                    if (j == img_arr.count-i*cols -1) {
                        self.line.frame = CGRectMake(0, originY+25+200+20, iScreenW, 1);
//                        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.leading.trailing.equalTo(@0);
//                            make.top.mas_equalTo(img_V.mas_bottom).with.mas_offset(@25);
//                            make.height.equalTo(@1);
//                            make.bottom.equalTo(@0);
//                        }];
                        [self layoutIfNeeded];
                        return;
                    }
                }

            }

            for (int j = 0; j < cols; j++) {
                UIImageView *img_V = [[UIImageView alloc] initWithFrame:CGRectMake(j*(self.itemHW+self.itemPadding)+25, 20+i*(self.itemHW+self.itemPadding)+originY, self.itemHW, self.itemHW)];
                img_V.backgroundColor = iColor(202, 202, 202, 1);
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img_arr[index++]]];
                img_V.image = [UIImage imageWithData:data];
//                [img_V sd_setImageWithURL:[NSURL URLWithString:img_arr[index++]]];
                [self.contentView addSubview:img_V];
//                [img_V mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(j*(self.itemHW+self.itemPadding)+25);
//                    make.top.mas_equalTo(originY).with.mas_offset(20+i*(self.itemHW+self.itemPadding));
//                    make.size.mas_equalTo(CGSizeMake(self.itemHW, self.itemHW));
//                }];
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
        
//        if ([dele_V isKindOfClass:[UILabel class]] && dele_V.tag == 7888) {
//            [dele_V removeFromSuperview];
//        }
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
