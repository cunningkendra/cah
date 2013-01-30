//
//  JoinViewController.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "MatchmakingClient.h"

@class JoinViewController;

@protocol JoinViewControllerDelegate <NSObject>

- (void)joinViewControllerDidCancel:(JoinViewController *)controller;

@end

@interface JoinViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MatchmakingClientDelegate>

@property (nonatomic, weak) id <JoinViewControllerDelegate> delegate;

@end
