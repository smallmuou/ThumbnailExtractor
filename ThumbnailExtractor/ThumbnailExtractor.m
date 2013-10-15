/*!
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 
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
