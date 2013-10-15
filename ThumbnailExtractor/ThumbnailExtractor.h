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
