//
//  JHDegradingAction.h
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

// you can define customized degrading timing function by yourself
void dispatch_async_repeated(dispatch_time_t firstPopTime, dispatch_time_t(^timingFunction)(dispatch_time_t lastFiringTime), dispatch_queue_t queue, void(^work)(BOOL *shouldStop));

// simple degrading timing function power by 2
void dispatch_async_repeated_degrading(dispatch_queue_t queue, void(^work)(BOOL *shouldStop), NSTimeInterval maxWaitingInterval);

