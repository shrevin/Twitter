//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
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

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfTweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property BOOL isReply;
@end


@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTimeline];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // initializing a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.isReply = NO;
    // Get timeline_refreshControl
    
}

- (void) fetchTimeline {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *t in tweets) {
                NSString *text = t.text;
                NSLog(@"%@", text);
            }
            //self.arrayOfTweets = tweets;
            self.arrayOfTweets = [NSMutableArray arrayWithArray:tweets]; // [Tweet tweetsWithArray:tweets];
            [self.tableView reloadData];
            // hiding the refresh control
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTweetCell"];
    cell.tweet = self.arrayOfTweets[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
    [self.presentedViewController dismissViewControllerAnimated:true completion:nil];
    [self fetchTimeline];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"details"]) {
        TweetCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        DetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.tweetToDisplay = self.arrayOfTweets[indexPath.row];
    } else if ([segue.identifier  isEqual: @"reply"]) {
        self.isReply = YES;
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.isReplyVar = YES;
        UIView *contentView = (UIView *)[(UIView *)sender superview];
        TweetCell *cell = (TweetCell *)[contentView superview];
//        TweetCell *cell = sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        composeController.myTweet = cell.tweet;
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        NSLog(@"COMPOSEEEE");
    }

}



- (IBAction)didTapLogout:(id)sender {
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}
@end
