//
//  MinMaxAI.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 11/2/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinMaxAI : NSObject

+(int *) getNextMove:(int *)board :(int)team;

@end
