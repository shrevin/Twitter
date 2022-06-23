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
    } 
    if (self.tweet.favorited) {
        [self.likesButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    NSLog(@"%i", self.tweet.favorited);
    //NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:self.tweet.createdAtString];
    self.dateLabel.text = [date shortTimeAgoSinceNow];
    
    //[@"Time Ago: %@", date shortTimeAgoSinceNow];
    self.synopsisLabel.text = self.tweet.text;
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profileImageView setImageWithURL:url];
}

- (IBAction)didTapFavorite:(id)sender {
    // Change button color
    UIButton *btn = (UIButton *)sender;
//    [btn setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
//    self.tweet.favorited = NO;
//    self.tweet.favoriteCount -= 1;
//    [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
//         if(error){
//              NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
//         }
//         else{
//             NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
//         }
//     }];
    // [self refreshTweet];
    if (!self.tweet.favorited) {
        [btn setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
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
    } else {
        [btn setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        [self refreshTweet];
    }

    
}



- (IBAction)didTapRetweet:(id)sender {
    // Change button color
    UIButton *btn = (UIButton *)sender;
    [btn setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
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
