//
//  DetailsViewController.m
//  twitter
//
//  Created by Shreya Vinjamuri on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#include "ComposeViewController.h"
#import "DetailsViewController.h"
#import "DateTools.h"


@interface DetailsViewController () 
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *handleLabel;
@property (strong, nonatomic) IBOutlet UILabel *textContent;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UIButton *likesButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshInfo];
    
    
}

- (void) refreshInfo {
    self.textContent.text = self.tweetToDisplay.text;
    self.nameLabel.text = self.tweetToDisplay.user.name;
    self.handleLabel.text = [@"@" stringByAppendingString:self.tweetToDisplay.user.screenName];
    NSString *URLString =  self.tweetToDisplay.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.imageView setImageWithURL:url];
    self.imageView.layer.cornerRadius  = self.imageView.frame.size.width/2;
    self.imageView.layer.masksToBounds = true;
    self.imageView.layer.borderWidth = 0.2;
    if (self.tweetToDisplay.favorited) {
        [self.likesButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    self.retweetsLabel.text = [NSString stringWithFormat:@"%i", self.tweetToDisplay.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%i", self.tweetToDisplay.favoriteCount];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *date = [formatter dateFromString:self.tweetToDisplay.createdAtString];
    self.dateLabel.text = [date shortTimeAgoSinceNow];
}

- (IBAction)tapRetweet:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!self.tweetToDisplay.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        self.tweetToDisplay.retweeted = YES;
        self.tweetToDisplay.retweetCount += 1;
        [self refreshInfo];
        [[APIManager shared] retweet:self.tweetToDisplay completion:^(Tweet* t, NSError* e) {
            if (t) {
                NSLog(@"Successfully retweeted the following Tweet: %@", t.text);
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
            }];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        self.tweetToDisplay.retweeted = NO;
        self.tweetToDisplay.retweetCount -= 1;
        [self refreshInfo];
        [[APIManager shared] unretweet:self.tweetToDisplay completion:^(Tweet* t, NSError* e) {
            if (t) {
                NSLog(@"Successfully retweeted the following Tweet: %@", t.text);
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
            }];
    }
    
    
}

- (IBAction)tapLike:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!self.tweetToDisplay.favorited) {
        [btn setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        self.tweetToDisplay.favorited = YES;
        self.tweetToDisplay.favoriteCount += 1;
        [self refreshInfo];
        [[APIManager shared] favorite:self.tweetToDisplay completion:^(Tweet* t, NSError* e) {
            if (t) {
                NSLog(@"Successfully favorited the following Tweet: %@", t.text);
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
        }];
    } else {
        [btn setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.tweetToDisplay.favorited = NO;
        self.tweetToDisplay.favoriteCount -= 1;
        [self refreshInfo];
        [[APIManager shared] unfavorite:self.tweetToDisplay completion:^(Tweet* t, NSError* e) {
            if (t) {
                NSLog(@"Successfully favorited the following Tweet: %@", t.text);
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
        }];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //TweetCell
    [sender refreshTweet];
}


@end
