//
//  ComposeViewController.h
//  twitter
//
//  Created by Shreya Vinjamuri on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate <NSObject>
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;
@end


NS_ASSUME_NONNULL_END
