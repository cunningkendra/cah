//
//  Player.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

// TODO: Add support for more player positions
typedef enum
{
	PlayerPositionBottom,  // the user
	PlayerPositionLeft,
	PlayerPositionTop,
	PlayerPositionRight
}
PlayerPosition;

@interface Player : NSObject

@property (nonatomic, assign) PlayerPosition position;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *peerID;
@property (nonatomic, assign) BOOL receivedResponse;
@property (nonatomic, assign) int gamesWon;

@end
