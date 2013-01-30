//
//  UIButton+CardsAdditions.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-30.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "UIButton+CardsAdditions.h"
#import "UIFont+CardsAdditions.h"

@implementation UIButton (CardsAdditions)

- (void)applyCardsStyle
{
	self.titleLabel.font = [UIFont cardsFontWithSize:20.0f];
    
	UIImage *buttonImage = [[UIImage imageNamed:@"Button"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
	[self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
	UIImage *pressedImage = [[UIImage imageNamed:@"ButtonPressed"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
	[self setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
}

@end
