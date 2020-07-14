//
//  BZViewModel.m
//  BZComplexDemo
//
//  Created by brandon on 2020/7/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "BZViewModel.h"
#import "BZDataManager.h"
#import "BZComplexCell.h"

@implementation BZViewModel

+(NSString *)iden4Cell{
    return NSStringFromClass(BZComplexCell.class);
}

+(void)registerCellsFor:(UITableView *)tv{
    
    [tv registerClass:BZComplexCell.class forCellReuseIdentifier:[self iden4Cell]];
 
}

+ (void)getListViewData:(void (^)(void))complete{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
        // 追加任务 1：请求数据
        [[BZDataManager shared] loadData];
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 2：异步计算高度
        [self countingViewHeight];
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        complete();
    });
}

+ (nonnull __kindof UITableViewCell *)cellFrom:(nonnull UITableView *)tableview forIndex:(nonnull NSIndexPath *)indexPath {
    BZComplexCell *cell = [tableview dequeueReusableCellWithIdentifier:[self iden4Cell] forIndexPath:indexPath];
    if (!cell) {
        cell = [[BZComplexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self iden4Cell]];
    }
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"CELLFRAMEKEY"];
    NSString *key = [NSString stringWithFormat:@"frameKey+%zu",indexPath.row];
    NSDictionary *frameDict = [dict objectForKey:key];
    CGFloat title_h = [[frameDict objectForKey:@"titleH"] floatValue];
    CGFloat device_h = [[frameDict objectForKey:@"deviceH"] floatValue];
    CGFloat content_h = [[frameDict objectForKey:@"contentH"] floatValue];
    [cell updateCellWithData:[BZDataManager shared].data[indexPath.row] titleH:title_h deviceH:device_h contentH:content_h];
    return cell;
}

+ (void)countingViewHeight{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block NSMutableDictionary *frameDict = [[NSMutableDictionary alloc] init];
    NSLog(@"apply---begin");
    
    dispatch_apply([BZDataManager shared].data.count, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
        NSDictionary *tempDict = [[NSMutableDictionary alloc] init];
        NSDictionary *dict = [BZDataManager shared].data[index];
        NSNumber *titleH = [NSNumber numberWithFloat:[self countingLabelHeight:dict[@"UserNameString"] fontsize:14 width:200]];
        [tempDict setValue:titleH forKey:@"titleH"];
        NSNumber *deviceH = [NSNumber numberWithFloat:[self countingLabelHeight:dict[@"DeviceTypeString"] fontsize:10 width:200]];
        [tempDict setValue:deviceH forKey:@"deviceH"];
        NSNumber *contentH = [NSNumber numberWithFloat:[self countingLabelHeight:dict[@"ContentLabelString"] fontsize:16 width:iScreenW-40]];
        [tempDict setValue:contentH forKey:@"contentH"];
        NSNumber *imageH = [NSNumber numberWithFloat:[self countingHeight:dict[@"ContentImageArray"]]];
        [tempDict setValue:imageH forKey:@"imageH"];
        NSString *key = [NSString stringWithFormat:@"frameKey+%zu",index];
        [frameDict setValue:tempDict forKey:key];
    });
    [[NSUserDefaults standardUserDefaults] setObject:frameDict forKey:@"CELLFRAMEKEY"];
    NSLog(@"apply---end");
}

+ (CGFloat)countingLabelHeight:(NSString *)string fontsize:(CGFloat)fontsize width:(CGFloat)width{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 5;       //字间距5
    paraStyle.paragraphSpacing = 5;       //行间距是20
    paraStyle.alignment = NSTextAlignmentLeft;   //对齐方式为居中对齐
    NSDictionary *dic = @{ NSFontAttributeName:[UIFont systemFontOfSize:fontsize], NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}

+ (NSInteger)numberOfTableRow {
    return [BZDataManager shared].data.count;
}

+ (CGFloat)countingHeight:(NSArray *)img_arr{
    if (img_arr.count <= 0) {
        //无图片
        return 0;
    }else if (img_arr.count == 1){
        //单图放原始大小
        return 200;
    }else if (img_arr.count == 2){
        //两图按照2图，尺寸1
        int cols = 2;
        return ((iScreenW-50)-((cols-1)*10))/cols;
    }else if (img_arr.count <=4){
        //3-4图按照，尺寸2
        int cols = 2;
        return ((iScreenW-50)-((cols-1)*10))/cols;
    }else if (img_arr.count <=6){
        //5-6图，尺寸3
        int cols = 3;
        return ((iScreenW-50)-((cols-1)*10))/cols;
    }else if (img_arr.count <=9){
        //7-9图，尺寸4
        int cols = 3;
        return ((iScreenW-50)-((cols-1)*10))/cols;
    }
    return 0;
    
}

+ (CGFloat)heightOfRowAt:(NSIndexPath *)indexPath{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"CELLFRAMEKEY"];
    NSString *key = [NSString stringWithFormat:@"frameKey+%zu",indexPath.row];
    NSDictionary *frameDict = [dict objectForKey:key];
    CGFloat title_h = [[frameDict objectForKey:@"titleH"] floatValue];
    CGFloat device_h = [[frameDict objectForKey:@"deviceH"] floatValue];
    CGFloat content_h = [[frameDict objectForKey:@"contentH"] floatValue];
    CGFloat image_h = [[frameDict objectForKey:@"imageH"] floatValue];
    return 25+title_h+5+device_h+25+content_h+25+image_h+20+1;
}

@end
