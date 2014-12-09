//
//  AlphaBetaAI.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 11/2/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlphaBetaAI : NSObject

+(int *) getNextMove:(int *)board :(int)team :(int)heuristicVal :(int)searchDepth :(int)verboseVal;

@end
