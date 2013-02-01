//
//  PacketServerReady.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "PacketServerReady.h"
#import "NSData+CardsAdditions.h"
#import "Player.h"

@implementation PacketServerReady

@synthesize players = _players;

+ (id)packetWithPlayers:(NSMutableDictionary *)players
{
	return [[[self class] alloc] initWithPlayers:players];
}

- (id)initWithPlayers:(NSMutableDictionary *)players
{
	if ((self = [super initWithType:PacketTypeServerReady]))
	{
		self.players = players;
	}
	return self;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	[data appendInt8:[self.players count]];
    
	[self.players enumerateKeysAndObjectsUsingBlock:^(id key, Player *player, BOOL *stop)
     {
         [data appendString:player.peerID];
         [data appendString:player.name];
         [data appendInt8:player.position];
     }];
}

+ (id)packetWithData:(NSData *)data
{
	NSMutableDictionary *players = [NSMutableDictionary dictionaryWithCapacity:4];
    
	size_t offset = PACKET_HEADER_SIZE;
	size_t count;
    
	int numberOfPlayers = [data int8AtOffset:offset];
	offset += 1;
    
	for (int t = 0; t < numberOfPlayers; ++t)
	{
		NSString *peerID = [data stringAtOffset:offset bytesRead:&count];
		offset += count;
        
		NSString *name = [data stringAtOffset:offset bytesRead:&count];
		offset += count;
        
		PlayerPosition position = [data int8AtOffset:offset];
		offset += 1;
        
		Player *player = [[Player alloc] init];
		player.peerID = peerID;
		player.name = name;
		player.position = position;
		[players setObject:player forKey:player.peerID];
	}
    
	return [[self class] packetWithPlayers:players];
}

@end
