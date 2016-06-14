//
//  JHLanguage.m
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
#import "JHLanguage.h"

@implementation JHLanguage

static NSBundle *bundle = nil;

+(void)initialize 
{
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	NSArray* languages = [defs objectForKey:@"AppleLanguages"];
	NSString *current = [languages objectAtIndex:0];
	[self setLanguage:current];	
}

+(void)setLanguage:(NSString *)language
{
	NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]; // Set default to en
    }
	bundle = [NSBundle bundleWithPath:path];
	[[NSNotificationCenter defaultCenter] postNotificationName:JHLanguageDidChangeNotification object:nil];
}

+(NSString *)localizeForKey:(NSString *)key
{
    if (![bundle isLoaded]) {
        [bundle load];
    }
	return [bundle localizedStringForKey:key value:nil table:nil];
}


@end