//
//  TweetCell.m
//  twitter
//
//  Created by Shreya Vinjamuri on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"

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
    //NSLog(@"%@", tweet.start);
//    let year = Date().year;
//    NSLog(year);
    [self refreshTweet];
}

- (void)refreshTweet {
    //NSLog(@"Time Ago: %@", timeAgoDate.timeAgoSinceNow);
    self.retweetsLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    //self.repliesButton.titleLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.nameLabel.text = self.tweet.user.name;
    self.twitterHandleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    if (self.tweet.start == nil) {
        self.tweet.start = [NSDate date];
    } else {
        NSLog(@"WE GOT A START TIME WHOOOOOO");
    }
    //NSDate *previous = self.start;
//    NSLog(@"Time Ago: %@",self.now);
    self.dateLabel.text = [self.tweet.start shortTimeAgoSinceNow];
    //[@"Time Ago: %@", date shortTimeAgoSinceNow];
    self.synopsisLabel.text = self.tweet.text;
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImageView setImageWithURL:url];
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    [self refreshTweet];
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}


- (IBAction)didTapLike:(id)sender {
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    [self refreshTweet];
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
    
}

- (IBAction)didTapReply:(id)sender {
}
@end
