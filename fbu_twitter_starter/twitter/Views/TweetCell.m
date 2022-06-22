//
//  TweetCell.m
//  twitter
//
//  Created by Shreya Vinjamuri on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.retweetsButton.titleLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.heartsButton.titleLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    //self.repliesButton.titleLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.nameLabel.text = self.tweet.user.name;
    self.twitterHandleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.synopsisLabel.text = self.tweet.text;
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImageView setImageWithURL:url];
}

@end
