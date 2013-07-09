
/*!
 * Copyright (c) 2013,福建星网视易信息系统有限公司
 * All rights reserved.
 
 * @File:       ThumbnailExtractor.m
 * @Abstract:   缩略图提取器
 * @History:
 
 -2013-06-19 创建 by xuwf
 */


#import "ThumbnailExtractor.h"
#include <libexif/exif-data.h>

NSString* const ThumbnailExtractorErrorDomain = @"ThumbnailExtractorErrorDomain";

#define THUMBNAIL_MAX_SIZE  (128*1024) /* 16k */
#define REQUEST_TIMEOUT     (20.0f)     /* 20s */

@implementation ThumbnailExtractor
+ (UIImage* )thumbnailForURL:(NSURL* )url error:(NSError** )error {
    NSData* content = nil;
    UIImage* thumbnail = nil;
    NSError* err;
    
    //本地
    if ([url isFileURL]) {
        content = [NSData dataWithContentsOfURL:url];
    } else {
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:[NSString stringWithFormat:@"bytes=0-%d",THUMBNAIL_MAX_SIZE] forHTTPHeaderField:@"Range"];
        [request setTimeoutInterval:REQUEST_TIMEOUT];
        NSHTTPURLResponse* response;
        content = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    }
    
    if (!content || !content.length) nil;
    
    //读取exifData
    ExifData* exifData = exif_data_new_from_data(content.bytes, content.length);
    if (!exifData) {
        err = [NSError errorWithDomain:ThumbnailExtractorErrorDomain code:ThumbnailExtractorErrorCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"exif read error", NSLocalizedDescriptionKey, nil]];
        goto _EXIT;
    }
    
    if (!exifData->data || !exifData->size) {
        err = [NSError errorWithDomain:ThumbnailExtractorErrorDomain code:ThumbnailExtractorErrorCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"the file hasn't embed thumbnail", NSLocalizedDescriptionKey, nil]];
        goto _EXIT;
    }
    
    thumbnail = [UIImage imageWithData:[NSData dataWithBytes:exifData->data length:exifData->size]];
    
_EXIT:
    if (exifData) exif_data_free(exifData);
    if (error) *error = err;
    
    return thumbnail;
}
@end
