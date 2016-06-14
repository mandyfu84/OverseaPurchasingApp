//
//  JHCacheData.m
//
// This code is distributed under the terms and conditions of the MIT license.
// Copyright (c) 2015 John Hsu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <CommonCrypto/CommonCrypto.h>
#import "JHCacheData.h"
static NSOperationQueue *downloadQueue;
static NSMutableArray *downloadingURLArray;

@implementation JHCacheData
+(NSString*)md5:(NSData *)data
{
    const char *cStr = [data bytes];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)[data length], digest );
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

+(void)cachedDataFromURL:(NSURL *)url cacheDataHitCompleteBlock:(void(^)(NSData *cacheData))cacheDataBlock continuesDownloadIfCacheHit:(BOOL)continues fetchNewCompleteBlock:(void(^)(NSData *newData))newDataBlock
{
    if (!downloadingURLArray) {
        downloadingURLArray = [[NSMutableArray alloc] init];
    }
    if (!downloadQueue) {
        downloadQueue = [[NSOperationQueue alloc] init];
        downloadQueue.maxConcurrentOperationCount = 1;
    }
    if (!url) {
        return;
    }
    NSString *urlMd5String = [JHCacheData md5:[[url absoluteString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // create cache path in not exist
    NSString *cachePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"JHCacheData"];
    BOOL isDir = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir];
    if (!isExist || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:urlMd5String];
    __block NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
    
    if ([cacheData length]) {
        // return cached data if possible
        cacheDataBlock(cacheData);
        if (!continues) {
            return;
        }
    }
    else {
        cacheDataBlock(nil);
    }
    
    
    if ([downloadingURLArray indexOfObject:urlMd5String] >= [downloadingURLArray count]) {
        // mark as downloading, prevent duplicated download
        [downloadingURLArray addObject:urlMd5String];
        [downloadQueue addOperationWithBlock:^{
            
            NSData *downloadedData = [NSData dataWithContentsOfURL:url];
            if (downloadedData) {
                [downloadedData writeToFile:cacheFilePath atomically:YES];
                cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [downloadingURLArray removeObject:urlMd5String];
                newDataBlock(cacheData);
                
            });
        }];
    }
    else {
        // already downloading, queue after current download complete and read from cache directly
        [downloadQueue addOperationWithBlock:^{
            NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                newDataBlock(cacheData);
            });
        }];
    }
}
@end
