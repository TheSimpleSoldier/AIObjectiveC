//
//  RootViewController.h
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/14/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RootViewController : NSViewController
{
    IBOutlet NSTextField *label;
    IBOutlet NSPopUpButton *gameChooser;
    IBOutlet NSPopUpButton *searchType;
    IBOutlet NSPopUpButton *heuristic;
    IBOutlet NSTextField *searchDepth;
    IBOutlet NSPopUpButton *searchType2;
    IBOutlet NSPopUpButton *heuristic2;
    IBOutlet NSTextField *searchDepth2;
    IBOutlet NSButton *verbose;
    BOOL weRX;
    BOOL player1Human;
    BOOL player2Human;
    BOOL winner;
    BOOL training;
    int verboseVal;
    int *board;
    int xTeamVal;
    int oTeamVal;
    int numbOfMoves;
    int searchTypeVal;
    int searchTypeVal2;
    int heuristicVal;
    int heuristicVal2;
    int searchDepthVal;
    int searchDepthVal2;
    int neuralNet;
    int neuralNet2;
    NSTextField *current;
    
    IBOutlet NSTextField *label0_0;
    IBOutlet NSTextField *label0_1;
    IBOutlet NSTextField *label0_2;
    IBOutlet NSTextField *label0_3;
    
    IBOutlet NSTextField *label1_0;
    IBOutlet NSTextField *label1_1;
    IBOutlet NSTextField *label1_2;
    IBOutlet NSTextField *label1_3;
    
    IBOutlet NSTextField *label2_0;
    IBOutlet NSTextField *label2_1;
    IBOutlet NSTextField *label2_2;
    IBOutlet NSTextField *label2_3;
    
    IBOutlet NSTextField *label3_0;
    IBOutlet NSTextField *label3_1;
    IBOutlet NSTextField *label3_2;
    IBOutlet NSTextField *label3_3;
    
    IBOutlet NSTextField *label4_0;
    IBOutlet NSTextField *label4_1;
    IBOutlet NSTextField *label4_2;
    IBOutlet NSTextField *label4_3;
    
    IBOutlet NSTextField *label5_0;
    IBOutlet NSTextField *label5_1;
    IBOutlet NSTextField *label5_2;
    IBOutlet NSTextField *label5_3;
    
    IBOutlet NSTextField *label6_0;
    IBOutlet NSTextField *label6_1;
    IBOutlet NSTextField *label6_2;
    IBOutlet NSTextField *label6_3;
    
    IBOutlet NSTextField *label7_0;
    IBOutlet NSTextField *label7_1;
    IBOutlet NSTextField *label7_2;
    IBOutlet NSTextField *label7_3;
    
    IBOutlet NSTextField *label8_0;
    IBOutlet NSTextField *label8_1;
    IBOutlet NSTextField *label8_2;
    IBOutlet NSTextField *label8_3;
    
    IBOutlet NSTextField *label9_0;
    IBOutlet NSTextField *label9_1;
    IBOutlet NSTextField *label9_2;
    IBOutlet NSTextField *label9_3;
    
    IBOutlet NSTextField *label10_0;
    IBOutlet NSTextField *label10_1;
    IBOutlet NSTextField *label10_2;
    IBOutlet NSTextField *label10_3;
    
    IBOutlet NSTextField *label11_0;
    IBOutlet NSTextField *label11_1;
    IBOutlet NSTextField *label11_2;
    IBOutlet NSTextField *label11_3;
}

@property(nonatomic, retain) NSTextField *label;
@property(nonatomic, retain) NSPopUpButton *gameChooser;
@property(nonatomic, retain) NSPopUpButton *searchType;
@property(nonatomic, retain) NSPopUpButton *heuristic;
@property(nonatomic, retain) NSTextField *searchDepth;
@property(nonatomic, retain) NSPopUpButton *searchType2;
@property(nonatomic, retain) NSPopUpButton *heuristic2;
@property(nonatomic, retain) NSTextField *searchDepth2;
@property(nonatomic, retain) NSButton *verbose;

@property(nonatomic, retain) NSTextField *label0_0;
@property(nonatomic, retain) NSTextField *label0_1;
@property(nonatomic, retain) NSTextField *label0_2;
@property(nonatomic, retain) NSTextField *label0_3;

@property(nonatomic, retain) NSTextField *label1_0;
@property(nonatomic, retain) NSTextField *label1_1;
@property(nonatomic, retain) NSTextField *label1_2;
@property(nonatomic, retain) NSTextField *label1_3;

@property(nonatomic, retain) NSTextField *label2_0;
@property(nonatomic, retain) NSTextField *label2_1;
@property(nonatomic, retain) NSTextField *label2_2;
@property(nonatomic, retain) NSTextField *label2_3;

@property(nonatomic, retain) NSTextField *label3_0;
@property(nonatomic, retain) NSTextField *label3_1;
@property(nonatomic, retain) NSTextField *label3_2;
@property(nonatomic, retain) NSTextField *label3_3;

@property(nonatomic, retain) NSTextField *label4_0;
@property(nonatomic, retain) NSTextField *label4_1;
@property(nonatomic, retain) NSTextField *label4_2;
@property(nonatomic, retain) NSTextField *label4_3;

@property(nonatomic, retain) NSTextField *label5_0;
@property(nonatomic, retain) NSTextField *label5_1;
@property(nonatomic, retain) NSTextField *label5_2;
@property(nonatomic, retain) NSTextField *label5_3;

@property(nonatomic, retain) NSTextField *label6_0;
@property(nonatomic, retain) NSTextField *label6_1;
@property(nonatomic, retain) NSTextField *label6_2;
@property(nonatomic, retain) NSTextField *label6_3;

@property(nonatomic, retain) NSTextField *label7_0;
@property(nonatomic, retain) NSTextField *label7_1;
@property(nonatomic, retain) NSTextField *label7_2;
@property(nonatomic, retain) NSTextField *label7_3;

@property(nonatomic, retain) NSTextField *label8_0;
@property(nonatomic, retain) NSTextField *label8_1;
@property(nonatomic, retain) NSTextField *label8_2;
@property(nonatomic, retain) NSTextField *label8_3;

@property(nonatomic, retain) NSTextField *label9_0;
@property(nonatomic, retain) NSTextField *label9_1;
@property(nonatomic, retain) NSTextField *label9_2;
@property(nonatomic, retain) NSTextField *label9_3;

@property(nonatomic, retain) NSTextField *label10_0;
@property(nonatomic, retain) NSTextField *label10_1;
@property(nonatomic, retain) NSTextField *label10_2;
@property(nonatomic, retain) NSTextField *label10_3;

@property(nonatomic, retain) NSTextField *label11_0;
@property(nonatomic, retain) NSTextField *label11_1;
@property(nonatomic, retain) NSTextField *label11_2;
@property(nonatomic, retain) NSTextField *label11_3;

-(IBAction) newGame:(id)sender;
-(IBAction) neuralNetTest:(id)sender;
-(IBAction) printHeuristic:(id)sender;
-(IBAction) printAvalaibleSpots:(id)sender;

-(IBAction) region0_0:(id)sender;
-(IBAction) region0_1:(id)sender;
-(IBAction) region0_2:(id)sender;
-(IBAction) region0_3:(id)sender;

-(IBAction) region1_0:(id)sender;
-(IBAction) region1_1:(id)sender;
-(IBAction) region1_2:(id)sender;
-(IBAction) region1_3:(id)sender;

-(IBAction) region2_0:(id)sender;
-(IBAction) region2_1:(id)sender;
-(IBAction) region2_2:(id)sender;
-(IBAction) region2_3:(id)sender;

-(IBAction) region3_0:(id)sender;
-(IBAction) region3_1:(id)sender;
-(IBAction) region3_2:(id)sender;
-(IBAction) region3_3:(id)sender;

-(IBAction) region4_0:(id)sender;
-(IBAction) region4_1:(id)sender;
-(IBAction) region4_2:(id)sender;
-(IBAction) region4_3:(id)sender;

-(IBAction) region5_0:(id)sender;
-(IBAction) region5_1:(id)sender;
-(IBAction) region5_2:(id)sender;
-(IBAction) region5_3:(id)sender;

-(IBAction) region6_0:(id)sender;
-(IBAction) region6_1:(id)sender;
-(IBAction) region6_2:(id)sender;
-(IBAction) region6_3:(id)sender;

-(IBAction) region7_0:(id)sender;
-(IBAction) region7_1:(id)sender;
-(IBAction) region7_2:(id)sender;
-(IBAction) region7_3:(id)sender;

-(IBAction) region8_0:(id)sender;
-(IBAction) region8_1:(id)sender;
-(IBAction) region8_2:(id)sender;
-(IBAction) region8_3:(id)sender;

-(IBAction) region9_0:(id)sender;
-(IBAction) region9_1:(id)sender;
-(IBAction) region9_2:(id)sender;
-(IBAction) region9_3:(id)sender;

-(IBAction) region10_0:(id)sender;
-(IBAction) region10_1:(id)sender;
-(IBAction) region10_2:(id)sender;
-(IBAction) region10_3:(id)sender;

-(IBAction) region11_0:(id)sender;
-(IBAction) region11_1:(id)sender;
-(IBAction) region11_2:(id)sender;
-(IBAction) region11_3:(id)sender;

//-(void) upDateChangedStates();

-(BOOL) validateUserMove:(int)x :(int)y;
-(void) upDateLabel:(int)x :(int)y;
-(void) reset;
-(void) printBoard;
-(void) setVarsForNeuralNet;

@end
