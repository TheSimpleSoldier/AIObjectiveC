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
    searchDepth = 6;
    int size = 0;
    int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
    avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
    int maxScore = -999;
    int *move = (int *)malloc(sizeof(int) * 2);
    NSLog(@"Next Round of Searching");
    
    for (int i = 0; i < size; i++)
    {
        move[0] = avaliableMoves[i] / 4;
        move[1] = avaliableMoves[i] % 4;
        if (![Utilities moveValid:move :gameBoard])
        {
            NSLog(@"Move not valid");
            continue;
        }
        
        int *newGameBoard = [Utilities upDateGameBoard:move :gameBoard :team];
        int score = [self strictMinMaxSearch:newGameBoard :team :0];
        NSString *helper = [[NSString alloc] initWithFormat:@"move:%i, %i, score: %i", move[0], move[1], score];
        NSLog(helper);
        if (i == 0)
        {
            NSLog(@"Initialized Spot");
            maxScore = score;
            nextSpot[0] = move[0];
            nextSpot[1] = move[1];
        }
        else if (score > maxScore)
        {
            NSLog(@"Modifing Score");
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
        //NSLog(@"going down recursively");
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
            int *nextMove = (int *)malloc(sizeof(int) * 2);
            nextMove[0] = avaliableMoves[i] / 4;
            nextMove[1] = avaliableMoves[i] % 4;
            // opponents move
            if (round % 2 == 1)
            {
                newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :opponent];
            }
            // our move
            else
            {
                newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :team];
            }
        
            int nextMoveVal;
            if (i == 0)
            {
                currentVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                nextMoveVal = currentVal;
            }
            // opponents move go with min
            else if (round % 2 == 1)
            {
                nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                /*if ([Utilities teamWon:newGameBoard] == opponent)
                {
                    NSLog(@"Opponent won");
                    return -999;
                }
                else*/ if (nextMoveVal < currentVal)
                {
                    currentVal = nextMoveVal;
                }
            }
            // our move go max
            else
            {
                nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                if (nextMoveVal > currentVal)
                {
                    currentVal = nextMoveVal;
                }
            }
        }
        return currentVal;
    }
    else
    {
        //NSLog(@"calling Heuristic");
        int value = /*arc4random()%100;//*/[HeuristicFunctions getValue:gameBoard :team];
        return value;
    }
}

@end
