//
//  NearestNeighbor.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 11/23/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearestNeighbor : NSObject

+(int *) getNextMove:(int *)board :(int)team;

@end
