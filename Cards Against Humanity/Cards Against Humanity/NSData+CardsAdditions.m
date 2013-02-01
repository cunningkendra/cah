//
//  NSData+CardsAdditions.m
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import "NSData+CardsAdditions.h"

@implementation NSData (CardsAdditions)

- (int)int32AtOffset:(size_t)offset
{
	const int *intBytes = (const int *)[self bytes];
	return ntohl(intBytes[offset / 4]);
}

- (short)int16AtOffset:(size_t)offset
{
	const short *shortBytes = (const short *)[self bytes];
	return ntohs(shortBytes[offset / 2]);
}

- (char)int8AtOffset:(size_t)offset
{
	const char *charBytes = (const char *)[self bytes];
	return charBytes[offset];
}

- (NSString *)stringAtOffset:(size_t)offset bytesRead:(size_t *)amount
{
	const char *charBytes = (const char *)[self bytes];
	NSString *string = [NSString stringWithUTF8String:charBytes + offset];
	*amount = strlen(charBytes + offset) + 1;
	return string;
}

@end

@implementation NSMutableData (CardsAdditions)

- (void)appendInt32:(int)value
{
	value = htonl(value);
	[self appendBytes:&value length:4];
}

- (void)appendInt16:(short)value
{
	value = htons(value);
	[self appendBytes:&value length:2];
}

- (void)appendInt8:(char)value
{
	[self appendBytes:&value length:1];
}

- (void)appendString:(NSString *)string
{
	const char *cString = [string UTF8String];
	[self appendBytes:cString length:strlen(cString) + 1];
}

@end
