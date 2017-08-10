//
//  ApiParams.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSString+Array.h"
#import "ApiParams.h"
#import "AppDelegate.h"
#import "UserDefault.h"

@implementation ApiParams

@end
@implementation PageParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.offset) forKey:@"offset"];
    return params;
}
@end

@implementation AuthParams
-(NSString *)formatPassword:(NSString *)password
{
    NSString *mixPassword = [NSString stringWithFormat:@"%@S2JT3g4zM1", password];
    return [NSString md5:mixPassword];
}

-(NSDictionary *)buildSMSParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.country_code forKey:@"country_code"];
    [params setObject:self.cellphone forKey:@"cellphone"];
    if(self.retry){
        [params setObject:@(1) forKey:@"retry"];
    } else {
        [params setObject:@(0) forKey:@"retry"];
    }
    return params;
}
-(NSDictionary *)buildSigninParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.country_code forKey:@"country_code"];
    [params setObject:self.cellphone forKey:@"cellphone"];
    if(self.password != nil){
        [params setObject:[self formatPassword:self.password] forKey:@"password"];
    }
    if(self.smscode != nil){
        [params setObject:self.smscode forKey:@"smscode"];
    }
    return params;
}
-(NSDictionary *)buildFacebookParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.fb_id forKey:@"fb_id"];
    [params setObject:self.fb_token forKey:@"fb_token"];
    return params;
}
@end

@implementation LocationParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.longitude forKey:@"lng"];
    [params setObject:self.latitude forKey:@"lat"];
    return params;
}
@end

@implementation CommParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.photo_id) forKey:@"photo_id"];
    [params setObject:@(self.photo_uid) forKey:@"photo_uid"];
    [params setObject:@(self.moment_id) forKey:@"moment_id"];
    [params setObject:@(self.moment_uid) forKey:@"moment_uid"];
    [params setObject:self.content forKey:@"content"];
    if (self.replyid >0) {
        [params setObject:@(self.replyid) forKey:@"replyid"];
    }
    return params;
}
@end

@implementation FriendParams

-(NSString *)getSign
{
    NSString *imei = [AppDelegateInstance getUUid];
    NSString *u = [UserConfig getTokenU];
    NSString *s = [UserConfig getTokenS];
    return [NSString md5:[NSString stringWithFormat:@"%@%@%@%d", imei, u, s, self.cnt]];
}
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.uid) forKey:@"uid"];
    if(self.cnt > 0){
        [params setObject:@(self.cnt) forKey:@"cnt"];
        [params setObject:[self getSign] forKey:@"sign"];
    }
    
    return params;
}
@end

@implementation PasswordParams

-(NSString *)formatPassword:(NSString *)password
{
    NSString *mixPassword = [NSString stringWithFormat:@"%@S2JT3g4zM1", password];
    return [NSString md5:mixPassword];
}
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.oldPassword.length > 0) {
        NSString* oldPassword = [self formatPassword:self.oldPassword];
        [params setObject:oldPassword forKey:@"old_password"];
    }
    if (self.nePassword.length > 0) {
        NSString* nePassword = [self formatPassword:self.nePassword];
        [params setObject:nePassword forKey:@"new_password"];
    }
    if (self.rePassword.length > 0) {
        NSString* rePassword = [self formatPassword:self.rePassword];
        [params setObject:rePassword forKey:@"re_password"];
    }
    return params;
}
@end

@implementation NearbyListParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.longitude forKey:@"lng"];
    [params setObject:self.latitude forKey:@"lat"];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:@(self.limit) forKey:@"limit"];
    if(self.distance > 0){
        [params setObject:@(self.distance) forKey:@"dis"];
    }
    if(self.gender > 0){
        [params setObject:@(self.gender) forKey:@"gender"];
    }
    if(self.minage > 0){
        [params setObject:@(self.minage) forKey:@"minage"];
    }
    if(self.maxage > 0 && self.maxage < 60){
        [params setObject:@(self.maxage) forKey:@"maxage"];
    }
    if(self.random){
        [params setObject:@"1" forKey:@"random"];
    }
    return params;
}
@end

@implementation AvatarParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.action forKey:@"action"];
    [params setObject:self.face ? @"1" : @"0" forKey:@"faced"];
    if(self.width > 0){
        [params setObject:@(self.width) forKey:@"width"];
    }
    if(self.height > 0){
        [params setObject:@(self.height) forKey:@"height"];
    }
    if (self.filename != nil) {
        [params setObject:self.filename forKey:@"filename"];
    }
    if (self.photoId != nil) {
        [params setObject:self.photoId forKey:@"id"];
    }
    
    return params;
}
@end

@implementation PhotoParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.filename != nil) {
        [params setObject:self.filename forKey:@"filename"];
    }
    if(self.desc != nil){
        [params setObject:self.desc forKey:@"description"];
    }
    if(self.address != nil){
        [params setObject:self.address forKey:@"address"];
    }
    
    NSString *published = @"0";
    if (self.published == 1) {
        published = @"1";
    }
    [params setObject:published forKey:@"published"];
    if(self.width > 0){
        [params setObject:@(self.width) forKey:@"width"];
    }
    if(self.height > 0){
        [params setObject:@(self.height) forKey:@"height"];
    }
    if (self.type > 0) {
        [params setObject:@(self.type) forKey:@"type"];
    }
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"gid"];
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    return params;
}
@end
@implementation ProfileParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.nickname != nil) {
        [params setObject:self.nickname forKey:@"nickname"];
    }
    if(self.gender > 0){
        [params setObject:@(self.gender) forKey:@"gender"];
    }
    if (self.birthday != nil) {
        [params setObject:self.birthday forKey:@"birthday"];
    }
    if (self.nationality != nil) {
        [params setObject:self.nationality forKey:@"pid"];
    }
    if (self.occupation != nil) {
        [params setObject:self.occupation forKey:@"occupation"];
    }
    if (self.signature != nil) {
        [params setObject:self.signature forKey:@"signature"];
    }
    if (self.interestsFood != nil) {
        [params setObject:@"food" forKey:@"interest_key"];
        [params setObject:self.interestsFood forKey:@"interest_val"];
    }
    if (self.interestsMovie != nil) {
        [params setObject:@"movie" forKey:@"interest_key"];
        [params setObject:self.interestsMovie forKey:@"interest_val"];
    }
    if (self.interestsMusic != nil) {
        [params setObject:@"music" forKey:@"interest_key"];
        [params setObject:self.interestsMusic forKey:@"interest_val"];
    }
    if (self.interestsSport != nil) {
        [params setObject:@"sport" forKey:@"interest_key"];
        [params setObject:self.interestsSport forKey:@"interest_val"];
    }
    
    if (self.tags != nil) {
        [params setObject:self.tags forKey:@"tags"];
    }
    if (self.bloodtype > 0) {
        [params setObject:@(self.bloodtype) forKey:@"bloodtype"];
    }
    if (self.city != nil) {
        [params setObject:self.city forKey:@"city"];
    }
    if (self.relationship > 0) {
        [params setObject:@(self.relationship) forKey:@"relationship"];
    }
    if (self.chat_permission > 0) {
        [params setObject:@(self.chat_permission) forKey:@"chat_permission"];
    }
    if (self.width != nil) {
        [params setObject:self.width forKey:@"weight"];
    }
    if (self.height != nil) {
        [params setObject:self.height forKey:@"height"];
    }
    if (self.time != nil) {
        [params setObject:self.time forKey:@"time"];
    }
    return params;
}
@end

@implementation ReportParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.uid > 0) {
        [params setObject:@(self.uid) forKey:@"id"];
        [params setObject:@"uid" forKey:@"key"];
        
    }
    if (self.photo_id > 0) {
        [params setObject:@(self.uid) forKey:@"id"];
        [params setObject:@"uid" forKey:@"key"];
    }
    if (self.topicid > 0) {
        [params setObject:@(self.topicid) forKey:@"id"];
        [params setObject:@"topicid" forKey:@"key"];
    }
    if (self.articleid > 0) {
        [params setObject:@(self.articleid) forKey:@"id"];
        [params setObject:@"articleid" forKey:@"key"];
    }
    if (self.groupid > 0) {
        [params setObject:@(self.groupid) forKey:@"id"];
        [params setObject:@"groupid" forKey:@"key"];
    }
    if (self.reason !=nil) {
        [params setObject:self.reason forKey:@"reason"];
    }
    return params;
}
@end
@implementation OffsetParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:@(30) forKey:@"limit"];
    return params;
}
@end

@implementation SearchResultParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.q != nil) {
        [params setObject:self.q forKey:@"q"];
    }
    return params;
}
@end

@implementation PublishParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.photo_id >0) {
        [params setObject:@(self.photo_id) forKey:@"id"];
    }
    if (self.publishd != nil) {
        [params setObject:self.publishd forKey:@"published"];
    }
    return params;
}
@end
@implementation ContentParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.content !=nil) {
        [params setObject:self.content forKey:@"contacts"];
    }
    return params;
}
@end
@implementation PraiseParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.photo_id > 0) {
        [params setObject:@(self.photo_id) forKey:@"photo_id"];
    }
    if (self.photo_uid > 0) {
        [params setObject:@(self.photo_uid) forKey:@"photo_uid"];
    }
    if (self.moment_id > 0) {
        [params setObject:@(self.moment_id) forKey:@"moment_id"];
    }
    if (self.moment_uid > 0) {
        [params setObject:@(self.moment_uid) forKey:@"moment_uid"];
    }
    return params;
}
@end

@implementation CommentParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.offset) forKey:@"offset"];
    
    if (self.limit > 0) {
        [params setObject:@(self.limit) forKey:@"limit"];
    }
    if (self.photo_id > 0) {
        [params setObject:@(self.photo_id) forKey:@"photo_id"];
    }
    if (self.photo_uid > 0) {
        [params setObject:@(self.photo_uid) forKey:@"photo_uid"];
    }
    [params setObject:@(self.fromshare) forKey:@"fromshare"];
    
    return params;
}
@end

@implementation CityParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.pid) forKey:@"pid"];
    return params;
}
@end

@implementation EMParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.data forKey:@"data"];
    return params;
}
@end

@implementation GroupParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.group_members) {
        [params setObject:self.group_members forKey:@"group_members"];
    }
    if (self.group_id != nil) {
        [params setObject:self.group_id forKey:@"group_id"];
    }
    if (self.group_name != nil) {
        [params setObject:self.group_name forKey:@"group_name"];
    }
    return params;
}
@end
@implementation SayHiParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.uid) forKey:@"uid"];
    [params setObject:self.cnt forKey:@"cnt"];
    [params setObject:self.sign forKey:@"sign"];
    return params;
}
@end

@implementation UidParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    [params setObject:@(self.uid) forKey:@"uid"];
    return params;
}
@end
@implementation NoteParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.note_id > 0) {
        [params setObject:@(self.note_id) forKey:@"note_id"];
    }
    if (self.note_uid >0) {
        [params setObject:@(self.note_uid) forKey:@"note_uid"];
    }
    return params;
}
@end
@implementation MyNoteParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    [params setObject:@(self.type) forKey:@"type"];
    return params;
}
@end
@implementation ThrowNoteParams

-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.content != nil) {
        [params setObject:self.content forKey:@"content"];
    }
    if (self.exp_time != nil) {
        [params setObject:self.exp_time forKey:@"exp_time"];
    }
    if (self.address != nil) {
        [params setObject:self.address forKey:@"address"];
    }
    if (self.color != nil) {
        [params setObject:self.color forKey:@"color"];
    }
    if (self.url != nil) {
        [params setObject:self.url forKey:@"pic_name"];
    }
    if (self.photoId != nil) {
        [params setObject:self.photoId forKey:@"photolib_id"];
    }
    return params;
}
@end

@implementation OnlyUidParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.uid) forKey:@"uid"];
    return params;
}
@end

//话题列表
@implementation TopicListParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.topic_id) forKey:@"topic_id"];
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    return params;
}
@end

@implementation TopicInfoParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.topicid) forKey:@"topicid"];
    return params;
}
@end
@implementation TopicUserListParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.groupId > 0) {
        [params setObject:@(self.groupId) forKey:@"group_id"];
    }
    if (self.topicid > 0) {
        [params setObject:@(self.topicid) forKey:@"topicid"];
    }
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    if (self.search.length >0) {
        [params setObject:self.search forKey:@"search"];
    }
    return params;
}
@end
@implementation UploadArticleParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.topic_article_id > 0) {
        [params setObject:@(self.topic_article_id) forKey:@"topic_article_id"];
    }
    if (self.topic_article_comment_id > 0) {
        [params setObject:@(self.topic_article_comment_id) forKey:@"topic_article_comment_id"];
    }
    if (self.comments > 0) {
        [params setObject:self.comments forKey:@"comments"];
    }
    return params;
}
@end

//群组列表
@implementation GroupListParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    if (self.limit > 0) {
        [params setObject:@(self.limit) forKey:@"limit"];
    }
    if (self.group_type_id != 0) {
        [params setObject:@(self.group_type_id) forKey:@"group_type_id"];
    }
    if (self.search.length > 0) {
        [params setObject:self.search forKey:@"search"];
    }
    return params;
}
@end
@implementation TopicArticleParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.article_id) forKey:@"article_id"];
    
    return params;
}
@end
@implementation ArticleCmtParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.article_id) forKey:@"article_id"];
    if (self.offset > 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    return params;
}
@end

//群组详情
@implementation GroupInfoParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.group_id != 0) {
        [params setObject:@(self.group_id) forKey:@"group_id"];
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    return params;
}
@end


//群组动态
@implementation GroupMomentParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.group_id != 0) {
        [params setObject:@(self.group_id) forKey:@"group_id"];
    }
    if (self.limit != 0) {
        [params setObject:@(self.limit) forKey:@"limit"];
    }
    if (self.offset != 0) {
        [params setObject:@(self.offset) forKey:@"offset"];
    }
    return params;
}
@end

//加入群组
@implementation JoinGroupParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.group_id.length > 0) {
        [params setObject:self.group_id forKey:@"group_id"];
    }
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"gid"];
    }
    if (self.reason.length > 0) {
        [params setObject:self.reason forKey:@"reason"];
    }
    return params;
}
@end

//创建群组
@implementation CreateGroupParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"gid"];
    }
    if (self.group_type_id.length > 0) {
        [params setObject:self.group_type_id forKey:@"group_type_id"];
    }
    if (self.group_notice.length > 0) {
        [params setObject:self.group_notice forKey:@"group_notice"];
    }
    if (self.group_name.length > 0) {
        [params setObject:self.group_name forKey:@"group_name"];
    }
    if (self.group_intro.length > 0) {
        [params setObject:self.group_intro forKey:@"group_intro"];
    }
    if (self.access.length > 0) {
        [params setObject:self.access forKey:@"access"];
    }
    if (self.location_desc.length > 0) {
        [params setObject:self.location_desc forKey:@"location_desc"];
    }
    if (self.verify_type.length > 0) {
        [params setObject:self.verify_type forKey:@"verify_type"];
    }
    if (self.cover.length > 0) {
        [params setObject:self.cover forKey:@"cover"];
    }
    if (self.icon.length > 0) {
        [params setObject:self.icon forKey:@"icon"];
    }
    if (self.lng.length > 0) {
        [params setObject:self.lng forKey:@"lng"];
    }
    if (self.lat.length > 0) {
        [params setObject:self.lat forKey:@"lat"];
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    return params;
}
@end


//创建群组
@implementation UploadGroupParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"id"];
    }
    if (self.group_type_id.length > 0) {
        [params setObject:self.group_type_id forKey:@"group_type_id"];
    }
    if (self.group_notice.length > 0) {
        [params setObject:self.group_notice forKey:@"group_notice"];
    }
    if (self.group_name.length > 0) {
        [params setObject:self.group_name forKey:@"group_name"];
    }
    if (self.group_intro.length > 0) {
        [params setObject:self.group_intro forKey:@"group_intro"];
    }
    if (self.access.length > 0) {
        [params setObject:self.access forKey:@"access"];
    }
    if (self.location_desc.length > 0) {
        [params setObject:self.location_desc forKey:@"location_desc"];
    }
    if (self.verify_type.length > 0) {
        [params setObject:self.verify_type forKey:@"verify_type"];
    }
    if (self.cover.length > 0) {
        [params setObject:self.cover forKey:@"cover"];
    }
    if (self.icon.length > 0) {
        [params setObject:self.icon forKey:@"icon"];
    }
    if (self.lng.length > 0) {
        [params setObject:self.lng forKey:@"lng"];
    }
    if (self.lat.length > 0) {
        [params setObject:self.lat forKey:@"lat"];
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    return params;
}
@end


//邀请进群
@implementation invitePeopleParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"id"];
    }
    if (self.invituid.length > 0) {
        [params setObject:self.invituid forKey:@"invituid"];
    }
    if (self.group_id.length > 0) {
        [params setObject:self.group_id forKey:@"group_id"];
    }
    return params;
}
@end

//同意加群
@implementation auditJoinGroupParams
-(NSDictionary *)buildParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.groupid.length > 0) {
        [params setObject:self.groupid forKey:@"groupid"];
    }
    if (self.groupuserid.length > 0) {
        [params setObject:self.groupuserid forKey:@"groupuserid"];
    }
    
    return params;
}
@end

//我的群组
@implementation MyGroupParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.offset.length > 0) {
        [params setObject:self.offset forKey:@"offset"];
    }
    if (self.limit > 0) {
        [params setObject:self.limit forKey:@"limit"];
    }
    
    return params;
}
@end

//群组踢人
@implementation ExitGroupParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.uid.length > 0) {
        [params setObject:self.uid forKey:@"uid"];
    }
    if (self.group_id.length > 0) {
        [params setObject:self.group_id forKey:@"id"];//群id
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"group_id"];//环信id
    }
    
    return params;
}
@end


//群组类型
@implementation GroupTypeParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.gid.length > 0) {
        [params setObject:self.gid forKey:@"gid"];
    }
    if (self.hxgroupid.length > 0) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    
    return params;
}
@end


@implementation CresteTopicParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.topic_name != nil) {
        [params setObject:self.topic_name forKey:@"topic_name"];
    }
    if (self.topic_intro != nil) {
        [params setObject:self.topic_intro forKey:@"topic_intro"];
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"#FF7EC4",@"#FFCC32",@"#494951",@"#FF9690",@"5FE0A8",@"#6493FF",@"#B98FFF",@"#9263FF",@"#52D9D5",@"#E68A63",@"#FF5287",nil];
    self.color = [array objectAtIndex:arc4random()%11];
    
    if (self.color != nil) {
        [params setObject:self.color forKey:@"color"];
    }
    if (self.icon != nil) {
        [params setObject:self.icon forKey:@"icon"];
    }
    if (self.topicTypeId > 0) {
        [params setObject:@(self.topicTypeId) forKey:@"typeid"];
    }
    return params;
}
@end
@implementation CresteArticleParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.topic_id > 0) {
        [params setObject:@(self.topic_id) forKey:@"topic_id"];
    }
    if (self.content != nil) {
        [params setObject:self.content forKey:@"content"];
    }
    return params;
}
@end
@implementation UploadTopicDetailsParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.topicid > 0) {
        [params setObject:@(self.topicid) forKey:@"topicid"];
    }
    if (self.icon!= nil) {
        [params setObject:self.icon forKey:@"icon"];
    }
    if (self.topic_intro != nil) {
        [params setObject:self.topic_intro forKey:@"topic_intro"];
    }
    return params;
}
@end
@implementation CommentPraiseParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.photo_id > 0) {
        [params setObject:@(self.photo_id) forKey:@"photo_id"];
    }
    if (self.photo_uid > 0) {
        [params setObject:@(self.photo_uid) forKey:@"photo_uid"];
    }
    if (self.moment_id > 0) {
        [params setObject:@(self.moment_id) forKey:@"moment_id"];
    }
    if (self.moment_uid > 0) {
        [params setObject:@(self.moment_uid) forKey:@"moment_uid"];
    }
    if (self.offset >0) {
        [params setObject:@(self.offset) forKey:@"topic_intro"];
    }
    return params;
}

@end

@implementation NoticeReadParams
-(NSDictionary *)buildParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.all.length > 0) {
        [params setObject:self.all forKey:@"all"];
    }
    if (self.noticeId.length > 0) {
        [params setObject:self.noticeId forKey:@"id"];
    }
    return params;
}
@end


@implementation NoticeRemoveParams
-(NSDictionary *)buildParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.all.length > 0) {
        [params setObject:self.all forKey:@"all"];
    }
    if (self.noticeId.length > 0) {
        [params setObject:self.noticeId forKey:@"id"];
    }
    return params;
}
@end
@implementation DeleteAccountParams

-(NSString *)formatPassword:(NSString *)password
{
    NSString *mixPassword = [NSString stringWithFormat:@"%@S2JT3g4zM1", password];
    return [NSString md5:mixPassword];
}
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.uid > 0) {
        [params setObject:@(self.uid) forKey:@"uid"];
    }
    if (self.password != nil) {
        if ([self.password isEqualToString:@""]) {
            [params setObject:@"" forKey:@"password"];
        }else {
            NSString* password = [self formatPassword:self.password];
            [params setObject:password forKey:@"password"];
        }
    }
    if (self.choices != nil) {
        [params setObject:self.choices forKey:@"choices"];
    }
    if (self.reason != nil) {
        [params setObject:self.reason forKey:@"reason"];
    }
    return params;
}
@end
@implementation HideLocationParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.hide) forKey:@"hide"];
    
    return params;
}
@end

//设置群组管理员
@implementation SetGroupAdminParams
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.is_admin.length > 0) {
        [params setObject:self.is_admin forKey:@"is_admin"];
    }
    [params setObject:@(self.groupid) forKey:@"groupid"];
    [params setObject:@(self.groupuserid) forKey:@"groupuserid"];
    
    return params;
}
@end

#pragma mark 摇一摇

@implementation ShakeSend

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.timestamp.length > 0) {
        [params setObject:self.timestamp forKey:@"timestamp"];
    }
    return params;
}

@end

//喜欢
@implementation ShakeLike

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.is_like) forKey:@"is_like"];
    
    return params;
}
@end
@implementation SetTopicAdmin

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.is_admin) forKey:@"is_admin"];
    if (self.topicid > 0) {
        [params setObject:@(self.topicid) forKey:@"topicid"];
    }
    if (self.uid > 0) {
        [params setObject:@(self.uid) forKey:@"uid"];
    }
    return params;
}
@end

@implementation MultiMoment

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.desc forKey:@"description"];
    [params setObject:self.contenttype forKey:@"contenttype"];
    if (self.filenames) {
        [params setObject:self.filenames forKey:@"filenames"];
    }
    [params setObject:@(self.is_private) forKey:@"is_private"];
    if (self.gid > 0) {
        [params setObject:@(self.gid) forKey:@"gid"];
    }
    if (self.hxgroupid) {
        [params setObject:self.hxgroupid forKey:@"hxgroupid"];
    }
    if (self.address) {
        [params setObject:self.address forKey:@"address"];
    }
    if (self.shareid) {
        [params setObject:self.shareid forKey:@"shareid"];
    }
    if (self.pic) {
        [params setObject:self.pic forKey:@"pic"];
    }
    if (self.title) {
        [params setObject:self.title forKey:@"title"];
    }
    if (self.sub_title) {
        [params setObject:self.sub_title forKey:@"sub_title"];
    }
    if (self.video_url != nil) {
        [params setObject:self.video_url forKey:@"video_url"];
    }
    if (self.video_pic != nil) {
        [params setObject:self.video_pic forKey:@"video_pic"];
    }
    if (self.video_pic_width != nil) {
        [params setObject:self.video_pic_width forKey:@"video_pic_width"];
    }
    if (self.video_pic_height != nil) {
        [params setObject:self.video_pic_height forKey:@"video_pic_height"];
    }
    return params;
}
@end
@implementation MultiDetail

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.offset) forKey:@"offset"];
    
    if (self.limit > 0) {
        [params setObject:@(self.limit) forKey:@"limit"];
    }
    if (self.moment_id > 0) {
        [params setObject:@(self.moment_id) forKey:@"moment_id"];
    }
    if (self.moment_uid > 0) {
        [params setObject:@(self.moment_uid) forKey:@"moment_uid"];
    }
    if (self.photo_id > 0) {
        [params setObject:@(self.photo_id) forKey:@"photo_id"];
    }
    if (self.photo_uid > 0) {
        [params setObject:@(self.photo_uid) forKey:@"photo_uid"];
    }
    [params setObject:@(self.fromshare) forKey:@"fromshare"];
    return params;
}
@end
//多图动态列表
@implementation MultiList

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.offset) forKey:@"offset"];
    
    if (self.limit > 0) {
        [params setObject:@(self.limit) forKey:@"limit"];
    }
    [params setObject:@(self.all) forKey:@"all"];
    if (self.uid > 0) {
        [params setObject:@(self.uid) forKey:@"uid"];
    }
    [params setObject:@(self.nearby) forKey:@"nearby"];
    if (self.click_uid > 0) {
        [params setObject:@(self.click_uid) forKey:@"click_uid"];
    }
    return params;
}
@end
@implementation MultiPublish

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.photo_id > 0) {
        [params setObject:@(self.photo_id) forKey:@"photo_id"];
    }
    if (self.moment_id > 0) {
        [params setObject:@(self.moment_id) forKey:@"moment_id"];
    }
    [params setObject:@(self.published) forKey:@"published"];
    
    return params;
}
@end
@implementation MultiDelete

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.moment_id > 0) {
        [params setObject:@(self.moment_id) forKey:@"moment_id"];
    }
    return params;
}
@end

//群组动态列表
@implementation GroupMultiList

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.group_id > 0) {
        [params setObject:@(self.group_id) forKey:@"group_id"];
    }
    return params;
}
@end
@implementation TopicCatagoryDetail

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.type) {
        [params setObject:self.type forKey:@"type"];
    }
    [params setObject:@(self.limit) forKey:@"limit"];
    [params setObject:@(self.offset) forKey:@"offset"];
    return params;
}
@end
@implementation ProfileLike

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.uid > 0) {
        [params setObject:@(self.uid) forKey:@"uid"];
    }
    [params setObject:@(self.like) forKey:@"like"];
    return params;
}

@end

@implementation FriendTalk
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.set) forKey:@"set"];
    
    return params;
}
@end

@implementation ProfileAddFriend
-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.uid) forKey:@"uid"];
    
    if (self.from.length > 0) {
        [params setObject:self.from forKey:@"from"];
    }
    if (self.reason != nil) {
        [params setObject:self.reason forKey:@"reason"];
    }
    return params;
}
@end

@implementation ArticleTop

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@(self.is_top) forKey:@"is_top"];
    
    if (self.articleid > 0) {
        [params setObject:@(self.articleid) forKey:@"articleid"];
    }
    return params;
}
@end

@implementation VideoParams

-(NSDictionary *)buildParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.filename != nil) {
        [params setObject:self.filename forKey:@"filename"];
    }
    return params;
}

@end
