//
//  AAChatViewController.h
//  MatchedUp
//
//  Created by Alexandre ARRIGHI on 25/07/2014.
//  Copyright (c) 2014 Alexandre ARRIGHI. All rights reserved.
//


#import "JSQMessages.h"
#import "JSQMessagesViewController.h"

@class AAChatViewController;

@protocol AAChatViewControllerDelegate <NSObject>

- (void)didDismissAAChatViewController:(AAChatViewController *)vc;

@end

@interface AAChatViewController : JSQMessagesViewController <JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id <AAChatViewControllerDelegate> delegate;

@property (strong, nonatomic) PFObject *chatRoom;

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;

@end
