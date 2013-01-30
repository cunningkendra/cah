//
//  HostViewController.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "MatchmakingServer.h"

@class HostViewController;

@protocol HostViewControllerDelegate <NSObject>

- (void)hostViewControllerDidCancel:(HostViewController *)controller;

@end

@interface HostViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <HostViewControllerDelegate> delegate;

@end
