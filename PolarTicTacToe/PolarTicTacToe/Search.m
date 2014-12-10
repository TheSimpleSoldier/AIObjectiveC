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

/**
 * This method runs a strict min-max solution to find the next avaliable move
 */
+(int *) getNextSpot:(int *)gameBoard :(int)team :(int)heuristicVal :(int)searchDepthVal;
{
    @autoreleasepool {
        // create some vars
        int *nextSpot = (int *)malloc(sizeof(int) * 2);
        searchDepth = searchDepthVal;
        int size = 0;
        int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
        // grab all avalaible moves to iterate over
        avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        int maxScore = -1000;
        int *move = (int *)malloc(sizeof(int) * 2);
        
        // loop through all moves to find the one with the highest score
        for (int i = 0; i < size; i++)
        {
            // set up next move on list
            move[0] = avaliableMoves[i] / 4;
            move[1] = avaliableMoves[i] % 4;
            // validate that move is indeed valid
            if (![Utilities moveValid:move :gameBoard])
            {
                continue;
            }
            
            // create a new game board with updated move
            int *newGameBoard = [Utilities upDateGameBoard:move :gameBoard :team];
            // pass new game board to min-max search for a score
            int score = [self strictMinMaxSearch:newGameBoard :team :1 :heuristicVal];
            // set as score if first round
            if (i == 0)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            // otherwise if it is best move so far update
            else if (score > maxScore)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            free(newGameBoard);
        }
        
        free(avaliableMoves);
        free(move);
        
        // return the best move
        return nextSpot;
    }
}

/**
 * This method searches for the best move based on an alpha-beta search
 */
+(int *) getNextSpotAlphaBeta:(int *)gameBoard :(int)team :(int)heuristicVal :(int)searchDepthVal :(int)verboseVal
{
    // create memory management
    @autoreleasepool {
        // initialize vars
        int *nextSpot = (int *)malloc(sizeof(int) * 2);
        searchDepth = searchDepthVal;
        int size = 0;
        int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
        avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        int maxScore = -1000;
        int *move = (int *)malloc(sizeof(int) * 2);
        
        
        // loop through all avaliable moves
        for (int i = 0; i < size; i++)
        {
            // set up move
            move[0] = avaliableMoves[i] / 4;
            move[1] = avaliableMoves[i] % 4;
            // check if move is valid
            if (![Utilities moveValid:move :gameBoard])
            {
                continue;
            }
            
            // create a new game board with move
            int *newGameBoard = [Utilities upDateGameBoard:move :gameBoard :team];
            if (verboseVal)
            {
                NSLog(@"Searching next move max node: %i, %i", move[0], move[1]);
            }
            // calculate score for that move
            int score = [self alphaBetaSearch:newGameBoard :team :1 :maxScore :heuristicVal :verboseVal];
            if (verboseVal)
            {
                NSLog(@"Move Score:%i, %i, score: %i", move[0], move[1], score);
            }
            // if first move then set as best move
            if (i == 0)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            // if it is best move currently found then select it
            else if (score > maxScore)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            
            free(newGameBoard);
        }
        
        
        free(avaliableMoves);
        free(move);
        
        // return the best move
        return nextSpot;
    }
}

/**
 * This method finds the best move based on the nearest neighbor algorithm
 */
+(int *) getNextSpotNearestNeighbor:(int *)gameBoard :(int)team :(int)heuristicVal :(int)searchDepthVal
{
    @autoreleasepool {
        // setup vars
        int *nextSpot = (int *)malloc(sizeof(int) * 2);
        searchDepth = searchDepthVal;
        int size = 0;
        int *avaliableMoves = (int *)malloc(sizeof(int) * 48);
        // grab all valid moves to iterate over
        avaliableMoves = [Utilities getAllAvaliableMoves:gameBoard :&size];
        int maxScore = -1000;
        int *move = (int *)malloc(sizeof(int) * 2);
        
        // iterate over all moves
        for (int i = 0; i < size; i++)
        {
            move[0] = avaliableMoves[i] / 4;
            move[1] = avaliableMoves[i] % 4;
            // make sure move is valid before continuing search
            if (![Utilities moveValid:move :gameBoard])
            {
                continue;
            }
            
            // create new game board with current move
            int *newGameBoard = [Utilities upDateGameBoard:move :gameBoard :team];
            // calculate score based on move
            int score = [self nearestNeighborPrunning:newGameBoard :team :1 :maxScore :heuristicVal];
            // if first move then set as best move
            if (i == 0)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
            // if current move is best found so far update
            else if (score > maxScore)
            {
                maxScore = score;
                nextSpot[0] = move[0];
                nextSpot[1] = move[1];
            }
        }
        
        free(avaliableMoves);
        free(move);
        
        // return the best move
        return nextSpot;
    }
}

/**
 * This function recursively Implements strict min-max
 */
+(int) strictMinMaxSearch:(int *)gameBoard :(int)team :(int)round :(int)heuristicVal
{
    @autoreleasepool {
        // if we are not at depth call ourself for all of our children pick best (highest for max node, lowest for min node)
        if (round < searchDepth)
        {
            // set up vars
            int size = 0;
            int currentVal = 0;
            // get all valid moves
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
            
            // make sure that no one has won the game
            int teamThatWon = [Utilities checkWin:gameBoard];
            if (teamThatWon == opponent)
            {
                return -999;
            }
            else if (teamThatWon == team)
            {
                return 999;
            }

            // if no one has won iterate over all valid moves
            for (int i = 0; i < size; i++)
            {
                // set up vars
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
                // if it is first move set it to best
                if (i == 0)
                {
                    currentVal = [self strictMinMaxSearch:newGameBoard :team :(round+1) :heuristicVal];
                    nextMoveVal = currentVal;
                }
                // opponents move go with min
                else if (round % 2 == 1)
                {
                    nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1) :heuristicVal];
                    // pick move with lowest score as we are min node
                    if (nextMoveVal < currentVal)
                    {
                        currentVal = nextMoveVal;
                    }
                }
                // our move go max
                else
                {
                    nextMoveVal = [self strictMinMaxSearch:newGameBoard :team :(round+1) :heuristicVal];
                    // pick move with highest score as we are max node
                    if (nextMoveVal > currentVal)
                    {
                        currentVal = nextMoveVal;
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
            // if we have reached bottom depth call the given heuristic val
            int value;
            if (heuristicVal == 0)
            {
                value = [HeuristicFunctions getValue:gameBoard :team];
            }
            else if (heuristicVal == 1)
            {
                value = [HeuristicFunctions decisionTreeChecker:gameBoard :team];
            }
            else
            {
                value = [HeuristicFunctions evaluate:gameBoard :team];
            }
            
            return value;
        }
    }
}

/**
 * This method recursively implements alpha-beta prunning
 */
+(int) alphaBetaSearch:(int *)gameBoard :(int)team :(int)round :(int)parentScore :(int)heuristicVal :(int)verboseVal
{
    // set up memory management
    @autoreleasepool {
        // check to see if a team has won so we can stop
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
        // if we haven't bottomed out call ourself on children
        if (round < searchDepth)
        {
            // set up vars
            int size = 0;
            int currentVal = 0;
            // get all avaliable moves
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
            
            // loop over all valid moves calling ourself on them
            for (int i = 0; i < size; i++)
            {
                // set up vars
                int *newGameBoard;
                int *nextMove = (int *)malloc(sizeof(int) * 2);
                nextMove[0] = avaliableMoves[i] / 4;
                nextMove[1] = avaliableMoves[i] % 4;
                // opponents move
                if (round % 2 == 1)
                {
                    if (verboseVal)
                    {
                        NSLog(@"Min node");
                    }
                    newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :opponent];
                }
                // our move
                else
                {
                    if (verboseVal)
                    {
                        NSLog(@"Max node");
                    }
                    
                    newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :team];
                }
                
                
                int nextMoveVal;
                // if it is first move set it as best move
                if (i == 0)
                {
                    if (verboseVal)
                    {
                        NSLog(@"Searching: %i, %i ", nextMove[0], nextMove[1]);
                    }
                    
                    currentVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :verboseVal];
                    nextMoveVal = currentVal;
                }
                // opponents move go with min
                else if (round % 2 == 1)
                {
                    if (verboseVal)
                    {
                        NSLog(@"Searching: %i, %i ", nextMove[0], nextMove[1]);
                    }
                    
                    nextMoveVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :verboseVal];
                    // if move is best so far set it to best
                    if (nextMoveVal < currentVal)
                    {
                        currentVal = nextMoveVal;
                    }
                    // if the parent (max-node) will go somewhere else stop searching this tree
                    if (parentScore > currentVal)
                    {
                        if (verboseVal)
                        {
                            NSLog(@"Prunning: %i", round);
                        }
                        
                        return currentVal;
                    }
                }
                // our move go max
                else
                {
                    if (verboseVal)
                    {
                        NSLog(@"Searching: %i, %i ", nextMove[0], nextMove[1]);
                    }
                    
                    nextMoveVal = [self alphaBetaSearch:newGameBoard :team :(round+1) :currentVal :heuristicVal :verboseVal];
                    // if current move is best so far set it as best
                    if (nextMoveVal > currentVal)
                    {
                        currentVal = nextMoveVal;
                    }
                    // if the parent (min-node) will go somewhere else stop searching this tree
                    if (parentScore < currentVal)
                    {
                        if (verboseVal)
                        {
                            NSLog(@"Prunning: %i", round);
                        }
                        
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
            // if we have bottomed out call given heuristic function
            int value;
            if (heuristicVal == 0)
            {
                value = [HeuristicFunctions getValue:gameBoard :team];
            }
            else if (heuristicVal == 1)
            {
                value = [HeuristicFunctions decisionTreeChecker:gameBoard :team];
            }
            else
            {
                value = [HeuristicFunctions evaluate:gameBoard :team];
            }
            if (verboseVal)
            {
                NSLog(@"calculating heuristic, %i", value);
            }
            
            return value;
        }
    }
}

/**
 * Here we do alpha-beta prunning but we add a nearest neighbor check so we will
 * always look at the best child and at the others with a probability distribution
 */
+(int) nearestNeighborPrunning:(int *)gameBoard :(int)team :(int)round :(int)parentScore :(int)heuristicVal
{
    @autoreleasepool {
        // if we have not bottomed out in our search recursively call ourselves
        if (round < searchDepth)
        {
            // set up vars
            int size = 0;
            int currentVal = 0;
            // get all avaliable moves to iterate over
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
            // check to see if someone has won the game
            int lostRound = [Utilities checkWin:gameBoard];
            if (lostRound == opponent)
            {
                return -999;
            }
            else if (lostRound == team)
            {
                return 999;
            }
            
            // set up arrays to store the heuristic scores to determine which nodes to search
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
                    // set up new gameboard and call heuristic on it
                    newGameBoard = [Utilities upDateGameBoard:nextMove :gameBoard :opponent];
                    scoreArray[i] = [HeuristicFunctions getValue:newGameBoard :team];
                    if (scoreArray[i] < maxScore)
                    {
                        maxScore = scoreArray[i];
                        indexOfMaxScore = i;
                    }
                    else
                    {
                        // choose base on a probability function so if we are at a good move for us we rarely choose and if we are really good move for opponent we
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
                        
                        // if someone won then we want to include this node in our search
                        int winner = [Utilities checkWin:newGameBoard];
                        if (winner != 0)
                        {
                            nodesToSearch[i] = 1;
                        }
                    }

                }
                // our move
                else
                {
                    // set up new gameboard and call heuristic on it
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
            
            // we loop through all of the valid moves and then call ourselves
            // on the ones that we choose based on the hueristic values and probability distribution
            for (int i = 0; i < size; i++)
            {
                // if it is best or chosen move then search otherwise continue
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
                
                // setup vars
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
                    currentVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal :heuristicVal];
                    nextMoveVal = currentVal;
                }
                // opponents move go with min
                else if (round % 2 == 1)
                {
                    nextMoveVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal :heuristicVal];
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
                    nextMoveVal = [self nearestNeighborPrunning:newGameBoard :team :(round+1) :currentVal :heuristicVal];
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
            // if we have bottomed out then return heuristic value for current state
            int value;
            if (heuristicVal == 0)
            {
                value = [HeuristicFunctions getValue:gameBoard :team];
            }
            else if (heuristicVal == 1)
            {
                value = [HeuristicFunctions decisionTreeChecker:gameBoard :team];
            }
            else
            {
                value = [HeuristicFunctions evaluate:gameBoard :team];
            }
            return value;
        }
    }
}

@end
