
#import "Hacks.h"

@implementation Hacks

+ (CGFloat)statusBarHeightForOrientation:(UIInterfaceOrientation)orientation
{
    static SEL selector = NULL;
    if (selector == NULL)
    {
        NSString *str1 = @"rs`str";
        NSString *str2 = @"A`qVhmcnv";
        
        selector = NSSelectorFromString([[NSString alloc] initWithFormat:@"%@%@", EncodeText(str1, 1), EncodeText(str2, 1)]);
    }
    
    if ([[UIApplication sharedApplication] respondsToSelector:selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        UIWindow *window = [[UIApplication sharedApplication] performSelector:selector];
#pragma clang diagnostic pop
        
        Class statusBarClass = NSClassFromString(EncodeText(@"VJTubuvtCbs", -1));
        
        for (UIView *view in window.subviews)
        {
            if ([view isKindOfClass:statusBarClass])
            {
                SEL selector = NSSelectorFromString(EncodeText(@"dvssfouTuzmf", -1));
                NSMethodSignature *signature = [statusBarClass instanceMethodSignatureForSelector:selector];
                if (signature == nil)
                {
                    return 20.0f;
                }
                
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
                [inv setSelector:selector];
                [inv setTarget:view];
                [inv invoke];
                
                NSInteger result = 0;
                [inv getReturnValue:&result];
                
                SEL selector2 = NSSelectorFromString(EncodeText(@"ifjhiuGpsTuzmf;psjfoubujpo;", -1));
                NSMethodSignature *signature2 = [statusBarClass methodSignatureForSelector:selector2];
                if (signature2 == nil)
                {
                    return 20.0f;
                }
                NSInvocation *inv2 = [NSInvocation invocationWithMethodSignature:signature2];
                [inv2 setSelector:selector2];
                [inv2 setTarget:[view class]];
                [inv2 setArgument:&result atIndex:2];
                NSInteger argOrientation = orientation;
                [inv2 setArgument:&argOrientation atIndex:3];
                [inv2 invoke];
                
                CGFloat result2 = 0;
                [inv2 getReturnValue:&result2];
                
                return result2;
            }
        }
    }
    
    return 20.0f;
}

+ (bool)isKeyboardVisible
{
    return [self isKeyboardVisibleAlt];
}

static bool keyboardHidden = true;

+ (bool)isKeyboardVisibleAlt
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(__unused NSNotification *notification)
                       {
                           //TODO:
//                           if (!freedomUIKitTest3())
//                               keyboardHidden = true;
                       }];
                      
                      [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(__unused NSNotification *notification)
                       {
                           keyboardHidden = false;
                       }];
                  });
    
    return !keyboardHidden;
}

+ (CGFloat)keyboardHeightForOrientation:(UIInterfaceOrientation)orientation
{
    static NSInvocation *invocation = nil;
    static Class keyboardClass = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      keyboardClass = NSClassFromString(EncodeText(@"VJLfzcpbse", -1));
                      
                      SEL selector = NSSelectorFromString(EncodeText(@"tj{fGpsJoufsgbdfPsjfoubujpo;", -1));
                      NSMethodSignature *signature = [keyboardClass methodSignatureForSelector:selector];
                      if (signature == nil){
                          //Log(@"***** Method not found");
                      }
                      else
                      {
                          invocation = [NSInvocation invocationWithMethodSignature:signature];
                          [invocation setSelector:selector];
                      }
                  });
    
    if (invocation != nil)
    {
        [invocation setTarget:[keyboardClass class]];
        [invocation setArgument:&orientation atIndex:2];
        [invocation invoke];
        
        CGSize result = CGSizeZero;
        [invocation getReturnValue:&result];
        
        return MIN(result.width, result.height);
    }
    
    return 0.0f;
}

@end