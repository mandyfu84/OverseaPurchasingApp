//
//  JHSystemPaths.m
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


NSString* criticalDataPath()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

NSString* cacheDataPath()
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"];
}

NSString* tempDataPath()
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

NSString* offlineDataPath()
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Private Documents"];
}

// last update: 2012 Aug 16
// reference http://developer.apple.com/library/ios/#qa/qa1719/_index.html
// reference was in 2012-04-23 version
BOOL addSkipBackupAttributeToItemAtURL(NSURL *URL)
{
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

void createDirectoryIfNotExist(NSString *dirPath)
{
    BOOL isDir = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isDir || !isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}