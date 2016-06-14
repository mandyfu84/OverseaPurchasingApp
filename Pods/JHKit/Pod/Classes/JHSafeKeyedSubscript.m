//
//  JHSafeKeyedSubscript.m
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

#import "JHSafeKeyedSubscript.h"

@implementation JHSafeKeyedSubscriptArray
- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _originalData = array;
    }
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx > self.originalData.count - 1) {
        return nil;
    }
    else {
        id object = self.originalData[idx];
        if ([object respondsToSelector:@selector(safe)]) {
            return [object safe];
        }
        else {
            return object;
        }
    }
}

-(NSString *)description
{
    return [_originalData description];
}
@end

@implementation JHSafeKeyedSubscriptMutableArray
- (instancetype)initWithMutableArray:(NSMutableArray *)array
{
    self = [super init];
    if (self) {
        _originalData = array;
    }
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx > self.originalData.count - 1) {
        return nil;
    }
    else {
        id object = self.originalData[idx];
        if ([object respondsToSelector:@selector(safe)]) {
            return [object safe];
        }
        else {
            return object;
        }
    }
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (idx > [self.originalData count] - 1) {
        return;
    }
    if (obj == nil) {
        return;
    }
    else {
        [self.originalData replaceObjectAtIndex:idx withObject:obj];
    }
}

-(NSString *)description
{
    return [_originalData description];
}
@end
@implementation JHSafeKeyedSubscriptDictionary
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _originalData = dict;
    }
    return self;
}

- (id)objectForKeyedSubscript:(id)key
{
    if (![self.originalData objectForKey:key]) {
        return nil;
    }
    else {
        id object = [self.originalData objectForKey:key];
        if ([object respondsToSelector:@selector(safe)]) {
            return [object safe];
        }
        else {
            return object;
        }
    }
}

-(NSString *)description
{
    return [_originalData description];
}
@end
@implementation JHSafeKeyedSubscriptMutableDictionary
- (instancetype)initWithMutableDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        _originalData = dict;
    }
    return self;
}

- (id)objectForKeyedSubscript:(id)key
{
    if (![self.originalData objectForKey:key]) {
        return nil;
    }
    else {
        id object = [self.originalData objectForKey:key];
        if ([object respondsToSelector:@selector(safe)]) {
            return [object safe];
        }
        else {
            return object;
        }
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if (obj == nil) {
        [self.originalData removeObjectForKey:key];
    }
    else {
        [self.originalData setObject:obj forKey:key];
    }
}

-(NSString *)description
{
    return [_originalData description];
}
@end


@implementation NSArray (JHSafeKeyedSubscript)
-(JHSafeKeyedSubscriptArray *)safe
{
    return [[JHSafeKeyedSubscriptArray alloc] initWithArray:self];
}
@end
@implementation NSMutableArray (JHSafeKeyedSubscript)
-(JHSafeKeyedSubscriptMutableArray *)safe
{
    return [[JHSafeKeyedSubscriptMutableArray alloc] initWithMutableArray:self];
}
@end
@implementation NSDictionary (JHSafeKeyedSubscript)
-(JHSafeKeyedSubscriptDictionary *)safe
{
    return [[JHSafeKeyedSubscriptDictionary alloc] initWithDictionary:self];
}
@end
@implementation NSMutableDictionary (JHSafeKeyedSubscript)
-(JHSafeKeyedSubscriptMutableDictionary *)safe
{
    return [[JHSafeKeyedSubscriptMutableDictionary alloc] initWithMutableDictionary:self];
}

@end