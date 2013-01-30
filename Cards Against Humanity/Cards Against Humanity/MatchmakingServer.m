//
//  MatchmakingServer.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "MatchmakingServer.h"

@implementation MatchmakingServer
{
	NSMutableArray *_connectedClients;
}

@synthesize maxClients = _maxClients;
@synthesize session = _session;

- (void)startAcceptingConnectionsForSessionID:(NSString *)sessionID
{
	_connectedClients = [NSMutableArray arrayWithCapacity:self.maxClients];
    
	_session = [[GKSession alloc] initWithSessionID:sessionID displayName:nil sessionMode:GKSessionModeServer];
	_session.delegate = self;
	_session.available = YES;
}

- (NSArray *)connectedClients
{
	return _connectedClients;
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
#ifdef DEBUG
	NSLog(@"MatchmakingServer: peer %@ changed state %d", peerID, state);
#endif
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
#ifdef DEBUG
	NSLog(@"MatchmakingServer: connection request from peer %@", peerID);
#endif
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"MatchmakingServer: connection with peer %@ failed %@", peerID, error);
#endif
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"MatchmakingServer: session failed %@", error);
#endif
}

@end
