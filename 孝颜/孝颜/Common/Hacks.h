
#import <UIKit/UIKit.h>


@interface Hacks : NSObject

+ (CGFloat)statusBarHeightForOrientation:(UIInterfaceOrientation)orientation;

+ (CGFloat)keyboardHeightForOrientation:(UIInterfaceOrientation)orientation;

+ (bool)isKeyboardVisible;

@end