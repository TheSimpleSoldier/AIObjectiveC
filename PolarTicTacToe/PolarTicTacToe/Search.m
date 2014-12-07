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
#import <pthread.h>

@implementation Search

+(int *) getNextSpot:(int *)gameBoard :(int)team;
{
    int *nextSpot = (int *)malloc(sizeof(int) * 2);
    searchDepth = 5;
    int size = 0;
    int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
    avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
    int maxScore = -1000;
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
        int score = [self strictMinMaxSearch:newGameBoard :team :1];
        NSLog(@"move:%i, %i, score: %i", move[0], move[1], score);
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

/*
+(int *) d:(int *)gameBoard :(int)team :(int)heuristicVal :(int)searchDepthVal
{
    int *nextSpot = (int *)malloc(sizeof(int) * 2);
    searchDepth = searchDepthVal;
    int size = 0;
    int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
    avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
    int maxScore = -1000;
    int *move = (int *)malloc(sizeof(int) * 2);
    NSLog(@"Next Round of Searching");

    

    int *score = (int *)malloc(sizeof(int) * size);
    
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
        
        pthread_t *tID = NULL;
        int tArg;
        
        // prepare the test argument
        tArg = 5120;
        
        // create a pthread
        score[i] = pthread_create(tID, NULL, [self getNextSpotAlphaBeta:newGameBoard :team :heuristicVal :searchDepthVal], nil);
        pthread_exit(NULL);
    }
    
    
    
    for (int i = 0; i < size; i++)
    {
        
        NSLog(@"move:%i, %i, score: %i", move[0], move[1], score[i]);
        if (i == 0)
        {
            NSLog(@"Initialized Spot");
            maxScore = score[i];
            nextSpot[0] = move[0];
            nextSpot[1] = move[1];
        }
        else if (score[i] > maxScore)
        {
            NSLog(@"Modifing Score");
            maxScore = score[i];
            nextSpot[0] = move[0];
            nextSpot[1] = move[1];
        }
    }
    
    return nextSpot;

}*/


+(int *) getNextSpotAlphaBeta:(int *)gameBoard :(int)team :(int)heuristicVal :(int)searchDepthVal :(int) neuralNet
{
    @autoreleasepool {
        int *nextSpot = (int *)malloc(sizeof(int) * 2);
        searchDepth = searchDepthVal;
        int size = 0;
        int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
        avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        int maxScore = -1000;
        int *move = (int *)malloc(sizeof(int) * 2);
        //NSLog(@"Next Round of Searching");
        
        
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
            int score = [self alphaBetaSearch:newGameBoard :team :1 :maxScore :heuristicVal :neuralNet];
            //NSLog(@"move:%i, %i, score: %i", move[0], move[1], score);
            if (i == 0)
            {
               // NSLog(@"Initialized Spot");
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            else if (score > maxScore)
            {
            //    NSLog(@"Modifing Score");
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            
            free(newGameBoard);
        }
        
        
        free(avaliableMoves);
        free(move);
        
        return nextSpot;
    }
}


+(int *) getNextSpotNearestNeighbor:(int *)gameBoard :(int)team
{
    int *nextSpot = (int *)malloc(sizeof(int) * 2);
    searchDepth = 9;
    int size = 0;
    int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
    avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
    int maxScore = -1000;
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
        int score = [self nearestNeighborPrunning:newGameBoard :team :1 :maxScore];
        NSLog(@"move:%i, %i, score: %i", move[0], move[1], score);
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

+(int) strictMinMaxSearch:(int *)gameBoard :(int)team :(int)round
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
                int teamThatWon = [Utilities checkWin:newGameBoard];
                if (teamThatWon == opponent)
                {
                    return -999;
                }
                else if (teamThatWon == team)
                {
                    return 999;
                }
                
                nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1)];
                if (nextMoveVal < currentVal)
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
        int value = /*arc4random()%100;//*/ [HeuristicFunctions decisionTreeChecker:gameBoard :team]; //[HeuristicFunctions getValue:gameBoard :team];
        return value;
    }
}

+(int) alphaBetaSearch:(int *)gameBoard :(int)team :(int)round :(int)parentScore :(int)heuristicVal :(int)neuralNet
{
    @autoreleasepool {
        int teamThatWon = [Utilities checkWin:gameBoard];
        if (teamThatWon != 0)
        {
            if (teamThatWon == team)
            {
                return 999 - round;
            }
            else
            {
                return -999 + round;
            }
        }
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
                    currentVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :neuralNet];
                    nextMoveVal = currentVal;
                }
                // opponents move go with min
                else if (round % 2 == 1)
                {
                    nextMoveVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :neuralNet];
                    if (nextMoveVal < currentVal)
                    {
                        currentVal = nextMoveVal;
                    }
                    // if the parent (max-node) will go somewhere else stop searching this tree
                    if (parentScore > currentVal)
                    {
                        return currentVal;
                    }
                }
                // our move go max
                else
                {
                    nextMoveVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :neuralNet];
                    if (nextMoveVal > currentVal)
                    {
                        currentVal = nextMoveVal;
                    }
                    // if the parent (min-node) will go somewhere else stop searching this tree
                    if (parentScore < currentVal)
                    {
                        return currentVal;
                    }
                }
                
                free(newGameBoard);
                free(nextMove);
            }
            free(avaliableMoves);
            return currentVal;
        }
        else
        {
            int value;
            if (heuristicVal == 0)
            {
                value = [HeuristicFunctions getValue:gameBoard :team];
                //NSLog(@"Base Heuristic");
            }
            else if (heuristicVal == 1)
            {
                //NSLog(@"Classifier");
                value = [HeuristicFunctions decisionTreeChecker:gameBoard :team];
            }
            else
            {
                value = [HeuristicFunctions evaluate:gameBoard :team :neuralNet];
            }
            return value;
        }
    }
}

/**
 * Here we do alpha-beta prunning but we add a nearest neighbor check so we will
 * always look at the best child
 */
+(int) nearestNeighborPrunning:(int *)gameBoard :(int)team :(int)round :(int)parentScore
{
    if (round < searchDepth)
    {
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
        int lostRound = [Utilities checkWin:gameBoard];
        if (lostRound == opponent)
        {
            return -999;
        }
        else if (lostRound == team)
        {
            return 999;
        }
        
        int *scoreArray = (int *)malloc(sizeof(int) * size);
        int maxScore = -999;
        int indexOfMaxScore = 0;
        int *nodesToSearch = (int* )malloc(sizeof(int) * size);
        
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
                scoreArray[i] = [HeuristicFunctions getValue:newGameBoard :team];
                if (scoreArray[i] < maxScore)
                {
                    maxScore = scoreArray[i];
                    indexOfMaxScore = i;
                }
                else
                {
                    // choose base on a probability function so if we are at the minimum we never choose and if we are really good we
                    // will choose 75% of the time
                    int random = arc4random()%(scoreArray[i] + 2000);
                    if (random < 500)
                    {
                        nodesToSearch[i] = 1;
                    }
                    else
                    {
                        nodesToSearch[i] = 0;
                    }
                }

            }
            // our move
            else
            {
                newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :team];
                scoreArray[i] = [HeuristicFunctions getValue:newGameBoard :team];
                if (scoreArray[i] > maxScore)
                {
                    maxScore = scoreArray[i];
                    indexOfMaxScore = i;
                }
                else
                {
                    // choose base on a probability function so if we are at the minimum we never choose and if we are really good we
                    // will choose 75% of the time
                    int random = arc4random()%(scoreArray[i] + 1000);
                    if (random > 500)
                    {
                        nodesToSearch[i] = 1;
                    }
                    else
                    {
                        nodesToSearch[i] = 0;
                    }
                }

            }
        }
        
        
        for (int i = 0; i < size; i++)
        {
            
            if (i == indexOfMaxScore)
            {
                
            }
            else if (nodesToSearch[i] == 1)
            {
                
            }
            // we don't execute
            else
            {
                continue;
            }
            
            if (nodesToSearch[i] == 0 && i != indexOfMaxScore)
            {
                NSLog(@"We have a problem");
            }
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
                currentVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal];
                nextMoveVal = currentVal;
            }
            // opponents move go with min
            else if (round % 2 == 1)
            {
                int teamThatWon = [Utilities checkWin:newGameBoard];
                if (teamThatWon == opponent)
                {
                    return -999;
                }
                else if (teamThatWon == team)
                {
                    return 999;
                }
                
                nextMoveVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal];
                if (nextMoveVal < currentVal)
                {
                    currentVal = nextMoveVal;
                }
                // if the parent (max-node) will go somewhere else stop searching this tree
                if (parentScore > currentVal)
                {
                    return currentVal;
                }
            }
            // our move go max
            else
            {
                nextMoveVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal];
                if (nextMoveVal > currentVal)
                {
                    currentVal = nextMoveVal;
                }
                // if the parent (min-node) will go somewhere else stop searching this tree
                if (parentScore < currentVal)
                {
                    return currentVal;
                }
            }
        }
        return currentVal;
    }
    else
    {
        int value = /*arc4random()%100;// [HeuristicFunctions decisionTreeChecker:gameBoard :team]; //*/[HeuristicFunctions getValue:gameBoard :team];
        int teamThatWon = [Utilities checkWin:gameBoard];
        if (teamThatWon != 0)
        {
            if (teamThatWon == team)
            {
                return 999;
            }
            else
            {
                return -999;
            }
        }
        return value;
    }
}

@end
