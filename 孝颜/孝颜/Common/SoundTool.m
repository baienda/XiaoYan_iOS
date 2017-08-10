//
//  SoundTool.m
//  Meecha
//
//  Created by 王琮 on 16/9/30.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import "SoundTool.h"

@implementation SoundTool

-(id)initForPlayingVibrate
{
    self = [super init];
        if (self)
        {
            soundID = kSystemSoundID_Vibrate;
        }
    return self;
}


-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{

    self = [super init];
    
    if (self) {
        
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];

        if (path)
        {

            SystemSoundID theSoundID;
  
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
      
             if (error == kAudioServicesNoError)
             {
                soundID = theSoundID;
             }
             else
             {
                NSLog(@"Failed to create sound ");
             }
      
        }

    }
     return self;
}

-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    
   self = [super init];
   
     if (self) {

         NSString *path=[[NSBundle mainBundle] bundlePath];
         NSURL *fileURL=[NSURL fileURLWithPath:[path stringByAppendingPathComponent:filename]];

           if (fileURL != nil)
           {
                SystemSoundID theSoundID;

                OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
                    if (error == kAudioServicesNoError)
                    {
                         soundID = theSoundID;
                    }
                    else
                    {
                       NSLog(@"Failed to create sound ");
                    }

               AudioServicesAddSystemSoundCompletion (theSoundID, NULL, NULL,completionCallback,(__bridge void*) self);
            
               
            }
    
        }

    return self;
}

static void completionCallback (SystemSoundID mySSID, void* myself)
{
    AudioServicesPlaySystemSound(mySSID);
}

- (void)playSound
{
    AudioServicesPlayAlertSound(soundID);
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
