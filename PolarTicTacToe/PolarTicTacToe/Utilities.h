//
//  Utilities.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(int) teamWon:(int *)gameBoard;
+(NSSet *) resolveVars:(NSString *)first :(NSString *)second;
+(BOOL) moveValid:(int *)move :(int *)gameBoard;
+(int *) upDateGameBoard:(int *)move :(int *)gameBoard :(int)team;
+(int *) getAllAvaliableMoves:(int *)board: (int *)size;

@end