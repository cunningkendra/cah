//
//  Packet.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "Packet.h"
#import "PacketOtherClientQuit.h"
#import "PacketServerReady.h"
#import "PacketSignInResponse.h"
#import "NSData+CardsAdditions.h"

const size_t PACKET_HEADER_SIZE = 10;

@implementation Packet

@synthesize packetType = _packetType;

+ (id)packetWithType:(PacketType)packetType
{
	return [[[self class] alloc] initWithType:packetType];
}

- (id)initWithType:(PacketType)packetType
{
	if ((self = [super init]))
	{
		self.packetType = packetType;
	}
	return self;
}

+ (id)packetWithData:(NSData *)data
{
	if ([data length] < PACKET_HEADER_SIZE)
	{
		NSLog(@"Error: Packet too small");
		return nil;
	}
    
	if ([data int32AtOffset:0] != 'CARD')
	{
		NSLog(@"Error: Packet has invalid header");
		return nil;
	}
    
	int packetNumber = [data int32AtOffset:4];
	PacketType packetType = [data int16AtOffset:8];
    
	Packet *packet;
    
	switch (packetType)
	{
        case PacketTypeOtherClientQuit:
			packet = [PacketOtherClientQuit packetWithData:data];
			break;
            
        case PacketTypeServerReady:
			packet = [PacketServerReady packetWithData:data];
			break;
            
		case PacketTypeSignInRequest:
        case PacketTypeClientReady:
        case PacketTypeServerQuit:
		case PacketTypeClientQuit:
			packet = [Packet packetWithType:packetType];
			break;
            
		case PacketTypeSignInResponse:
			packet = [PacketSignInResponse packetWithData:data];
			break;
            
		default:
			NSLog(@"Error: Packet has invalid type");
			return nil;
	}
    
	return packet;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	// base class does nothing
}

- (NSData *)data
{
	NSMutableData *data = [[NSMutableData alloc] initWithCapacity:100];
    
	[data appendInt32:'CARD'];   // 0x43415244
	[data appendInt32:0];
	[data appendInt16:self.packetType];
    
    [self addPayloadToData:data];
	return data;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@, type=%d", [super description], self.packetType];
}

@end
