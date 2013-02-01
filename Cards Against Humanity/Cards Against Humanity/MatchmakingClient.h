//
//  MatchmakingClient.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

@class MatchmakingClient;

@protocol MatchmakingClientDelegate <NSObject>

- (void)matchmakingClient:(MatchmakingClient *)client serverBecameAvailable:(NSString *)peerID;
- (void)matchmakingClient:(MatchmakingClient *)client serverBecameUnavailable:(NSString *)peerID;
- (void)matchmakingClient:(MatchmakingClient *)client didConnectToServer:(NSString *)peerID;
- (void)matchmakingClient:(MatchmakingClient *)client didDisconnectFromServer:(NSString *)peerID;
- (void)matchmakingClientNoNetwork:(MatchmakingClient *)client;

@end

@interface MatchmakingClient : NSObject <GKSessionDelegate>

@property (nonatomic, strong, readonly) NSArray *availableServers;
@property (nonatomic, strong, readonly) GKSession *session;

@property (nonatomic, weak) id <MatchmakingClientDelegate> delegate;

- (void)startSearchingForServersWithSessionID:(NSString *)sessionID;
- (void)connectToServerWithPeerID:(NSString *)peerID;
- (void)disconnectFromServer;
- (NSUInteger)availableServerCount;
- (NSString *)peerIDForAvailableServerAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;

@end
