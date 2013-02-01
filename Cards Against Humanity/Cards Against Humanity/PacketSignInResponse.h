//
//  PacketSignInResponse.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "Packet.h"

@interface PacketSignInResponse : Packet

@property (nonatomic, copy) NSString *playerName;

+ (id)packetWithPlayerName:(NSString *)playerName;

@end
