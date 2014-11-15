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

+(int *) getNextSpot:(int *)gameBoard :(int)team;
{
    int *nextSpot = (int *)malloc(sizeof(int) * 2);
    searchDepth = 0;
    int size = 0;
    int *avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
    int maxScore = -999;
    int *move = (int *)malloc(sizeof(int) * 2);
    
    for (int i = 0; i < size; i++)
    {
        move[0] = avaliableMoves[i] / 4;
        move[1] = avaliableMoves[i] % 4;
        int *newGameBoard = [Utilities upDateGameBoard:move :gameBoard :team];
        int score = [self strictMinMaxSearch:newGameBoard :team :1];
        if (![Utilities moveValid:move :gameBoard])
        {
            NSLog(@"Move not valid");
        }
        else if (score > maxScore)
        {
            maxScore = score;
            nextSpot[0] = move[0];
            nextSpot[1] = move[1];
        }
    }
    
    return nextSpot;
}

+(int) strictMinMaxSearch:(int *)gameBoard :(int)team :(int)round;
{
    if (round < searchDepth)
    {
        NSLog(@"going down recursively");
        int size = 0;
        int currentVal = 0;
        int *avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        int opponent = 0;
        if (team == 1)
        {
            opponent = 2;
        }
        else
        {
            opponent = 1;
        }
        
        for (int i = 0; i < size; i++)
        {
            int *newGameBoard;
            // opponents move
            if (round % 2 == 1)
            {
                newGameBoard = [Utilities upDateGameBoard:&avaliableMoves[i] :gameBoard :opponent];
            }
            // our move
            else
            {
                newGameBoard = [Utilities upDateGameBoard:&avaliableMoves[i] :gameBoard :team];
            }
        
            
            if (i == 0)
            {
                currentVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
            }
            // opponents move go with min
            else if (round % 2 == 1)
            {
                int nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                if (nextMoveVal < currentVal)
                {
                    currentVal = nextMoveVal;
                }
            }
            // our move go max
            else
            {
                int nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                if (nextMoveVal > currentVal)
                {
                    currentVal = nextMoveVal;
                }
            }
        }
        
        //free(avaliableMoves);
        return currentVal;
    }
    else
    {
        NSLog(@"calling Heuristic");
        int value = arc4random()%100;//[HeuristicFunctions getValue:gameBoard :team];
        return value;
    }
}

@end
