//
//  Search.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search : NSObject

+(int *) getNextSpot:(int *)gameBoard:(int *)type;
+(int *) strictMinMaxSearch:(int *)gameBoard: (int)team;

@end
