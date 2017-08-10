//
//  FileTool.m
//  Meecha
//
//  Created by 王琮 on 16/8/3.
//  Copyright © 2016年 Chatcat. All rights reserved.
//



#import "FileTool.h"

@implementation FileTool

+ (void)setCookie
{
//    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:kUserDefaultsCookies]];
    
    if (cookies) {
//        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
//        NSLog(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
//    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    for (NSHTTPCookie *cookie in cookiesA) {
//        NSLog(@"setCookie: %@", cookie);
//    }
//    NSLog(@"\n");
}


+ (NSArray *)getEmotionEngPath
{
    NSString *tag = @"Smile|Lovely|Daze|Terrify|Laugh|Angry|Shrunken|Trick|Tears|Oops|Pooh-pooh|Love|Disappointed|Sob|Yawn|Tongue|Grin|Shhh|Rich|Quarrel|Surprise|Curious|Surrender|Strike|Hit|Enjoy|Provoke|Afraid|Sleep|Sweat|Toasted|Shocked|Pig|Dizzy|Bye|Poop|Cake|Goodnight|Son|ThumbsUp|ThumbsDown|Shake|Stop|Cheers|Heart|Heartbreak|Alarm|Dagger|Bomb|Coffee";
    NSArray *temp = [tag componentsSeparatedByString:@"|"];
    NSMutableArray *array = [NSMutableArray array];
    
//    NSString *newTag;
    for (NSString *str in temp) {
//        newTag = [NSString stringWithFormat:@"[%@]",str];
        [array addObject:str];
    }
    
    return array;
}
+ (NSArray *)getEmotionChsPath
{
    NSString *tag = @"微笑|可爱|发呆|吃惊|大笑|发怒|委屈|坏笑|想哭|囧|鄙视|喜欢|失望|大哭|困|吐舌头|呲牙|嘘|炫富|吵架|惊讶|好奇|投降|打死你|害羞|享受|挑衅|怕怕|睡觉|流汗|衰|疑问|猪头|晕|拜拜|大便|蛋糕|晚安|太阳|强|弱|握手|停止|干杯|爱心|心碎|闹钟|匕首|炸弹|咖啡";
    
    NSArray *temp = [tag componentsSeparatedByString:@"|"];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *str in temp) {
        [array addObject:str];
    }
    
    return array;
}

+ (NSArray *)getEmotionTaiPath
{
    NSString *tag = @"ยิ้ม|น่ารัก|หน้าบึ้ง|ตกใจ|หัวเราะ|โกรธสุด|ข้องใจ|กลโกง|อยากร้องไห้|ลำบากใจ|ดูถูก|ชอบ|ผิดหวัง|ร้องไห้|ง่วงนอน|ขยิบตา|ยิ้มกว้าง|จุ๊ๆ|อวดรวย|ด่า|ประหลาดใจ|น่าสนใจ|ยอมแพ้|ค้อนทุบ|อาย|เพลินใจ|เร้าใจ|กลัว|นอน|เหงื่อตก|ชั่วร้าย|สับสน|หมู|เวียนหัว|บายๆ|อุจจาระ|เค้ก|นอนหลับฝันดี|พระอาทิตย์|ยอดเยี่ยม|ยอดแย่|จับมือ|หยุด|โชโย|หัวใจ|ใจสลาย|นาฬิกาปลุก|ดาบ|ระเบิด|กาแฟ";
    NSArray *temp = [tag componentsSeparatedByString:@"|"];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *str in temp) {
        [array addObject:str];
    }
    
    return array;
}

- (NSString *)showLocalEmotionWords:(NSString *)str
{
    //新建可变字符串
    NSMutableString *maStr = str.mutableCopy;
    
    NSDictionary *emotionDict = [[NSUserDefaults standardUserDefaults]objectForKey:kUserDefaultsEmotionLocalDictKey];
    
    NSString *language = [[NSUserDefaults standardUserDefaults]objectForKey:kUserDefaultsLanguage];
    
    NSString *emotionPattern = @"\\[[-0-9a-zA-Z\\u4e00-\\u9fa5\\u0e00-\\u0e7f]+\\]";
    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    NSArray *results = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    NSInteger loc = 0;
    if (results.count > 0) {
        
        for (int i = 0; i < results.count; i ++) {
            NSTextCheckingResult *result = results[i];

            //添加之前的
//            [maStr appendString:self.emotionWords];
            
            NSString *temp = [[str substringWithRange:result.range] substringFromIndex:1];
            NSString *emotionKey = [temp substringToIndex:temp.length-1];
            NSDictionary *tempDict;
            if ([language isEqualToString:@"en"]) {
                tempDict = emotionDict[@"en"];
            }
            else if([language isEqualToString:@"th"])
            {
                tempDict = emotionDict[@"th"];
            }
            else
            {
                tempDict = emotionDict[@"zh-Hans"];
            }
            NSString *emotion = [NSString stringWithFormat:@"[%@]",tempDict[emotionKey]];
            
            if (tempDict[emotionKey]) {
                [maStr replaceCharactersInRange:NSMakeRange(loc, result.range.length) withString:emotion];
                loc = emotion.length + loc;
                self.emotionWords = maStr;
            }
            else
            {
                self.emotionWords = str;
            }
            
            NSLog(@"%@",maStr);
        }

    }
    else
    {
        self.emotionWords = str;
    }
    return  self.emotionWords;
}

+ (NSDictionary *)countryCode
{
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                               @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    
    return dictCodes;
}

@end
