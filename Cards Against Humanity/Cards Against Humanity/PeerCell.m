//
//  PeerCell.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "PeerCell.h"
#import "UIFont+CardsAdditions.h"

@implementation PeerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground"]];
		self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackgroundSelected"]];
        
		self.textLabel.font = [UIFont cardsFontWithSize:24.0f];
		self.textLabel.textColor = [UIColor colorWithRed:116/255.0f green:192/255.0f blue:97/255.0f alpha:1.0f];
		self.textLabel.highlightedTextColor = self.textLabel.textColor;
	}
	return self;
}

@end