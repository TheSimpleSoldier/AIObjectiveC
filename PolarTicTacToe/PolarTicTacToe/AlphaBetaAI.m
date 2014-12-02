//
//  AlphaBetaAI.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 11/2/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "AlphaBetaAI.h"
#import "Search.h"

@implementation AlphaBetaAI

+(int *) getNextMove:(int *)board :(int)team :(int)heuristicVal :(int)searchDepth
{
    return [Search getNextSpotAlphaBeta:board :team :heuristicVal :searchDepth];
}

@end
