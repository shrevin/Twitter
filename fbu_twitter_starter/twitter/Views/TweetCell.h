//
//  TweetCell.h
//  twitter
//
//  Created by Shreya Vinjamuri on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetsButton;
@property (strong, nonatomic) IBOutlet UIButton *repliesButton;
@property (strong, nonatomic) IBOutlet UIButton *heartsButton;
@property (strong, nonatomic) Tweet* tweet;
@end

NS_ASSUME_NONNULL_END
