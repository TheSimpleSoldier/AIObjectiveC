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

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize label;
@synthesize label0_0, label0_1, label0_2, label0_3, label10_0, label10_1, label10_2, label10_3, label11_0, label11_1, label11_2, label11_3, label1_0, label1_1, label1_2, label1_3;
@synthesize label2_0, label2_1, label2_2, label2_3, label3_0, label3_1, label3_2, label3_3, label4_0, label4_1, label4_2, label4_3, label5_0, label5_1, label5_2, label5_3, label6_0;
@synthesize label6_1, label6_2, label6_3, label7_0, label7_1, label7_2, label7_3, label8_0, label8_1, label8_2, label8_3, label9_0, label9_1, label9_2, label9_3;
@synthesize gameChooser, searchType;

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
    
    return allowedMove;
}

-(void) upDateLabel:(int)x :(int)y
{
    NSTextField *current;
    NSString *team = @"O";
    
    if (![self validateUserMove:x:y])
    {
        return;
    }
    
    numbOfMoves++;
    
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
    
    
    if (current != NULL)
    {
        [current setStringValue:team];
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
            else
            {
                aiMove = [AlphaBetaAI getNextMove:board:1];
            }
            [self upDateLabel:aiMove[0] :aiMove[1]];
        }
        else if (!weRX && !player2Human)
        {
            int *aiMove;
            if (searchTypeVal == 0)
            {
                aiMove = [RandomAI getNextMove:board];
            }
            else if (searchTypeVal == 1)
            {
                aiMove = [MinMaxAI getNextMove:board:2];
            }
            else
            {
                aiMove = [AlphaBetaAI getNextMove:board:2];
            }
            [self upDateLabel:aiMove[0] :aiMove[1]];
        }
        
    }
}

-(IBAction) newGame:(id)sender
{
    [self reset];
}

-(void) reset
{
    NSInteger index = [gameChooser indexOfSelectedItem];
    searchTypeVal = (int) [searchType indexOfSelectedItem];
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
    else
    {
        player1Human = FALSE;
        player2Human = TRUE;
    }
    
    numbOfMoves = 0;
    weRX = true;
    [label0_0 setStringValue:@""];
    [label0_1 setStringValue:@""];
    [label0_2 setStringValue:@""];
    [label0_3 setStringValue:@""];
    
    [label1_0 setStringValue:@""];
    [label1_1 setStringValue:@""];
    [label1_2 setStringValue:@""];
    [label1_3 setStringValue:@""];
    
    [label2_0 setStringValue:@""];
    [label2_1 setStringValue:@""];
    [label2_2 setStringValue:@""];
    [label2_3 setStringValue:@""];
    
    [label3_0 setStringValue:@""];
    [label3_1 setStringValue:@""];
    [label3_2 setStringValue:@""];
    [label3_3 setStringValue:@""];
    
    [label4_0 setStringValue:@""];
    [label4_1 setStringValue:@""];
    [label4_2 setStringValue:@""];
    [label4_3 setStringValue:@""];
    
    [label5_0 setStringValue:@""];
    [label5_1 setStringValue:@""];
    [label5_2 setStringValue:@""];
    [label5_3 setStringValue:@""];
    
    [label6_0 setStringValue:@""];
    [label6_1 setStringValue:@""];
    [label6_2 setStringValue:@""];
    [label6_3 setStringValue:@""];
    
    [label7_0 setStringValue:@""];
    [label7_1 setStringValue:@""];
    [label7_2 setStringValue:@""];
    [label7_3 setStringValue:@""];
    
    [label8_0 setStringValue:@""];
    [label8_1 setStringValue:@""];
    [label8_2 setStringValue:@""];
    [label8_3 setStringValue:@""];
    
    [label9_0 setStringValue:@""];
    [label9_1 setStringValue:@""];
    [label9_2 setStringValue:@""];
    [label9_3 setStringValue:@""];
    
    [label10_0 setStringValue:@""];
    [label10_1 setStringValue:@""];
    [label10_2 setStringValue:@""];
    [label10_3 setStringValue:@""];
    
    [label11_0 setStringValue:@""];
    [label11_1 setStringValue:@""];
    [label11_2 setStringValue:@""];
    [label11_3 setStringValue:@""];
    
    board = (int *)malloc(sizeof(int) * 48);
    for (int i = 0; i < 48; i++)
    {
        board[i] = 0;
    }
    
    if (!player1Human)
    {
        //int *aiMove = [RandomAI getNextMove:board];
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
