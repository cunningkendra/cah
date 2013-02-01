
#import "Game.h"
#import "MainViewController.h"
#import "UIButton+CardsAdditions.h"
#import "UIFont+CardsAdditions.h"

@interface MainViewController ()

@property (nonatomic, weak) IBOutlet UILabel *logo;

@property (nonatomic, weak) IBOutlet UIButton *hostGameButton;
@property (nonatomic, weak) IBOutlet UIButton *joinGameButton;
@property (nonatomic, weak) IBOutlet UIButton *singlePlayerGameButton;
@end

@implementation MainViewController
{
    BOOL _performAnimations;
}

@synthesize logo = _logo;

@synthesize hostGameButton = _hostGameButton;
@synthesize joinGameButton = _joinGameButton;
@synthesize singlePlayerGameButton = _singlePlayerGameButton;

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    self.logo.font = [UIFont cardsFontWithSize:30.0f];
    
	[self.hostGameButton applyCardsStyle];
	[self.joinGameButton applyCardsStyle];
	[self.singlePlayerGameButton applyCardsStyle];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	if (_performAnimations)
		[self prepareForIntroAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
	if (_performAnimations)
		[self performIntroAnimation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		_performAnimations = YES;
	}
	return self;
}

- (IBAction)hostGameAction:(id)sender
{
	if (_buttonsEnabled)
	{
		[self performExitAnimationWithCompletionBlock:^(BOOL finished)
         {
             HostViewController *controller = [[HostViewController alloc] initWithNibName:@"HostViewController" bundle:nil];
             controller.delegate = self;
             
             [self presentViewController:controller animated:NO completion:nil];
         }];
	}
}

- (IBAction)joinGameAction:(id)sender
{
	if (_buttonsEnabled)
	{
		[self performExitAnimationWithCompletionBlock:^(BOOL finished)
         {
             JoinViewController *controller = [[JoinViewController alloc] initWithNibName:@"JoinViewController" bundle:nil];
             controller.delegate = self;
             
             [self presentViewController:controller animated:NO completion:nil];
         }];
	}
}

- (IBAction)singlePlayerGameAction:(id)sender
{
}

- (void)prepareForIntroAnimation
{
    self.logo.alpha = 0.0f;
    self.hostGameButton.alpha = 0.0f;
	self.joinGameButton.alpha = 0.0f;
	self.singlePlayerGameButton.alpha = 0.0f;
    
	_buttonsEnabled = NO;
}

- (void)performIntroAnimation
{  
    [UIView animateWithDuration:0.5f
                          delay:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.logo.alpha = 1.0f;
         self.hostGameButton.alpha = 1.0f;
         self.joinGameButton.alpha = 1.0f;
         self.singlePlayerGameButton.alpha = 1.0f;
     }
                     completion:^(BOOL finished)
     {
         _buttonsEnabled = YES;
     }];
}

- (void)performExitAnimationWithCompletionBlock:(void (^)(BOOL))block
{
	_buttonsEnabled = NO;
    
	[UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {

     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0f
                               delay:0.0f
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {

          }
                          completion:block];
         
         [UIView animateWithDuration:0.3f
                               delay:0.3f
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              self.logo.alpha = 0.0f;
              self.hostGameButton.alpha = 0.0f;
              self.joinGameButton.alpha = 0.0f;
              self.singlePlayerGameButton.alpha = 0.0f;
          }
                          completion:nil];
     }];

}

#pragma mark - GameViewControllerDelegate

- (void)gameViewController:(GameViewController *)controller didQuitWithReason:(QuitReason)reason
{
	[self dismissViewControllerAnimated:NO completion:^
     {
         if (reason == QuitReasonConnectionDropped)
         {
             [self showDisconnectedAlert];
         }
     }];
}

#pragma mark - HostViewControllerDelegate

- (void)hostViewControllerDidCancel:(HostViewController *)controller
{
	[self dismissViewControllerAnimated:NO completion:nil];
}

- (void)hostViewController:(HostViewController *)controller didEndSessionWithReason:(QuitReason)reason
{
	if (reason == QuitReasonNoNetwork)
	{
		[self showNoNetworkAlert];
	}
}

- (void)hostViewController:(HostViewController *)controller startGameWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients
{
	_performAnimations = NO;
    
	[self dismissViewControllerAnimated:NO completion:^
     {
         _performAnimations = YES;
         
         [self startGameWithBlock:^(Game *game)
          {
              [game startServerGameWithSession:session playerName:name clients:clients];
          }];
     }];
}

#pragma mark - JoinViewControllerDelegate

- (void)joinViewControllerDidCancel:(JoinViewController *)controller
{
	[self dismissViewControllerAnimated:NO completion:nil];
}

- (void)joinViewController:(JoinViewController *)controller startGameWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID
{
	_performAnimations = NO;
    
	[self dismissViewControllerAnimated:NO completion:^
     {
         _performAnimations = YES;
         
         [self startGameWithBlock:^(Game *game)
          {
              [game startClientGameWithSession:session playerName:name server:peerID];
          }];
     }];
}

- (void)joinViewController:(JoinViewController *)controller didDisconnectWithReason:(QuitReason)reason
{
	if (reason == QuitReasonNoNetwork)
	{
		[self showNoNetworkAlert];
	}
	else if (reason == QuitReasonConnectionDropped)
	{
		[self dismissViewControllerAnimated:NO completion:^
         {
             [self showDisconnectedAlert];
         }];
	}
}

- (void)showDisconnectedAlert
{
	UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Disconnected", @"Client disconnected alert title")
                              message:NSLocalizedString(@"You were disconnected from the game.", @"Client disconnected alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
	[alertView show];
}

- (void)showNoNetworkAlert
{
	UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"No Network", @"No network alert title")
                              message:NSLocalizedString(@"To use multiplayer, please enable Bluetooth or Wi-Fi in your device's Settings.", @"No network alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
	[alertView show];
}

- (void)startGameWithBlock:(void (^)(Game *))block
{
	GameViewController *gameViewController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	gameViewController.delegate = self;
    
	[self presentViewController:gameViewController animated:NO completion:^
     {
         Game *game = [[Game alloc] init];
         gameViewController.game = game;
         game.delegate = gameViewController;
         block(game);
     }];
}

- (void)dealloc
{
    #ifdef DEBUG
	NSLog(@"dealloc %@", self);
    #endif
}

@end
