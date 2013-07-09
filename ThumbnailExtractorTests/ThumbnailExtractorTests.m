//
//  ThumbnailExtractorTests.m
//  ThumbnailExtractorTests
//
//  Created by xuwf on 13-6-19.
//  Copyright (c) 2013年 xuwf. All rights reserved.
//

#import "ThumbnailExtractorTests.h"
#import "ThumbnailExtractor.h"

@implementation ThumbnailExtractorTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    {
        NSURL* url = [NSURL fileURLWithPath:@"/Users/luyf/Downloads/test1.jpg"];
        NSError* error;
        UIImage* image = [ThumbnailExtractor thumbnailForURL:url error:&error];
        NSLog(@"image=%@, error=%@", image, error);
        STAssertNotNil(image, @"test error");
    }
    
    if(0)
    {
        NSString* path = @"http://192.168.64.1:81/WiDiSK(C)/DSC_0001.JPG";
        NSURL* url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSError* error;
        UIImage* image = [ThumbnailExtractor thumbnailForURL:url error:&error];
        NSLog(@"image=%@", image);
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:@"/Users/luyf/1.jpg" atomically:NO];
    }
    
}

@end
