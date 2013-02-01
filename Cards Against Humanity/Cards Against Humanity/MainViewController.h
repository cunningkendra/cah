//
//  MainViewController.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "GameViewController.h"
#import "HostViewController.h"
#import "JoinViewController.h"

@interface MainViewController : UIViewController <HostViewControllerDelegate, JoinViewControllerDelegate, GameViewControllerDelegate>
{
    BOOL _buttonsEnabled;    
}
@end
