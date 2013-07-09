
/*!
 * Copyright (c) 2013,福建星网视易信息系统有限公司
 * All rights reserved.
 
 * @File:       ThumbnailExtractor.h
 * @Abstract:   缩略图提取器
 * @History:
 
 -2013-06-19 创建 by xuwf
 -2013-06-20 解决无法获取thumbnail时导致crash bug
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ThumbnailExtractorErrorCode (-2000)

@interface ThumbnailExtractor : NSObject

/*!
 根据URL获取缩略图（暂时只支持JPG），当JPG含有EXIF信息，则返回相应的image，否则返回nil
 @param     url
 文件URL
 
 @param     error
 错误信息
 
 @return    UIImage
 */
+ (UIImage* )thumbnailForURL:(NSURL* )url error:(NSError** )error;
@end
