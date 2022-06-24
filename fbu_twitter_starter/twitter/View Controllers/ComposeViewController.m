//
//  ComposeViewController.m
//  twitter
//
//  Created by Shreya Vinjamuri on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "TimelineViewController.h"


@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *tweetContent;
@property (strong, nonatomic) IBOutlet UILabel *characterCountLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *tweetButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetContent.layer.borderWidth = 0.2f;
    self.tweetContent.clipsToBounds = YES;
    self.tweetContent.layer.cornerRadius = 10.0f;
    self.tweetContent.delegate = self;
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    //int character_limit = 140;

    NSString *newText = [self.tweetContent.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update character count label
    
    self.characterCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)newText.length];
    if (newText.length > 140) {
        self.characterCountLabel.textColor = [UIColor redColor];
        self.tweetButton.enabled = false;
    } else {
        self.characterCountLabel.textColor = [UIColor blackColor];
        self.tweetButton.enabled = true;
    }
    // Should the new text should be allowed? True/False
    return true;


}

- (IBAction)clickTweet:(UIBarButtonItem *)sender {
    NSLog(@"%i", self.isReplyVar);
    if (self.isReplyVar) {
        [[APIManager shared] replyToTweet:self.tweetContent.text tweet:self.myTweet completion:^(Tweet *t, NSError *e) {
            if (self.tweetContent.text) {
                NSLog(self.tweetContent.text);
                [self.delegate didTweet:t];
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
        }];
        self.isReplyVar = NO;
    } else {
        [[APIManager shared] postStatusWithText:self.tweetContent.text completion:^(Tweet *t, NSError *e) {
            if (self.tweetContent.text) {
                NSLog(self.tweetContent.text);
                [self.delegate didTweet:t];
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", e.localizedDescription);
            }
        }];
    }
    // the second parameter you are passing in is a completion block 
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)clickClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    NSLog(@"%i", self.isReplyVar);
    self.isReplyVar = NO;
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
