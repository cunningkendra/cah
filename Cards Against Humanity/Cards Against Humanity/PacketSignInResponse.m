//
//  PacketSignInResponse.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "PacketSignInResponse.h"
#import "NSData+CardsAdditions.h"

@implementation PacketSignInResponse

@synthesize playerName = _playerName;

+ (id)packetWithPlayerName:(NSString *)playerName
{
	return [[[self class] alloc] initWithPlayerName:playerName];
}

- (id)initWithPlayerName:(NSString *)playerName
{
	if ((self = [super initWithType:PacketTypeSignInResponse]))
	{
		self.playerName = playerName;
	}
	return self;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	[data appendString:self.playerName];
}

+ (id)packetWithData:(NSData *)data
{
	size_t count;
	NSString *playerName = [data stringAtOffset:PACKET_HEADER_SIZE bytesRead:&count];
	return [[self class] packetWithPlayerName:playerName];
}

@end
