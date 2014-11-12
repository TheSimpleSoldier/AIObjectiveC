//
//  Search.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "Search.h"
#import "Utilities.h"
#import "HeuristicFunctions.h"

@implementation Search

+(int *) getNextSpot:(int *)gameBoard:(int *)type
{
    int *nextSpot = (int *)malloc(sizeof(int) * 2);
    searchDepth = 10;
    
    return nextSpot;
}

+(int) strictMinMaxSearch:(int *)gameBoard: (int)team: (int)round: (int *)move;
{
    if (round < searchDepth)
    {
        int size = 0;
        int currentVal = 0;
        int *avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        
        for (int i = 0; i < size; i++)
        {
            
        }
        
    }
    else
    {
        return [HeuristicFunctions getValue:<#(int *)#> :<#(int *)#> :<#(int)#>]
    }
}

@end
