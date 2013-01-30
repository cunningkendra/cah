//
//  MatchmakingClient.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "MatchmakingClient.h"

@implementation MatchmakingClient
{
	NSMutableArray *_availableServers;
}

@synthesize session = _session;

@synthesize delegate = _delegate;

- (void)startSearchingForServersWithSessionID:(NSString *)sessionID
{
	_availableServers = [NSMutableArray arrayWithCapacity:10];
    
	_session = [[GKSession alloc] initWithSessionID:sessionID displayName:nil sessionMode:GKSessionModeClient];
	_session.delegate = self;
	_session.available = YES;
}

- (NSArray *)availableServers
{
	return _availableServers;
}

- (NSUInteger)availableServerCount
{
	return [_availableServers count];
}

- (NSString *)peerIDForAvailableServerAtIndex:(NSUInteger)index
{
	return [_availableServers objectAtIndex:index];
}

- (NSString *)displayNameForPeerID:(NSString *)peerID
{
	return [_session displayNameForPeer:peerID];
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
#ifdef DEBUG
	NSLog(@"MatchmakingClient: peer %@ changed state %d", peerID, state);
#endif
    
	switch (state)
	{
            // The client has discovered a new server.
		case GKPeerStateAvailable:
			if (![_availableServers containsObject:peerID])
			{
				[_availableServers addObject:peerID];
				[self.delegate matchmakingClient:self serverBecameAvailable:peerID];
			}
			break;
            
            // The client sees that a server goes away.
		case GKPeerStateUnavailable:
			if ([_availableServers containsObject:peerID])
			{
				[_availableServers removeObject:peerID];
				[self.delegate matchmakingClient:self serverBecameUnavailable:peerID];
			}
			break;
            
		case GKPeerStateConnected:
			break;
            
		case GKPeerStateDisconnected:
			break;
            
		case GKPeerStateConnecting:
			break;
	}	
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
#ifdef DEBUG
	NSLog(@"MatchmakingClient: connection request from peer %@", peerID);
#endif
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"MatchmakingClient: connection with peer %@ failed %@", peerID, error);
#endif
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"MatchmakingClient: session failed %@", error);
#endif
}

@end
