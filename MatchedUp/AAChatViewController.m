//
//  AAChatViewController.m
//  MatchedUp
//
//  Created by Alexandre ARRIGHI on 25/07/2014.
//  Copyright (c) 2014 Alexandre ARRIGHI. All rights reserved.
//

#import "AAChatViewController.h"

@interface AAChatViewController ()

@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSTimer *chatTimer;
@property (nonatomic) BOOL initialLoadComplete;

@property (strong, nonatomic) NSMutableArray *chats;



@end

@implementation AAChatViewController

#pragma mark - Initialisation des tableaux

-(NSMutableArray *)chats
{
    if (!_chats){
        _chats = [[NSMutableArray alloc]init];
    }
    return  _chats;
}

#pragma mark - Initialisation des vues

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.chatRoom);

    self.inputToolbar.contentView.textView.placeHolder = @"Entres un nouveau message !";
    
    self.currentUser = [PFUser currentUser];
    PFUser *testUser1 = self.chatRoom[kCCChatRoomUser1Key];
    
    if ([testUser1.objectId isEqual:self.currentUser.objectId]){
        self.withUser = self.chatRoom[kCCChatRoomUser2Key];
    }else {
        self.withUser = self.chatRoom[kCCChatRoomUser1Key];
    }
    self.title = self.withUser[kCCUserProfileKey][KCCUserProfileFirstNameKey];
    self.initialLoadComplete = NO;
    self.sender = [PFUser currentUser].objectId;
    
    [self checkForNewChats];
    
    self.chatTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(checkForNewChats) userInfo:nil repeats:YES];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.chatTimer invalidate];
    self.chatTimer = nil;
}



#pragma mark - Send Button

-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text sender:(NSString *)sender date:(NSDate *)date
{
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    
    sender = [PFUser currentUser].objectId;
    
    if (text.length !=0){
        PFObject *chat = [PFObject objectWithClassName:kCCChatClassKey];
        [chat setObject:self.chatRoom forKey:kCCChatChatroomKey];
        [chat setObject:self.currentUser forKey:kCCChatFromUserKey];
        [chat setObject:self.withUser forKey:kCCChatToUserKey];
        [chat setObject:text forKey:kCCChatTextKey];
        [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.chats addObject:message];
            [JSQSystemSoundPlayer jsq_playMessageSentSound];
            [self scrollToBottomAnimated:YES];
            
            NSLog(@"%@", self.chats);
            [self finishSendingMessage];
        }];
        
    }
    
}


#pragma mark - check new chats

-(void)checkForNewChats
{
    int oldChatCount = [self.chats count];
    NSLog(@"nombre de chat : %i", oldChatCount);
    
    PFQuery *queryForChats = [PFQuery queryWithClassName:kCCChatClassKey];
    [queryForChats whereKey:kCCChatChatroomKey equalTo:self.chatRoom];
    [queryForChats orderByAscending:@"createdAt"];
    [queryForChats findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count] > 0)
        {
            if (self.initialLoadComplete == NO || oldChatCount != [objects count]){
                for (PFObject *msg in objects) {
                    NSString *msgSender = [msg[kCCChatFromUserKey]objectId];
                    NSDate *date = msg.createdAt;
                    
                    JSQMessage *message = [[JSQMessage alloc] initWithText:msg[kCCChatTextKey] sender:msgSender date:date];
                    [self.chats addObject:message];
                    NSLog(@"chat refresh with initialLoad equal NO");
                }
                
                self.initialLoadComplete = YES;
                self.showTypingIndicator = YES;
                [self finishReceivingMessage];
                NSLog(@"chat refreshed");
            }
        }
    }];
    NSLog(@"chat refreshed with nothing");
}

#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.chats objectAtIndex:indexPath.item];
}

-(UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.chats objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    else {
        return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image highlightedImage:self.incomingBubbleImageView.highlightedImage];
        
    }
}

-(UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.chats objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.chats objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.sender isEqualToString:self.sender]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.chats objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:message.sender]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.sender];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.chats count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.textView.textColor = [UIColor blackColor];
    
    return cell;
    
}


@end
