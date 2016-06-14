//
//  OtherKit.h
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


#ifndef Pods_OtherKit_h
#define Pods_OtherKit_h
// UIColor+HTMLAdditions.h
// NSString+URLEncoding.h

/**
 *  Setup audio session prevent other app's music (music player) stop by movie player
 *
 *  @return no return value
 */
static inline void JHSetupMixModeForAudioSession()
{
    if ([[[UIDevice currentDevice] systemVersion] intValue] >= 7) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive: NO error: nil];
        [audioSession setCategory:AVAudioSessionCategoryPlayback
                      withOptions:AVAudioSessionCategoryOptionMixWithOthers
                            error:nil];
        [audioSession setActive: YES error: nil];
    }
    else {
        AudioSessionInitialize(NULL, NULL, NULL, NULL);
        UInt32 sessionCategory = kAudioSessionCategory_AmbientSound;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 allowMixWithOthers = true;
        AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(allowMixWithOthers), &allowMixWithOthers);
        AudioSessionSetActive(true);
    }
}
#endif
