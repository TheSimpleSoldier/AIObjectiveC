//
//  Utilities.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(int) teamWon:(int *)gameBoard :(int *) team;
+(BOOL) moveValid:(int *)move :(int *)gameBoard;
+(int *) upDateGameBoard:(int *)move :(int *)gameBoard :(int)team;

@end