//
//  PacketOtherClientQuit.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "PacketOtherClientQuit.h"
#import "NSData+CardsAdditions.h"

@implementation PacketOtherClientQuit

@synthesize peerID = _peerID;

+ (id)packetWithPeerID:(NSString *)peerID
{
	return [[[self class] alloc] initWithPeerID:peerID];
}

- (id)initWithPeerID:(NSString *)peerID
{
	if ((self = [super initWithType:PacketTypeOtherClientQuit]))
	{
		self.peerID = peerID;
	}
	return self;
}

+ (id)packetWithData:(NSData *)data
{
	size_t offset = PACKET_HEADER_SIZE;
	size_t count;
    
	NSString *peerID = [data stringAtOffset:offset bytesRead:&count];
    
	return [[self class] packetWithPeerID:peerID];
}

- (void)addPayloadToData:(NSMutableData *)data
{
	[data appendString:self.peerID];
}

@end
