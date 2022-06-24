//
//  ComposeViewController.m
//  twitter
//
//  Created by Shreya Vinjamuri on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *tweetContent;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetContent.layer.borderWidth = 0.5f;
    
    
}
- (IBAction)clickTweet:(UIBarButtonItem *)sender {
    [[APIManager shared] postStatusWithText:self.tweetContent.text completion:^(Tweet *t, NSError *e) {
        if (self.tweetContent.text) {
            NSLog(self.tweetContent.text);
            [self.delegate didTweet:t];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
        }
    }];
    // the second parameter you are passing in is a completion block 
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)clickClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
