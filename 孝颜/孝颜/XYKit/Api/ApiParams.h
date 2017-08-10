//
//  ApiParams.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiParams : NSObject

@end
@interface PageParams : NSObject
@property (nonatomic) int offset;
@property (nonatomic) int limit;

-(NSDictionary *)buildParams;

@end

@interface AuthParams : NSObject
@property (nonatomic,copy) NSString *country_code;
@property (nonatomic,copy) NSString *cellphone;
@property (nonatomic,copy) NSString *smscode;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *fb_id;
@property (nonatomic,copy) NSString *fb_token;
@property (nonatomic) BOOL retry;
-(NSDictionary *)buildSMSParams;
-(NSDictionary *)buildSigninParams;
-(NSDictionary *)buildFacebookParams;
@end

@interface LocationParams : NSObject
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
-(NSDictionary *)buildParams;
@end

@interface NearbyListParams : PageParams
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic) int distance;
@property (nonatomic) int gender;
@property (nonatomic) int minage;
@property (nonatomic) int maxage;
@property (nonatomic) BOOL random;
-(NSDictionary *)buildParams;
@end

@interface UserParams : NSObject

@end


@interface AvatarParams : NSObject
@property (nonatomic,copy) NSString *photoId;
@property (nonatomic,copy) NSString *filename;
@property (nonatomic) BOOL face;
@property (nonatomic,copy) NSString *action;
@property (nonatomic) int width;
@property (nonatomic) int height;

-(NSDictionary *)buildParams;
@end


@interface CommParams : NSObject
@property (nonatomic) int comm_id;
@property (nonatomic) int photo_id;
@property (nonatomic) int photo_uid;
@property (nonatomic) int moment_id;
@property (nonatomic) int moment_uid;
@property (nonatomic,copy) NSString *content;
@property (nonatomic) int replyid;
-(NSDictionary *)buildParams;
@end


@interface FriendParams : NSObject
@property (nonatomic) int uid;
@property (nonatomic) int cnt;
-(NSDictionary *)buildParams;
@end

@interface PasswordParams : NSObject

@property (nonatomic,copy) NSString* oldPassword;
@property (nonatomic,copy) NSString* nePassword;
@property (nonatomic,copy) NSString* rePassword;

-(NSDictionary *)buildParams;

@end

@interface PhotoParams : NSObject
@property (nonatomic,copy) NSString *filename;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic) int published;
@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic,copy) NSString *address;
@property (assign,nonatomic) int type;

@property (copy, nonatomic) NSString *gid;
@property (copy, nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end


@interface ProfileParams : NSObject
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic) int gender;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *nationality;
@property (nonatomic,copy) NSString *occupation;
@property (nonatomic,copy) NSString *signature;
@property (nonatomic,copy) NSString *interestsMovie;
@property (nonatomic,copy) NSString *interestsSport;
@property (nonatomic,copy) NSString *interestsFood;
@property (nonatomic,copy) NSString *interestsMusic;

@property (nonatomic,copy) NSString *tags;
@property (nonatomic) int bloodtype;
@property (nonatomic,copy) NSString *city;
@property (nonatomic) int relationship;
@property (nonatomic) int chat_permission;
@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;
@property (nonatomic,copy) NSString* time;
-(NSDictionary *)buildParams;
@end
//举报
@interface ReportParams : NSObject
@property (nonatomic) int uid;
@property (nonatomic) int photo_id;
@property (nonatomic) int topicid;
@property (nonatomic) int articleid;
@property (nonatomic) int groupid;
@property (nonatomic,copy) NSString* reason;
-(NSDictionary *)buildParams;
@end

@interface OffsetParams : NSObject
@property (nonatomic) int offset;
-(NSDictionary *)buildParams;
@end

@interface SearchResultParams : NSObject
@property (nonatomic,copy) NSString* q;
-(NSDictionary *)buildParams;
@end

//公开私藏
@interface PublishParams : NSObject
@property (nonatomic) int photo_id;
@property (nonatomic,copy) NSString* publishd;
-(NSDictionary *)buildParams;

@end
//本地联系人信息
@interface ContentParams : NSObject
@property (nonatomic,copy) NSString* content;
-(NSDictionary *)buildParams;
@end

@interface PraiseParams : NSObject
@property (nonatomic) int photo_id;
@property (nonatomic) int photo_uid;
@property (nonatomic) int moment_id;
@property (nonatomic) int moment_uid;
-(NSDictionary *)buildParams;
@end

@interface CommentParams : PageParams
@property (nonatomic) int photo_id;
@property (nonatomic) int photo_uid;
@property (nonatomic) BOOL fromshare;
-(NSDictionary *)buildParams;
@end

@interface CityParams : NSObject
@property (nonatomic) int pid;
-(NSDictionary *)buildParams;
@end

@interface EMParams : NSObject
@property (nonatomic,copy) NSString* data;
-(NSDictionary *)buildParams;
@end

@interface GroupParams : NSObject
@property (nonatomic,copy) NSString* group_members;
@property (nonatomic,copy) NSString* group_id;
@property (nonatomic,copy) NSString* group_name;
-(NSDictionary *)buildParams;
@end

@interface SayHiParams : NSObject
@property (nonatomic) int uid;
@property (nonatomic,copy) NSString *cnt;
@property (nonatomic,copy) NSString *sign;
-(NSDictionary *)buildParams;
@end
//只传uid，有分页
@interface UidParams : PageParams
@property (nonatomic) int uid;
-(NSDictionary *)buildParams;
@end

@interface NoteParams : NSObject
@property (nonatomic) int note_uid;
@property (nonatomic) int note_id;
-(NSDictionary *)buildParams;
@end

@interface MyNoteParams : PageParams
@property (nonatomic) int type;
-(NSDictionary *)buildParams;
@end

@interface ThrowNoteParams : NSObject
@property (nonatomic,copy) NSString* exp_time;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* color;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* url;
@property (nonatomic,copy) NSString* photoId;

-(NSDictionary *)buildParams;
@end


//只传uid，无分页
@interface OnlyUidParams : NSObject
@property (nonatomic) int uid;
-(NSDictionary *)buildParams;
@end

//话题列表
@interface TopicListParams : PageParams
@property (nonatomic) int topic_id;
-(NSDictionary *)buildParams;
@end

//话题列表上方数据
@interface TopicInfoParams : NSObject
@property (nonatomic) int topicid;
-(NSDictionary *)buildParams;
@end

//话题成员列表
@interface TopicUserListParams : PageParams
@property (nonatomic) int topicid;
@property (nonatomic) int groupId;
@property (nonatomic,copy) NSString *search;
-(NSDictionary *)buildParams;
@end
//话题文章
@interface TopicArticleParams : NSObject
@property (nonatomic) int article_id;
-(NSDictionary *)buildParams;
@end
//话题评论列表
@interface ArticleCmtParams : PageParams
@property (nonatomic) int article_id;
-(NSDictionary *)buildParams;
@end
//上传话题评论
@interface UploadArticleParams : NSObject
@property (nonatomic) int topic_article_id;
@property (nonatomic) int topic_article_comment_id;
@property (nonatomic,copy) NSString* comments;
-(NSDictionary *)buildParams;
@end

//群组列表
@interface GroupListParams : NSObject
@property (nonatomic) int offset;
@property (nonatomic) int limit;
@property (nonatomic) int group_type_id;
@property (nonatomic, copy) NSString *search;
-(NSDictionary *)buildParams;
@end

//群组详情
@interface GroupInfoParams : NSObject
@property (nonatomic) int group_id;
@property (copy,nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end

//群组动态
@interface GroupMomentParams : NSObject
@property (nonatomic) int offset;
@property (nonatomic) int limit;
@property (nonatomic) int group_id;
-(NSDictionary *)buildParams;
@end


//加入群组
@interface JoinGroupParams : NSObject
@property (copy ,nonatomic) NSString *group_id;
@property (copy ,nonatomic) NSString *gid;
@property (copy ,nonatomic) NSString *reason;
-(NSDictionary *)buildParams;
@end

//同意加群
@interface auditJoinGroupParams : NSObject
@property (copy ,nonatomic) NSString *groupid;
@property (copy ,nonatomic) NSString *groupuserid;
-(NSDictionary *)buildParams;
@end

//加入群组
@interface CreateGroupParams : NSObject
@property (copy ,nonatomic) NSString *gid;
@property (copy ,nonatomic) NSString *group_type_id;
@property (copy ,nonatomic) NSString *group_notice;
@property (copy ,nonatomic) NSString *group_name;
@property (copy ,nonatomic) NSString *group_intro;
@property (copy ,nonatomic) NSString *access;
@property (copy ,nonatomic) NSString *location_desc;
@property (copy ,nonatomic) NSString *verify_type;
@property (copy ,nonatomic) NSString *cover;
@property (copy ,nonatomic) NSString *icon;
@property (copy ,nonatomic) NSString *lng;
@property (copy ,nonatomic) NSString *lat;
@property (copy ,nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end

//更新群组
@interface UploadGroupParams : NSObject
@property (copy ,nonatomic) NSString *gid;
@property (copy ,nonatomic) NSString *group_type_id;
@property (copy ,nonatomic) NSString *group_notice;
@property (copy ,nonatomic) NSString *group_name;
@property (copy ,nonatomic) NSString *group_intro;
@property (copy ,nonatomic) NSString *access;
@property (copy ,nonatomic) NSString *location_desc;
@property (copy ,nonatomic) NSString *verify_type;
@property (copy ,nonatomic) NSString *cover;
@property (copy ,nonatomic) NSString *icon;
@property (copy ,nonatomic) NSString *lng;
@property (copy ,nonatomic) NSString *lat;
@property (copy ,nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end

//更新群组
@interface invitePeopleParams : NSObject
@property (copy ,nonatomic) NSString *invituid;
@property (copy ,nonatomic) NSString *gid;
@property (copy ,nonatomic) NSString *group_id;
-(NSDictionary *)buildParams;
@end

//我的群组
@interface MyGroupParams : NSObject
@property (copy ,nonatomic) NSString *offset;
@property (copy ,nonatomic) NSString *limit;
-(NSDictionary *)buildParams;
@end

//群组踢人
@interface ExitGroupParams : NSObject
@property (copy ,nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *group_id;
@property (copy ,nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end

//群组类型
@interface GroupTypeParams : NSObject
@property (copy ,nonatomic) NSString *gid;
@property (copy ,nonatomic) NSString *hxgroupid;
-(NSDictionary *)buildParams;
@end

//创建话题
@interface CresteTopicParams : NSObject
@property (copy ,nonatomic) NSString *topic_name;
@property (copy ,nonatomic) NSString *topic_intro;
@property (copy ,nonatomic) NSString *icon;
@property (copy ,nonatomic) NSString *color;
@property (nonatomic) int topicTypeId;
-(NSDictionary *)buildParams;
@end
//创建文章
@interface CresteArticleParams : NSObject
@property (nonatomic) int topic_id;
@property (copy ,nonatomic) NSString *content;
-(NSDictionary *)buildParams;
@end
//更改话题详情
@interface UploadTopicDetailsParams : NSObject
@property (nonatomic) int topicid;
@property (nonatomic,copy) NSString* icon;
@property (nonatomic,copy) NSString *topic_intro;
-(NSDictionary *)buildParams;
@end
//点赞列表
@interface CommentPraiseParams : PageParams
@property (nonatomic) int photo_id;
@property (nonatomic) int photo_uid;
@property (nonatomic) int moment_id;
@property (nonatomic) int moment_uid;

-(NSDictionary *)buildParams;
@end

//忽略未读 通知
@interface NoticeReadParams : NSObject
@property (copy,nonatomic) NSString *all;
@property (copy,nonatomic) NSString *noticeId;
-(NSDictionary *)buildParams;
@end

//删除通知通知
@interface NoticeRemoveParams : NSObject
@property (copy,nonatomic) NSString *all;
@property (copy,nonatomic) NSString *noticeId;
-(NSDictionary *)buildParams;
@end
//删除账号
@interface DeleteAccountParams : NSObject
@property (copy,nonatomic) NSString *password;
@property (nonatomic) int uid;
@property (nonatomic,copy) NSString* choices;
@property (nonatomic,copy) NSString* reason;
-(NSDictionary *)buildParams;
-(NSString *)formatPassword:(NSString *)password;
@end

//隐藏位置
@interface HideLocationParams : NSObject
@property (nonatomic) int hide;
-(NSDictionary *)buildParams;
@end

//设置群组管理员
@interface SetGroupAdminParams : NSObject
@property (nonatomic,copy) NSString *is_admin;
@property (nonatomic) int groupuserid;
@property (nonatomic) int groupid;
-(NSDictionary *)buildParams;
@end

#pragma mark 摇一摇

@interface ShakeSend : NSObject
@property (nonatomic,copy) NSString *timestamp;
-(NSDictionary *)buildParams;
@end

//喜欢
@interface ShakeLike : NSObject
@property (nonatomic) int is_like;
-(NSDictionary *)buildParams;
@end
//设置&取消话题管理者
@interface SetTopicAdmin : NSObject
@property (nonatomic) int topicid;
@property (nonatomic) int uid;
@property (nonatomic) BOOL is_admin;
-(NSDictionary *)buildParams;
@end

//多图动态上传
@interface MultiMoment : NSObject
@property (nonatomic,copy) NSString* filenames;
@property (nonatomic,copy) NSString* contenttype;
@property (nonatomic,copy) NSString* desc;
@property (nonatomic,copy) NSString* address;
@property (nonatomic) int is_private;//是否私有
@property (nonatomic) int gid;//群组id
@property (nonatomic,copy) NSString* hxgroupid;//环信群组id
//分享
@property (nonatomic,copy) NSString* shareid;
@property (nonatomic,copy) NSString* pic;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* sub_title;
//视频
@property (nonatomic, copy) NSString* video_url;
@property (nonatomic, copy) NSString* video_pic;
@property (nonatomic, copy) NSString* video_pic_width;
@property (nonatomic, copy) NSString* video_pic_height;
-(NSDictionary *)buildParams;
@end
//多图动态详情
@interface MultiDetail : PageParams
@property (nonatomic) int moment_uid;
@property (nonatomic) int moment_id;
@property (nonatomic) int photo_id;
@property (nonatomic) int photo_uid;
@property (nonatomic) BOOL fromshare;
-(NSDictionary *)buildParams;
@end
//多图动态列表
@interface MultiList : PageParams
@property (nonatomic) BOOL all;//动态列表传YES，其余传NO
@property (nonatomic) int uid;
@property (nonatomic) BOOL nearby;
@property (nonatomic) int click_uid;
-(NSDictionary *)buildParams;
@end
//多图公开私藏动态
@interface MultiPublish : NSObject
@property (nonatomic) int photo_id;
@property (nonatomic) int moment_id;
@property (nonatomic) int published;
-(NSDictionary *)buildParams;
@end
//多图删除动态
@interface MultiDelete : NSObject
@property (nonatomic) int moment_id;
-(NSDictionary *)buildParams;
@end

//群组动态列表
@interface GroupMultiList : PageParams
@property (nonatomic) int group_id;
-(NSDictionary *)buildParams;
@end

//话题分类详情
@interface TopicCatagoryDetail : PageParams
@property (nonatomic,copy) NSString* type;
-(NSDictionary *)buildParams;
@end
//profile点赞
//群组动态列表
@interface ProfileLike : NSObject
@property (nonatomic) int uid;
@property (nonatomic) BOOL like;
-(NSDictionary *)buildParams;
@end

@interface FriendTalk : NSObject
@property (nonatomic) int set;
-(NSDictionary *)buildParams;
@end

@interface ProfileAddFriend : NSObject
@property (nonatomic) int uid;
@property (nonatomic,copy) NSString *from;
@property (nonatomic,copy) NSString *reason;
-(NSDictionary *)buildParams;
@end

@interface ArticleTop : NSObject
@property (nonatomic) BOOL is_top;
@property (nonatomic) int articleid;
-(NSDictionary *)buildParams;
@end

@interface VideoParams : NSObject
@property (nonatomic,copy) NSString *filename;
-(NSDictionary *)buildParams;
@end
