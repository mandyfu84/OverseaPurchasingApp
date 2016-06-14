//
//  JHCacheData.h
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

#import <Foundation/Foundation.h>

@interface JHCacheData : NSObject
/**
 *  Calculates MD5 value for NSData
 *
 *  @param data input data to calculate
 *
 *  @return md5 value
 */
+(NSString*)md5:(NSData *)data;

/**
 *  Cache data machanism with stop control if cache hits
 *
 *  @param url            url of data source
 *  @param cacheDataBlock block to call when cache hits
 *  @param continues      proceed download even cache hits
 *  @param newDataBlock   block to call when new data downloaded
 */
+(void)cachedDataFromURL:(NSURL *)url cacheDataHitCompleteBlock:(void(^)(NSData *cacheData))cacheDataBlock continuesDownloadIfCacheHit:(BOOL)continues fetchNewCompleteBlock:(void(^)(NSData *newData))newDataBlock;

@end
