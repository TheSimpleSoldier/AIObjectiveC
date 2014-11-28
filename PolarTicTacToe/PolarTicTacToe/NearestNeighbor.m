//
//  NearestNeighbor.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 11/23/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "NearestNeighbor.h"
#import "Search.h"

@implementation NearestNeighbor

+(int *) getNextMove:(int *)board :(int)team
{
    return [Search getNextSpotNearestNeighbor:board :team];
}

@end
