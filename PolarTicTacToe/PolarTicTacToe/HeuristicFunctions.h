//
//  HeuristicFunctions.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeuristicFunctions : NSObject

+(int) getValue:(int *)gameBoard :(int)team;

@end
