//
//  ZCPURLCommon.m
//  Apartment
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPURLCommon.h"

// 协议 + host + path
NSString *ZCPMakeURLString(NSString *scheme, NSString *host, NSString *path) {
    scheme = scheme ? scheme : @"http";
    return [NSString stringWithFormat:@"%@://%@%@",scheme, host, path];
}

// 根据Type获取相应的协议
NSString *  schemeForType(NSString *type) {
    NSString * scheme = nil;
    
    if ([type isEqualToString:kURLTypeCommon]) {
        scheme = @"http";
    }
    else if ([type isEqualToString:kSchemeTypeSecurity]) {
    }
    
    return scheme;
}
// 根据Type获取相应的host
NSString *  hostForType(NSString *type) {
    NSString *host = nil;
    if ([type isEqualToString:kURLTypeCommon]) {
//        host = @"127.0.0.1:8888";
        host = @"localhost:8888";
    }
    return host;
}
// 根据key获取相应的path
NSString *  urlForKey(NSString *urlKey) {
    NSString * url  = [ZCPURLCommon sharedInstance].urlMaps[urlKey];
    if (url == nil) {
        @throw [NSException exceptionWithName:@"API_NOT_EXISTS" reason:[NSString stringWithFormat:@"urlKey's url is nil (%@)", urlKey] userInfo:nil];
    }
    return url;
}

// 获取图片
#define URL_IMAGE_PATH(key, imageName)       [NSString stringWithFormat:@"/1.0/Application/Home/Images/%@/%@", key, imageName]
// 获取图片地址
NSString * imageGetURL(NSString * key,NSString * imageName) {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = URL_IMAGE_PATH(key, imageName);
    
    return ZCPMakeURLString(scheme, host, path);
}
// 获取封面图片地址
NSString * coverImageGetURL(NSString * imageName) {
    return imageGetURL(@"Cover", imageName);
}
// 获取头像图片地址
NSString * headImageGetURL(NSString * imageName) {
    return imageGetURL(@"Head", imageName);
}
// 获取广告图片地址
NSString * advertisementGetURL(NSString * imageName) {
    return imageGetURL(@"Advertisement", imageName);
}


@implementation ZCPURLCommon

@synthesize urlMaps = _urlMaps;

IMP_SINGLETON

- (void)initialize {
    TTDPRINT(@"Load: = = = = api map = = = =");
    self.urlMaps = @{
                     FIELD_LIST:                                @"/1.0/common/getField"
                     /* - 登录注册 - */
                     , LOGIN:                                   @"/1.0/user/getUserByAccountPassword"
                     , ACCOUNT_CAN_BE_REGISTER:                 @"/1.0/user/judgeUserAccountCanBeRegistered"
                     , REGISTER:                                @"/1.0/user/registerNewUser"
                     , RESET_PASSWORD:                          @"/1.0/user/resetPassword"
                     /* - 热门动态相关 - */
                     , GET_HOT_BOOKPOST:                        @"/1.0/hottrend/getHotBookpost"
                     , GET_HOT_BOOKPOSTCOMMENT:                 @"/1.0/hottrend/getHotBookpostComment"
                     /* - 观点交流相关 - */
                     , BOOKPOST_LIST_BY_MULTI_CONDITION:        @"/1.0/communion/getBookpostBySearchTextSortMethodFieldID"
                     , BOOKPOST_LIST_BY_USERID:                 @"/1.0/communion/getBookpostByUserID"
                     , BOOKPOST_COLLECTION_LIST_BY_USERID:      @"/1.0/communion/getCollectedBookpostByUserID"
                     , BOOKPOSTCOMMENT_LIST_BY_BOOKPOSTID:      @"/1.0/communion/getBookpostCommentByBookpostID"
                     , BOOKPOSTCOMMENTREPLY_LIST_BY_BOOKPOSTCOMMENTID: @"/1.0/communion/getBookpostCommentReplyByBookpostCommentID"
                     , CHANGE_BOOKPOST_SUPPORT_STATE:           @"/1.0/communion/changeBookpostSupportRecord"
                     , CHANGE_BOOKPOST_COLLECTION_STATE:        @"/1.0/communion/changeBookpostCollectionRecord"
                     , CHANGE_BOOKPOSTCOMMENT_SUPPORT_STATE:    @"/1.0/communion/changeBookpostCommentSupportRecord"
                     , CHANGE_BOOKPOSTCOMMENTREPLY_SUPPORT_STATE: @"/1.0/communion/changeBookpostCommentReplySupportRecord"
                     , ADD_BOOKPOST:                            @"/1.0/communion/addBookpost"
                     , ADD_BOOKPOSTCOMMENT:                     @"/1.0/communion/addBookpostComment"
                     , ADD_BOOKPOSTCOMMENTREPLY:                @"/1.0/communion/addBookpostCommentReply"
                     /* - 文趣活动相关(Couplet) - */
                     , COUPLET_LIST_BY_MULTI_CONDITION:         @"/1.0/activity/getCoupletBySortMethod"
                     , COUPLET_LIST_BY_USERID:                  @"/1.0/activity/getCoupletByUserID"
                     , COUPLET_COLLECTION_LIST_BY_USERID:       @"/1.0/activity/getCollectedCoupletByUserID"
                     , COUPLET_REPLY_LIST:                      @"/1.0/activity/getCoupletReplyByCoupletID"
                     , ADD_COUPLET:                             @"/1.0/activity/addCouplet"
                     , ADD_COUPLET_REPLY:                       @"/1.0/activity/addCoupletReply"
                     , CHANGE_COUPLET_SUPPORT_STATE:            @"/1.0/activity/changeCoupletSupportRecord"
                     , CHANGE_COUPLET_COLLECTION_STATE:         @"/1.0/activity/changeCoupletCollectionRecord"
                     , CHANGE_COUPLET_REPLY_SUPPORT_STATE:      @"/1.0/activity/changeCoupletReplySupportRecord"
                     /* - 文趣活动相关(Thesis) - */
                     , CURRENT_THESIS:                          @"/1.0/activity/getCurrThesis"
                     , THESIS_LIST_BY_USERID:                   @"/1.0/activity/getThesisByUserID"
                     , THESIS_COLLECTION_LIST_BY_USERID:        @"/1.0/activity/getCollectedThesisByUserID"
                     , ARGUMENT_LIST_BY_BELONG:                 @"/1.0/activity/getArgumentByBelong"
                     , ADD_THESIS:                              @"/1.0/activity/addThesis"
                     , ADD_ARGUMENT:                            @"/1.0/activity/addArgument"
                     , CHANGE_THESIS_COLLECTION_STATE:          @"/1.0/activity/changeThesisCollectionRecord"
                     , CHANGE_ARGUMENT_SUPPORT_STATE:           @"/1.0/activity/changeArgumentSupportRecord"
                     /* - 文趣活动相关(Question) - */
                     , QUESTION_LIST:                           @"/1.0/activity/getQuestion"
                     , QUESTION_LIST_BY_USERID:                 @"/1.0/activity/getQuestionByUserID"
                     , QUESTION_COLLECTION_LIST_BY_USERID:      @"/1.0/activity/getCollectedQuestionByUserID"
                     , USER_ANSWER_RECORD:                      @"/1.0/activity/getAnswerRecordByUserID"
                     , SUBMIT_QUESTION_ANSWERS:                 @"/1.0/activity/submitQuestionAnswer"
                     , ADD_QUESTION:                            @"/1.0/activity/addQuestion"
                     , CHANGE_QUESTION_COLLECTION_STATE:        @"/1.0/activity/changeQuestionCollectionRecord"
                     /* - 图书馆相关 - */
                     , BOOK_LIST:                               @"/1.0/library/getBookBySearchTextSortMethodFieldID"
                     , BOOK_LIST_BY_USERID:                     @"/1.0/library/getBookByUserID"
                     , BOOK_COLLECTION_LIST_BY_USERID:          @"/1.0/library/getCollectedBookByUserID"
                     , BOOK_REPLY_LIST:                         @"/1.0/library/getBookReplyByBookID"
                     , ADD_BOOK:                                @"/1.0/library/addBook"
                     , ADD_BOOK_REPLY:                          @"/1.0/library/addBookReply"
                     , CHANGE_BOOK_COLLECTION_STATE:            @"/1.0/library/changeBookCollectionRecord"
                     , CHANGE_BOOK_REPLY_SUPPORT_STATE:         @"/1.0/library/changeBookReplySupportRecord"
                     /* - 个人中心相关 - */
                     , UPLOAD_HEAD:                             @"/1.0/user/uploadUserHead"
                     , MODIFY_USER_INFO:                        @"/1.0/user/modifyUserInfo"
                     , MODIFY_USER_PASSWORD:                    @"/1.0/user/modifyUserPassword"
                     , COLLECTED_USER_LIST:                     @"/1.0/user/getCollectedUserList"
                     , CHANGE_USER_COLLECTION_STATE:            @"/1.0/user/changeUserCollectionRecord"
                     , JUDGE_USER_COLLECT_OTHERUSER:            @"/1.0/user/judgeUserCollectOtherUser"
                     };
}

@end
