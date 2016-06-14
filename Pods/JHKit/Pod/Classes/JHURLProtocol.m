//
//  JHURLProtocol.m
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

#import "JHURLProtocol.h"

@implementation JHURLProtocol
static NSMutableArray *observeArray = nil;

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)stopLoading
{

}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    NSString *scheme = [[request URL] scheme];
    if (observeArray && [[observeArray valueForKey:@"scheme"] containsObject:scheme]) {
        return YES;
    }
    return NO;
}

-(void)startLoading
{
    NSString *scheme = [[self.request URL] scheme];
    NSData *data = nil;
    for (NSDictionary *dict in observeArray) {
        if ([dict[@"scheme"] isEqualToString:scheme]) {
            NSData *(^block)(NSURL *url) = dict[@"block"];
            if (block) {
                data = block([self.request URL]);
            }
        }
    }
    if (data) {
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                            MIMEType:@"application/octet-stream"
                                               expectedContentLength:data.length
                                                    textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else {
        data = [@"JHURLProtocol" dataUsingEncoding:NSUTF8StringEncoding];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                            MIMEType:@"text/plain"
                                               expectedContentLength:data.length
                                                    textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
  
}

+(NSString *)addObserverForScheme:(NSString *)scheme withActionBlock:(NSData *(^)(NSURL *url))block
{
    if (!observeArray) {
        observeArray = [NSMutableArray array];
    }
    NSString *uuidString = [[[NSUUID alloc] init] UUIDString];
    [observeArray addObject:@{@"uuid" : uuidString,
                              @"scheme" : scheme,
                              @"block" : [block copy]
                              }];
    return uuidString;
}

+(void)removeObserverForUUID:(NSString *)uuidString
{
    for (NSDictionary *dict in [observeArray copy]) {
        if ([dict[@"uuid"] isEqualToString:uuidString]) {
            [observeArray removeObject:dict];
        }
    }
}

+(NSArray *)observingArray
{
    return observeArray;
}

+(NSData *)invokeURL:(NSURL *)url
{
    NSString *scheme = [url scheme];
    NSData *data = nil;
    for (NSDictionary *dict in observeArray) {
        if ([dict[@"scheme"] isEqualToString:scheme]) {
            NSData *(^block)(NSURL *url) = dict[@"block"];
            if (block) {
                data = block(url);
            }
        }
    }
    return data;
}

@end
