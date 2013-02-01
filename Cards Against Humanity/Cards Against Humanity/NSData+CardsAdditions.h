//
//  NSData+CardsAdditions.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-31.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

@interface NSData (CardsAdditions)

- (int)int32AtOffset:(size_t)offset;
- (short)int16AtOffset:(size_t)offset;
- (char)int8AtOffset:(size_t)offset;
- (NSString *)stringAtOffset:(size_t)offset bytesRead:(size_t *)amount;

@end

@interface NSMutableData (CardsAdditions)

- (void)appendInt32:(int)value;
- (void)appendInt16:(short)value;
- (void)appendInt8:(char)value;
- (void)appendString:(NSString *)string;

@end
