//
//  AAConstants.m
//  MatchedUp
//
//  Created by Alexandre ARRIGHI on 24/07/2014.
//  Copyright (c) 2014 Alexandre ARRIGHI. All rights reserved.
//

#import "AAConstants.h"

@implementation AAConstants

#pragma mark - User Class

NSString *const kCCUserTagLineKey                   = @"tagLine";

NSString *const kCCUserProfileKey                   = @"profile";
NSString *const KCCUserProfileNameKey               = @"name";
NSString *const KCCUserProfileFirstNameKey          = @"firstName";
NSString *const KCCUserProfileLocationKey           = @"location";
NSString *const KCCUserProfileGenderKey             = @"gender";
NSString *const KCCUserProfileBirthdayKey           = @"birthday";
NSString *const kCCUserProfileInterestedInKey       = @"interestedIn";
NSString *const kCCUserProfilePictureURL            = @"pictureURL";
NSString *const KCCUserProfileRelationshipStatusKey = @"relationshipStatus";
NSString *const KCCUserProfileAgeKey                = @"age";


#pragma mark - Photo Class

NSString *const kCCPhotoClassKey    = @"Photo";
NSString *const kCCPhotoUserKey     = @"user";
NSString *const kCCPhotoPictureKey  = @"image";

#pragma mark - Activity Class

NSString *const kCCActivityClassKey         = @"Activity";
NSString *const kCCActivityTypeKey          = @"type";
NSString *const kCCActivityFromUserKey      = @"fromUser";
NSString *const kCCActivityToUserKey        = @"toUser";
NSString *const kCCActivityPhotoKey         = @"photo";
NSString *const kCCactivityTypeLikeKey      = @"like";
NSString *const kCCActivityTypeDislikeKey   = @"dislike";

#pragma mark - Settings

NSString *const kCCMenEnableKey    = @"men";
NSString *const kCCWomenEnableKey  = @"women";
NSString *const kCCSingleEnableKey = @"single";
NSString *const kCCAgeMaxKey       = @"ageMax";

#pragma mark - ChatRoom

NSString *const kCCChatRoomClassKey             = @"ChatRoom";
NSString *const kCCChatRoomUser1Key             = @"user1";
NSString *const kCCChatRoomUser2Key             = @"user2";

#pragma mark - Chat

NSString *const kCCChatClassKey                 = @"Chat";
NSString *const kCCChatChatroomKey              = @"chatroom";
NSString *const kCCChatFromUserKey              = @"fromUser";
NSString *const kCCChatToUserKey                = @"toUser";
NSString *const kCCChatTextKey                  = @"text";

@end
