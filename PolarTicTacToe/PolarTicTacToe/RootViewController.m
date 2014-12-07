//
//  RootViewController.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/14/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "RootViewController.h"
#import "Utilities.h"
#import "RandomAI.h"
#import "MinMaxAI.h"
#import "AlphaBetaAI.h"
#import "NearestNeighbor.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize label;
@synthesize label0_0, label0_1, label0_2, label0_3, label10_0, label10_1, label10_2, label10_3, label11_0, label11_1, label11_2, label11_3, label1_0, label1_1, label1_2, label1_3;
@synthesize label2_0, label2_1, label2_2, label2_3, label3_0, label3_1, label3_2, label3_3, label4_0, label4_1, label4_2, label4_3, label5_0, label5_1, label5_2, label5_3, label6_0;
@synthesize label6_1, label6_2, label6_3, label7_0, label7_1, label7_2, label7_3, label8_0, label8_1, label8_2, label8_3, label9_0, label9_1, label9_2, label9_3;
@synthesize gameChooser, searchType, heuristic, searchDepth, searchType2, heuristic2, searchDepth2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        xTeamVal = 1;
        oTeamVal = 2;
        [self reset];
        numbOfMoves = 0;
        // Initialization code here.
    }
    return self;
}

-(BOOL) validateUserMove:(int)x :(int)y
{
    BOOL allowedMove;
    int *move = (int *)malloc(sizeof(int) * 2);
    move[0] = x;
    move[1] = y;
    
    if ([Utilities moveValid:move:board] || numbOfMoves == 0)
    {
        allowedMove = TRUE;
        if (weRX)
        {
            board = [Utilities upDateGameBoard:move:board:xTeamVal];
        }
        else
        {
            board = [Utilities upDateGameBoard:move:board:oTeamVal];
        }
    }
    else
    {
        allowedMove = FALSE;
    }
    
    free(move);
    return allowedMove;
}

-(void) upDateLabel:(int)x :(int)y
{
    @autoreleasepool {
        // if someone has won don't update
        if (winner)
        {
            return;
        }
        
        NSTextField *current;
        NSString *team = @"O";
        
        // if the move is not valid stop wait for valid move from
        // user
        if (![self validateUserMove:x:y])
        {
            NSLog(@"Failed Validation");
            return;
        }
        //[self printBoard];
        
        numbOfMoves++;
        
        // switch-case statement to determine which
        // label to update based on (x,y)
        switch (y)
        {
            case 0:
                switch (x)
                {
                    case 0:
                        current = label0_0;
                        break;
                    case 1:
                        current = label1_0;
                        break;
                    case 2:
                        current = label2_0;
                        break;
                    case 3:
                        current = label3_0;
                        break;
                    case 4:
                        current = label4_0;
                        break;
                    case 5:
                        current = label5_0;
                        break;
                    case 6:
                        current = label6_0;
                        break;
                    case 7:
                        current = label7_0;
                        break;
                    case 8:
                        current = label8_0;
                        break;
                    case 9:
                        current = label9_0;
                        break;
                    case 10:
                        current = label10_0;
                        break;
                    case 11:
                        current = label11_0;
                        break;
                    default:
                        NSLog(@"x failure");
                }
                break;
            case 1:
                switch (x)
                {
                    case 0:
                        current = label0_1;
                        break;
                    case 1:
                        current = label1_1;
                        break;
                    case 2:
                        current = label2_1;
                        break;
                    case 3:
                        current = label3_1;
                        break;
                    case 4:
                        current = label4_1;
                        break;
                    case 5:
                        current = label5_1;
                        break;
                    case 6:
                        current = label6_1;
                        break;
                    case 7:
                        current = label7_1;
                        break;
                    case 8:
                        current = label8_1;
                        break;
                    case 9:
                        current = label9_1;
                        break;
                    case 10:
                        current = label10_1;
                        break;
                    case 11:
                        current = label11_1;
                        break;
                    default:
                        NSLog(@"x failure");
                }
                break;
            case 2:
                switch (x)
                {
                    case 0:
                        current = label0_2;
                        break;
                    case 1:
                        current = label1_2;
                        break;
                    case 2:
                        current = label2_2;
                        break;
                    case 3:
                        current = label3_2;
                        break;
                    case 4:
                        current = label4_2;
                        break;
                    case 5:
                        current = label5_2;
                        break;
                    case 6:
                        current = label6_2;
                        break;
                    case 7:
                        current = label7_2;
                        break;
                    case 8:
                        current = label8_2;
                        break;
                    case 9:
                        current = label9_2;
                        break;
                    case 10:
                        current = label10_2;
                        break;
                    case 11:
                        current = label11_2;
                        break;
                    default:
                        NSLog(@"x failure");
                }
                break;
            case 3:
                switch (x)
                {
                    case 0:
                        current = label0_3;
                        break;
                    case 1:
                        current = label1_3;
                        break;
                    case 2:
                        current = label2_3;
                        break;
                    case 3:
                        current = label3_3;
                        break;
                    case 4:
                        current = label4_3;
                        break;
                    case 5:
                        current = label5_3;
                        break;
                    case 6:
                        current = label6_3;
                        break;
                    case 7:
                        current = label7_3;
                        break;
                    case 8:
                        current = label8_3;
                        break;
                    case 9:
                        current = label9_3;
                        break;
                    case 10:
                        current = label10_3;
                        break;
                    case 11:
                        current = label11_3;
                        break;
                    default:
                        NSLog(@"x failure");
                }
                break;
            default:
                NSLog(@"y Failure");
        }
        
        [current setTextColor:[NSColor blueColor]];
        
        if (weRX)
        {
            team = @"X";
            [current setTextColor:[NSColor redColor]];
        }
        
        [current setStringValue:team];
        [current display];
        
        int winnerVal = [Utilities checkWin:board];//[Utilities teamWon:board];
        
        if (winnerVal != 0)
        {
            winner = true;
            if (winnerVal == 1)
            {
                [label setStringValue:@"X Won"];
            }
            else
            {
                [label setStringValue:@"O Won"];
            }
            
            // do not continue!!
            return;
        }
        
        int size = 0;
        int *avalaibleMoves = [Utilities getAllAvaliableMoves:board :&size];
        
        if (size == 0)
        {
            [label setStringValue:@"Draw"];
            free(avalaibleMoves);
            // so we don't try again
            winner = true;
            return;
        }
        
        free(avalaibleMoves);
        
        //NSLog(@"Right before AI section");
        
        if (current != NULL)
        {
             weRX = !weRX;
            
            if (weRX && !player1Human)
            {
                
                int *aiMove;
                if (searchTypeVal == 0)
                {
                    aiMove = [RandomAI getNextMove:board];
                }
                else if (searchTypeVal == 1)
                {
                    aiMove = [MinMaxAI getNextMove:board:1];
                }
                else if (searchTypeVal == 2)
                {
                    aiMove = [AlphaBetaAI getNextMove:board :1 :heuristicVal :searchDepthVal :neuralNet];
                }
                else
                {
                    aiMove = [NearestNeighbor getNextMove:board :1];
                }
                [self upDateLabel:aiMove[0] :aiMove[1]];
                //NSLog(@"AI Move player1");
            }
            else if (!weRX && !player2Human)
            {
                int *aiMove;
                if (searchTypeVal2 == 0)
                {
                    aiMove = [RandomAI getNextMove:board];
                }
                else if (searchTypeVal2 == 1)
                {
                    aiMove = [MinMaxAI getNextMove:board:2];
                }
                else if (searchTypeVal2 == 2)
                {
                    aiMove = [AlphaBetaAI getNextMove:board :2 :heuristicVal2 :searchDepthVal2 :neuralNet2];
                }
                else
                {
                    aiMove = [NearestNeighbor getNextMove:board :1];
                }
                [self upDateLabel:aiMove[0] :aiMove[1]];
            }
            else
            {
                NSLog(@"Human Move");
            }
        }
        else
        {
            NSLog(@"current == null");
        }
    }
}

-(void) printBoard
{
    NSString *helper = @"";
    
    NSLog(@"StartPrinting");
    for (int i = 0; i < 12; i++)
    {
        helper = [[NSString alloc] initWithFormat:@"%i %i %i %i", board[4*i], board[4*i+1], board[4*i+2], board[4*i+3]];
        NSLog(@"%@", helper);
    }
    NSLog(@"End Printing");
}

-(IBAction) newGame:(id)sender
{
    training = false;
    [self reset];
}

/**
 * In this method we will test the various neural nets against each other and against alpha beta
 */
-(IBAction) neuralNetTest:(id)sender
{
    int *wins = (int *)malloc(sizeof(int) * 42);
    training = true;
    
    // run test for each neural net
    for (int i = 0; i < 42; i++)
    {
        wins[i] = 0;
        // run each neural net against every other neural net
        for (int j = i; j < 42; j++)
        {
            // don't test against ourselves
            if (j == i)
            {
                continue;
            }
            
            [self reset];
            [self setVarsForNeuralNet];
            
            neuralNet = i + 1;
            neuralNet2 = j + 1;
            
            [self upDateLabel:0 :1];
            NSLog(@"%i, %i", i,j);
            
            int winnerVal = [Utilities teamWon:board];
            
            if (winnerVal == 1)
            {
                wins[i]++;
            }
            else if (winnerVal == 2)
            {
                wins[j]++;
            }
        }
        
        // run with every other neural net going first
        for (int j = i; j < 42; j++)
        {
            if (j == i)
            {
                continue;
            }
            
            [self reset];
            [self setVarsForNeuralNet];
            
            neuralNet = j+1;
            neuralNet2 = i+1;
            
            [self upDateLabel:0 :1];
            NSLog(@"opposite: %i, %i", i,j);
            
            int winnerVal = [Utilities checkWin:board];
            
            if (winnerVal == 1)
            {
                wins[j]++;
            }
            else if (winnerVal == 2)
            {
                wins[i]++;
            }
        }
    }
    
    
    int maxWins = 0;
    int winningIndex = 0;
    for (int i = 0; i < 42; i++)
    {
        NSLog(@"%i: %i", (i+1), wins[i]);
        if (wins[i] > maxWins)
        {
            maxWins = wins[i];
            winningIndex = i;
        }
    }
    
    NSLog(@"%i", (winningIndex+1));
}

-(void) setVarsForNeuralNet
{
    // initialize vars for test
    searchTypeVal = 2;
    searchTypeVal2 = 2;
    
    heuristicVal = 2;
    heuristicVal2 = 2;
    
    searchDepthVal = 5;
    searchDepthVal2 = 5;
    
    player1Human = false;
    player2Human = false;
}

-(void) reset
{
    free(board);
    neuralNet2 = 7;
    neuralNet = 7;
    winner = FALSE;
    NSInteger index = [gameChooser indexOfSelectedItem];
    searchDepthVal = [[searchDepth stringValue] intValue];
    searchDepthVal2 = [[searchDepth2 stringValue] intValue];
    NSLog(@"%i", searchDepthVal);
    searchTypeVal = (int) [searchType indexOfSelectedItem];
    searchTypeVal2 = (int) [searchType2 indexOfSelectedItem];
    heuristicVal = (int) [heuristic indexOfSelectedItem];
    heuristicVal2 = (int) [heuristic2 indexOfSelectedItem];
    NSString *string = [[NSString alloc] initWithFormat:@"%li", (long)index];
    
    [label setStringValue:string];
    
    if (index == 0)
    {
        player1Human = TRUE;
        player2Human = TRUE;
    }
    else if (index == 1)
    {
        player1Human = TRUE;
        player2Human = false;
    }
    else if (index == 2)
    {
        player1Human = FALSE;
        player2Human = TRUE;
    }
    else
    {
        player1Human = FALSE;
        player2Human = FALSE;
    }
    
    numbOfMoves = 0;
    weRX = true;
    [label0_0 setStringValue:@""];
    [label0_0 display];
    [label0_1 setStringValue:@""];
    [label0_1 display];
    [label0_2 setStringValue:@""];
    [label0_2 display];
    [label0_3 setStringValue:@""];
    [label0_3 display];
    
    [label1_0 setStringValue:@""];
    [label1_0 display];
    [label1_1 setStringValue:@""];
    [label1_1 display];
    [label1_2 setStringValue:@""];
    [label1_2 display];
    [label1_3 setStringValue:@""];
    [label1_3 display];
    
    [label2_0 setStringValue:@""];
    [label2_0 display];
    [label2_1 setStringValue:@""];
    [label2_1 display];
    [label2_2 setStringValue:@""];
    [label2_2 display];
    [label2_3 setStringValue:@""];
    [label2_3 display];
    
    [label3_0 setStringValue:@""];
    [label3_0 display];
    [label3_1 setStringValue:@""];
    [label3_1 display];
    [label3_2 setStringValue:@""];
    [label3_2 display];
    [label3_3 setStringValue:@""];
    [label3_3 display];
    
    [label4_0 setStringValue:@""];
    [label4_0 display];
    [label4_1 setStringValue:@""];
    [label4_1 display];
    [label4_2 setStringValue:@""];
    [label4_2 display];
    [label4_3 setStringValue:@""];
    [label4_3 display];
    
    [label5_0 setStringValue:@""];
    [label5_0 display];
    [label5_1 setStringValue:@""];
    [label5_1 display];
    [label5_2 setStringValue:@""];
    [label5_2 display];
    [label5_3 setStringValue:@""];
    [label5_3 display];
    
    [label6_0 setStringValue:@""];
    [label6_0 display];
    [label6_1 setStringValue:@""];
    [label6_1 display];
    [label6_2 setStringValue:@""];
    [label6_2 display];
    [label6_3 setStringValue:@""];
    [label6_3 display];
    
    [label7_0 setStringValue:@""];
    [label7_0 display];
    [label7_1 setStringValue:@""];
    [label7_1 display];
    [label7_2 setStringValue:@""];
    [label7_2 display];
    [label7_3 setStringValue:@""];
    [label7_3 display];
    
    [label8_0 setStringValue:@""];
    [label8_0 display];
    [label8_1 setStringValue:@""];
    [label8_1 display];
    [label8_2 setStringValue:@""];
    [label8_2 display];
    [label8_3 setStringValue:@""];
    [label8_3 display];
    
    [label9_0 setStringValue:@""];
    [label9_0 display];
    [label9_1 setStringValue:@""];
    [label9_1 display];
    [label9_2 setStringValue:@""];
    [label9_2 display];
    [label9_3 setStringValue:@""];
    [label9_3 display];
    
    [label10_0 setStringValue:@""];
    [label10_0 display];
    [label10_1 setStringValue:@""];
    [label10_1 display];
    [label10_2 setStringValue:@""];
    [label10_2 display];
    [label10_3 setStringValue:@""];
    [label10_3 display];
    
    [label11_0 setStringValue:@""];
    [label11_0 display];
    [label11_1 setStringValue:@""];
    [label11_1 display];
    [label11_2 setStringValue:@""];
    [label11_2 display];
    [label11_3 setStringValue:@""];
    [label11_3 display];
    
    board = (int *)malloc(sizeof(int) * 48);
    for (int i = 0; i < 48; i++)
    {
        board[i] = 0;
    }
    
    if (!player1Human && !training)
    {
        //first move for ai
        [self upDateLabel:0 :1];
    }
}

-(IBAction) region0_0:(id)sender
{
    [self upDateLabel:0:0];
}

-(IBAction) region0_1:(id)sender
{
    [self upDateLabel:0:1];
}

-(IBAction) region0_2:(id)sender
{
    [self upDateLabel:0:2];
}

-(IBAction) region0_3:(id)sender
{
    [self upDateLabel:0:3];
}


-(IBAction) region1_0:(id)sender
{
    [self upDateLabel:1:0];
}

-(IBAction) region1_1:(id)sender
{
    [self upDateLabel:1:1];
}

-(IBAction) region1_2:(id)sender
{
    [self upDateLabel:1:2];
}

-(IBAction) region1_3:(id)sender
{
    [self upDateLabel:1:3];
}


-(IBAction) region2_0:(id)sender
{
    [self upDateLabel:2:0];
}

-(IBAction) region2_1:(id)sender
{
    [self upDateLabel:2:1];
}

-(IBAction) region2_2:(id)sender
{
    [self upDateLabel:2:2];
}

-(IBAction) region2_3:(id)sender
{
    [self upDateLabel:2:3];
}


-(IBAction) region3_0:(id)sender
{
    [self upDateLabel:3:0];
}

-(IBAction) region3_1:(id)sender
{
    [self upDateLabel:3:1];
}

-(IBAction) region3_2:(id)sender
{
    [self upDateLabel:3:2];
}

-(IBAction) region3_3:(id)sender
{
    [self upDateLabel:3:3];
}


-(IBAction) region4_0:(id)sender
{
    [self upDateLabel:4:0];
}

-(IBAction) region4_1:(id)sender
{
    [self upDateLabel:4:1];
}

-(IBAction) region4_2:(id)sender
{
    [self upDateLabel:4:2];
}

-(IBAction) region4_3:(id)sender
{
    [self upDateLabel:4:3];
}


-(IBAction) region5_0:(id)sender
{
    [self upDateLabel:5:0];
}

-(IBAction) region5_1:(id)sender
{
    [self upDateLabel:5:1];
}

-(IBAction) region5_2:(id)sender
{
    [self upDateLabel:5:2];
}

-(IBAction) region5_3:(id)sender
{
    [self upDateLabel:5:3];
}


-(IBAction) region6_0:(id)sender
{
    [self upDateLabel:6:0];
}

-(IBAction) region6_1:(id)sender
{
    [self upDateLabel:6:1];
}

-(IBAction) region6_2:(id)sender
{
    [self upDateLabel:6:2];
}

-(IBAction) region6_3:(id)sender
{
    [self upDateLabel:6:3];
}

-(IBAction) region7_0:(id)sender
{
    [self upDateLabel:7:0];
}

-(IBAction) region7_1:(id)sender
{
    [self upDateLabel:7:1];
}

-(IBAction) region7_2:(id)sender
{
    [self upDateLabel:7:2];
}

-(IBAction) region7_3:(id)sender
{
    [self upDateLabel:7:3];
}


-(IBAction) region8_0:(id)sender
{
    [self upDateLabel:8:0];
}

-(IBAction) region8_1:(id)sender
{
    [self upDateLabel:8:1];
}

-(IBAction) region8_2:(id)sender
{
    [self upDateLabel:8:2];
}

-(IBAction) region8_3:(id)sender
{
    [self upDateLabel:8:3];
}


-(IBAction) region9_0:(id)sender
{
    [self upDateLabel:9:0];
}

-(IBAction) region9_1:(id)sender
{
    [self upDateLabel:9:1];
}

-(IBAction) region9_2:(id)sender
{
    [self upDateLabel:9:2];
}

-(IBAction) region9_3:(id)sender
{
    [self upDateLabel:9:3];
}


-(IBAction) region10_0:(id)sender
{
    [self upDateLabel:10:0];
}

-(IBAction) region10_1:(id)sender
{
    [self upDateLabel:10:1];
}

-(IBAction) region10_2:(id)sender
{
    [self upDateLabel:10:2];
}

-(IBAction) region10_3:(id)sender
{
    [self upDateLabel:10:3];
}


-(IBAction) region11_0:(id)sender
{
    [self upDateLabel:11:0];
}

-(IBAction) region11_1:(id)sender
{
    [self upDateLabel:11:1];
}

-(IBAction) region11_2:(id)sender
{
    [self upDateLabel:11:2];
}

-(IBAction) region11_3:(id)sender
{
    [self upDateLabel:11:3];
}

@end
