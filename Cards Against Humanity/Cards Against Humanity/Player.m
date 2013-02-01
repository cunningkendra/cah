//
//  Player.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize position = _position;
@synthesize name = _name;
@synthesize peerID = _peerID;
@synthesize receivedResponse = _receivedResponse;
@synthesize gamesWon = _gamesWon;

- (void)dealloc
{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ peerID = %@, name = %@, position = %d", [super description], self.peerID, self.name, self.position];
}

@end
