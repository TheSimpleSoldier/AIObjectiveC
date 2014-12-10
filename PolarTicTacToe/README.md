How to Run:
	1. download client from github: $ git clone https://github.com/fredkneeland/AIObjectiveC.git
	2. Install latest version of Xcode (we have run it on OS X Maverics and Yosemite don't know about earlier versions
	3. open PolarTicTacToe.xcodeproj with xcode and run it natively as OS X app
	4. When it is running select what you want to test on the right side of the view for the AIs
	5. Press the new game button to play a game with the parameters you set

How to Train Neural Net:
The neural net training is run separately through the command line. Compile TrainNet.m. run the executable with two parameters for your in game alpha and post game alpha. It will run 5,000,000 matches, taking 1 - 3 hours depending on the machine. It will then print out the resulting net.


What we did:
	This application is the polar tic-tac-toe game created in objective c for CSCI 446 at Montana State University.  In this program we implemented strict min-max, alpha-beta, and nearest-neighbor search techniques.  We also implemented several different heuristic functions with a basic heuristic, a classifier using a decision tree, and a neural net.  We created a training program for the neural net which used 40 internal nodes and trained on 5 million matches using back propogation to improve to the point of being capable of consistently defeating college students.  In the actual app itself you can play against yourself, or against an AI as either the X or O player.  You can set the search depth, the heuristic used, and the search type.  Additionally you can kick back and watch the AI play itself or you can run various tests to see which heuristic performs better against random or if you wanted to see how the neural net at depth 3 with min-max does against the classifier at depth 4 with nearest neighbor then you are set! 
Where it is all at:
	Training/
		TrainNet.m contains the methods required to train the neural net, running main will train the net over 5 million matches with the alpha values you give it
	data/
		This directory contains the output from test runs, the average time is in nano-seconds, we ran 100 matches against the random AI, for the SearchTypeVal, 1=min-max, 2=alpha-beta, 3=nearest neighbor
		Also for the heuristic 0=base Heuristic, 1=classifier, 2=neural net, for the winner variable, 1=X and 2=O
	Images/
		This directory contains the game board image we made for this game
	PolarTicTacToe/
		This directory contains all of the code to implement the game and various AIs

		RootViewController.m
			This file contains everything for the UI and also calls the AI functions to ask for the AIs next move
		Utilities.m
			This file contains our win checkers and our methods to get and check for valid moves
		HeuristicFunctions.m
			This file contains the code for the various heuristic functions

		Search.m
			This file contains the methods for min-max, alpha-beta, and nearest neighbor.  It has two methods for each search type.  The first returns the best move and the second recrusively calculates a score for a particular move.
		Random.m
			This file contains the code to implement a random player
		MinMaxAI.m
			This file calls the minMax method in search.m and returns the move
		AlphaBeta.m
			This file calls the alpha-beta method in search.m
		NearestNeighbor.m
			This file calls the nearest neighbor method in search.m

