//
//  AAConstants.h
//  MatchedUp
//
//  Created by Alexandre ARRIGHI on 24/07/2014.
//  Copyright (c) 2014 Alexandre ARRIGHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAConstants : NSObject

#pragma mark - User Profile

extern NSString *const kCCUserTagLineKey;

extern NSString *const kCCUserProfileKey;
extern NSString *const KCCUserProfileNameKey;
extern NSString *const KCCUserProfileFirstNameKey;
extern NSString *const KCCUserProfileLocationKey;
extern NSString *const KCCUserProfileGenderKey;
extern NSString *const KCCUserProfileBirthdayKey;
extern NSString *const kCCUserProfileInterestedInKey;
extern NSString *const kCCUserProfilePictureURL;
extern NSString *const KCCUserProfileRelationshipStatusKey;
extern NSString *const KCCUserProfileAgeKey;

#pragma mark  - Photo Class

extern NSString *const kCCPhotoClassKey;
extern NSString *const kCCPhotoUserKey;
extern NSString *const kCCPhotoPictureKey;

#pragma mark - Activity Class

extern NSString *const kCCActivityClassKey;
extern NSString *const kCCActivityTypeKey;
extern NSString *const kCCActivityFromUserKey;
extern NSString *const kCCActivityToUserKey;
extern NSString *const kCCActivityPhotoKey;
extern NSString *const kCCactivityTypeLikeKey;
extern NSString *const kCCActivityTypeDislikeKey;

#pragma mark - Settings

extern NSString *const kCCMenEnableKey;
extern NSString *const kCCWomenEnableKey;
extern NSString *const kCCSingleEnableKey;
extern NSString *const kCCAgeMaxKey;

#pragma mark - ChatRoom

extern NSString *const kCCChatRoomClassKey;
extern NSString *const kCCChatRoomUser1Key;
extern NSString *const kCCChatRoomUser2Key;

#pragma mark - Chat

extern NSString *const kCCChatClassKey;
extern NSString *const kCCChatChatroomKey;
extern NSString *const kCCChatFromUserKey;
extern NSString *const kCCChatToUserKey;
extern NSString *const kCCChatTextKey;

@end
