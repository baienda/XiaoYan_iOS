
#import "Common.h"
//#import "UIImageView+XHURLDownload.h"

int iosMajorVersion()
{
    static bool initialized = false;
    static int version = 7;
    if (!initialized)
    {
        switch ([[[UIDevice currentDevice] systemVersion] intValue])
        {
            case 4:
                version = 4;
                break;
            case 5:
                version = 5;
                break;
            case 6:
                version = 6;
                break;
            case 7:
                version = 7;
                break;
            case 8:
                version = 8;
                break;
            case 9:
                version = 9;
                break;
            case 10:
                version = 10;
                break;
            default:
                version = 8;
                break;
        }
        
        initialized = true;
    }
    return version;
}

NSString *Localized(NSString *s)
{
    static NSString *untranslatedString = nil;
    
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^
                  {
                      untranslatedString = [[NSString alloc] initWithFormat:@"UNTRANSLATED_%x", (int)arc4random()];
                  });
    
    static NSBundle *localizationBundle = nil;
    static NSBundle *fallbackBundle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      fallbackBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
                      
                      NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
                      
                      if (![[[NSBundle mainBundle] localizations] containsObject:language])
                      {
                          localizationBundle = fallbackBundle;
                          
                          if ([language rangeOfString:@"-"].location != NSNotFound)
                          {
                              NSString *languageWithoutRegion = [language substringToIndex:[language rangeOfString:@"-"].location];
                              
                              for (NSString *localization in [[NSBundle mainBundle] localizations])
                              {
                                  if ([languageWithoutRegion isEqualToString:localization])
                                  {
                                      NSBundle *candidateBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:localization ofType:@"lproj"]];
                                      if (candidateBundle != nil)
                                          localizationBundle = candidateBundle;
                                      
                                      break;
                                  }
                              }
                          }
                      }
                      else
                          localizationBundle = [NSBundle mainBundle];
                  });
    
    NSString *string = [localizationBundle localizedStringForKey:s value:untranslatedString table:nil];
    if (string != nil && ![string isEqualToString:untranslatedString])
        return string;
    
    if (localizationBundle != fallbackBundle)
    {
        NSString *string = [fallbackBundle localizedStringForKey:s value:untranslatedString table:nil];
        if (string != nil && ![string isEqualToString:untranslatedString])
            return string;
    }
    
    return s;
}

CGSize ScreenSize()
{
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      UIScreen *screen = [UIScreen mainScreen];
                      
                      if ([screen respondsToSelector:@selector(fixedCoordinateSpace)])
                          size = [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace].size;
                      else
                          size = screen.bounds.size;
                  });
    
    return size;
}

NSString *EncodeText(NSString *string, int key)
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (int i = 0; i < (int)[string length]; i++)
    {
        unichar c = [string characterAtIndex:i];
        c += key;
        [result appendString:[NSString stringWithCharacters:&c length:1]];
    }
    
    return result;
}

@implementation NSString(CCString)

- (BOOL)isPureInt:(NSString*)string{
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString*)string{
        NSScanner* scan = [NSScanner scannerWithString:string];
        float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (int)intValue2
{
        if(![self isPureInt:self])
            {
                    return 0;
                }
    
    return [self intValue];
}

@end

@implementation NSNumber(CCNumber)

- (int)intValue2
{
        return [self intValue];
    }

@end



@implementation UIImageView (CCWebImage)

//- (void)setWithURL:(NSString *)imageURL placeholder:(UIImage *)placeholder completion:(CCWebImageBlock)block
//{
//    NSURL *url;
//    if([imageURL hasPrefix:@"/"]){
//        url = [NSURL fileURLWithPath:imageURL];
//    } else {
//        url = [NSURL returnUrlFormUTF8String:imageURL];
//    }
//    if(url){
//        /**
//        [self loadWithURL:url placeholer:placeholder showActivityIndicatorView:NO completionBlock:^(UIImage *image, NSURL *url, NSError *error) {
//            if(block != nil){
//                block(image, error);
//            }
//        }];
//        ***/
//        [self setImageWithURL:url placeholder:placeholder options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//            if(block != nil){
//                block(image, error);
//            }
//        }];
//    }
//}
//
//- (void)setAvatarWithURL:(nullable NSString *)imageURL
//{
//    [self setAvatarWithURL:imageURL completion:nil];
//}
//
//- (void)setAvatarWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    [self setWithURL:imageURL placeholder:[UIImage imageNamed:@"icon_moren"] completion:block];
//}
//
//- (void)setGroupWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    [self setWithURL:imageURL placeholder:[UIImage imageNamed:@"chat_icon_group"] completion:block];
//}
//
//- (void)setThumbnailWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    [self setWithURL:imageURL placeholder:[UIImage imageWithColor:UIColorRGB(0xEEEEEE)] completion:block];
//}
//
//- (void)setNoPlaceholderWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    [self setWithURL:imageURL placeholder:nil completion:block];
//}
//
//- (void)setMomentWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    
//    __weak UIImageView *wself = self;
//    [self setWithURL:imageURL placeholder:[UIImage imageWithColor:kColorRGBSame(238)] completion:^(UIImage *image, NSError *error) {
//        if (!wself) return;
//        if(error != nil){
//            wself.image = [UIImage imageNamed: @"icon_moren"];
//        }
//        if(block != nil){
//            block(image, error);
//        }
//    }];
//}
//- (void)setShakeWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block
//{
//    [self setClipsToBounds:YES];
//    [self setContentMode:UIViewContentModeScaleAspectFill];
//    __weak UIImageView *wself = self;
//    [self setWithURL:imageURL placeholder:[UIImage imageNamed:@"shake_quesheng"] completion:^(UIImage *image, NSError *error) {
//        if (!wself) return;
//        if(error != nil){
//            wself.image = [UIImage imageNamed: @"icon_moren"];
//        }
//        if(block != nil){
//            block(image, error);
//        }
//    }];
//}
@end


