//
//  GameScene.m
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    MainMenu *mainMenu;
    Sound *sound;
    NSMutableArray<Bubble *> *bubbleArr;
    NSMutableArray<Bubble *> *tappedBubbles;
    SKSpriteNode *menu;
    SKLabelNode *countDownLabel;
    SKNode *pressedNode;
    CGFloat width;
    CGFloat height;
    Boolean gameHasStarted;
    Boolean gameIsOver;
    Boolean inMainMenu;
    Boolean startPressed;
    Boolean backPressed;
    Boolean settingsPressed;
    Boolean helpPressed;
    SKLabelNode *timerLabel;
    SKLabelNode *scoreLabel;
    SKLabelNode *comboLabel;
    SKLabelNode *secondsLabel;
    SKLabelNode *maxBubblesLabel;
    SKLabelNode *highestScoreLabel;
    SKLabelNode *settingsNameLabel;
    int secondsSet;
    int secondCount;
    int maxBubblesSet; 
    int count;
    int score;
    int combo;
    int highestScore;
}

@synthesize height;
@synthesize width;
@synthesize currentPlayer;
@synthesize playerNameEntered;

/**
 *  Initial program setup.
 */
- (void)didMoveToView:(SKView *)view {
    // initial values.
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    secondsSet = 60;
    maxBubblesSet = 15;
    
    // initial methods.
    [self retrieveDefaults];
    [self initialiseObjects];
    [self handleMainMenu];
}

//MARK: - Touches Methods.

/**
 *  Following two methods handle pressing down and releasing touch on screen.
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode: self];
    if ([[menu childNodeWithName: @"startButton"] containsPoint: point] && !gameHasStarted) {
        pressedNode = [menu childNodeWithName: @"startButton"];
        startPressed = true;
    } else if ([[menu childNodeWithName: @"backButton"] containsPoint: point]) {
        pressedNode = [menu childNodeWithName: @"backButton"];
        backPressed = true;
    } else if ([[menu childNodeWithName: @"settingsButton"] containsPoint: point] && !gameHasStarted) {
        pressedNode = [menu childNodeWithName: @"settingsButton"];
        settingsPressed = true;
    } else if ([[menu childNodeWithName: @"helpButton"] containsPoint: point] && !gameHasStarted) {
        pressedNode = [menu childNodeWithName: @"helpButton"];
        helpPressed = true;
    } else if (gameHasStarted) {
        [self delegateBubbleTouch: point];
    } else {
        pressedNode = nil;
    }
    
    [Helpers scaleButton: pressedNode : true];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (startPressed) {
        [self handleCountDown];
        startPressed = false;
        [sound playButtonSound];
    }
    if (backPressed) {
        [self handleMainMenu];
        backPressed = false;
        [sound playButtonSound];
    }
    if (settingsPressed) {
        [self handleSettingsMenu];
        settingsPressed = false;
        [sound playButtonSound];
    }
    if (helpPressed) {
        [self handleHelpMenu];
        helpPressed = false;
        [sound playButtonSound];
    }
    [Helpers scaleButton: pressedNode : false];
}

//MARK: - Class Body.

/**
 *  Method initialises all objects needed.
 */
- (void)initialiseObjects {
    width = self.frame.size.width;
    height = self.frame.size.height;
    mainMenu = [[MainMenu alloc] initWithName: width : height];
    sound = [[Sound alloc] init];
    bubbleArr = [[NSMutableArray alloc] init];
    tappedBubbles = [[NSMutableArray alloc] init];
}

/**
 *  This method retreives all needed values from NSUSerDefaults.
 */
- (void)retrieveDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults valueForKey: @"timeSeconds"] intValue]) {
        secondsSet = [[defaults valueForKey: @"timeSeconds"] intValue];
    }
    if ([[defaults valueForKey: @"maxBubbles"] intValue]) {
        maxBubblesSet = [[defaults valueForKey: @"maxBubbles"] intValue];
    }
    if ([[defaults valueForKey: @"enteredName"] UTF8String]) {
        playerNameEntered = [defaults stringForKey: @"enteredName"];
    } else {
        playerNameEntered = @"player";
    }
    if (secondsSet == 0) { [Helpers setNumberDefault: @"timeSeconds" : [NSNumber numberWithInteger: 60]];}
    if (maxBubblesSet == 0) { [Helpers setNumberDefault: @"maxBubbles" : [NSNumber numberWithInteger: 15]];}
    
    if ([NSKeyedUnarchiver unarchiveObjectWithData: [defaults objectForKey: @"currentPlayer"]]) {
        currentPlayer = [NSKeyedUnarchiver unarchiveObjectWithData: [defaults objectForKey: @"currentPlayer"]];
    } else {
        [ScoreBoard handleNewScoreEntry: [[Player alloc] initWithName: playerNameEntered: 0]];
    }
    [defaults synchronize];
}

/**
 *  The following five methods handle the different app menu states
 *  (menu, settings, help, gamestart, gameover).
 */
- (void)handleMainMenu {
    [_nameField removeFromSuperview];
    [_secondsSlider removeFromSuperview];
    [_maxBubblesSlider removeFromSuperview];
    [menu removeFromParent];
    gameHasStarted = false;
    gameIsOver = true;
    inMainMenu = true;
    menu = [mainMenu createMenu];
    [self addChild: menu];
}

- (void)handleSettingsMenu {
    [self retrieveDefaults];
    inMainMenu = false;
    [menu removeFromParent];
    menu = [mainMenu createSettingsMenu];
    secondsLabel = [[SKLabelNode alloc] init];
    maxBubblesLabel = [[SKLabelNode alloc] init];
    settingsNameLabel = [[SKLabelNode alloc] init];
    
    settingsNameLabel = [Helpers configureLabelNode: settingsNameLabel : (width / 18.75) : CGPointMake(0, (height / 3.5)) : @"your name"];
    secondsLabel = [Helpers configureLabelNode: secondsLabel : (width / 18.75) : CGPointMake(0, (height / 12)) : [NSString stringWithFormat: @"seconds: %i", secondsSet]];
    maxBubblesLabel = [Helpers configureLabelNode: maxBubblesLabel : (width / 18.75) : CGPointMake(0, -(height / 10)) : [NSString stringWithFormat: @"max bubbles: %i", maxBubblesSet]];

    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, (width / 2), (height / 18))];
    _nameField.textColor = [UIColor grayColor];
    _nameField.font = [UIFont fontWithName:@"Silkscreen" size: (int)(width / 18.75)];
    _nameField.backgroundColor=[UIColor whiteColor];
    _nameField.center = CGPointMake(self.view.center.x, (height / 3.3));
    _nameField.text = playerNameEntered;
    
    _secondsSlider = [[UISlider alloc] initWithFrame: CGRectMake(0,0, (width / 2), (height / 33.35))];
    [_secondsSlider setMinimumValue: 10];
    [_secondsSlider setMaximumValue: 120];
    [_secondsSlider setValue: secondsSet];
    _secondsSlider.center = CGPointMake(self.view.center.x, (height / 2));
    [_secondsSlider addTarget:self action:@selector(secondsSliderMoved:) forControlEvents:UIControlEventValueChanged];
    
    _maxBubblesSlider = [[UISlider alloc] initWithFrame: CGRectMake(0, 0,  (width / 2), (height / 33.35))];
    [_maxBubblesSlider setMinimumValue: 10];
    [_maxBubblesSlider setMaximumValue: 30];
    [_maxBubblesSlider setValue: maxBubblesSet];
    _maxBubblesSlider.center = CGPointMake(self.view.center.x, (height / 1.46));
    [_maxBubblesSlider addTarget:self action:@selector(maxBubblesSliderMoved:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview: _nameField];
    [self.view addSubview: _secondsSlider];
    [self.view addSubview: _maxBubblesSlider];
    [menu addChild: settingsNameLabel];
    [menu addChild: secondsLabel];
    [menu addChild: maxBubblesLabel];
    _nameField.delegate = self;
    [self addChild: menu];
}

- (void)handleHelpMenu {
    [menu removeFromParent];
    menu = [mainMenu createHelpMenu];
    [self addChild: menu];
}

- (void)handleGameStart {
    [self retrieveDefaults];
    highestScore = [ScoreBoard getHighestScore];
    menu = [self createInGameMenu];
    [self createWalls];
    gameIsOver = false;
    [self handleNameEntry];
    [self addChild: menu];
    [self startGameTimer];
}

- (void)handleGameOver {
    [self retrieveDefaults];
    [self updateCharacter];
    [self removeAllChildren];
    [self removeAllActions];
    gameIsOver = true;
    gameHasStarted = false;
    menu = [mainMenu createGameOverMenu: playerNameEntered];
    [self addChild: menu];
    [bubbleArr removeAllObjects];
    [tappedBubbles removeAllObjects];
    score = 0;
}

/**
 *  Following method attempts to add a current player, catches exception if player object doesn't exist.
 */
-(void) updateCharacter {
    @try {
        [currentPlayer updateCharacter: score];
    }
    @catch (NSException *e) {
        NSLog(@"**Info: Missing current player, could not update.");
    }

}

/**
 *  This method handles ensuring player name is valid and that there is a name to use, correspondingly updates the
 *  current player.
 */
- (void)handleNameEntry {
    if ([playerNameEntered isEqualToString: currentPlayer.name] || [ScoreBoard matchesPlayer: playerNameEntered]) {
        currentPlayer = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: playerNameEntered]];
    } else if (playerNameEntered && !([playerNameEntered length] == 0)) {
        currentPlayer = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: playerNameEntered]];
    } else {
        playerNameEntered = @"player";
        currentPlayer = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"player"]];
    }
    if (![ScoreBoard matchesPlayer: playerNameEntered]) {
        [ScoreBoard handleNewScoreEntry: [[Player alloc] initWithName: playerNameEntered: 0]];
    } else {
        [currentPlayer updateCharacter: 0];
    }
}

/**
 *  This method starts the initial game countdown timer before round started.
 */
- (void)handleCountDown {
    gameHasStarted = true;
    [menu removeFromParent];
    count = 3;
    countDownLabel = [[SKLabelNode alloc] init];
    countDownLabel = [Helpers configureLabelNode: countDownLabel : (int)(width / 5) : CGPointMake(0, 0) : @"3"];
    [self addChild:countDownLabel];
    NSTimer *countDownTimer = [NSTimer timerWithTimeInterval: 0.55 target: self selector: @selector(handleCountDownSecond:) userInfo: nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer: countDownTimer forMode:NSRunLoopCommonModes];
    [sound playCountDown];
}

/**
 *  This method runs for every countdown second before game started.
 */
- (void)handleCountDownSecond: (NSTimer *)timer {
    if (count == 1) {
        [timer invalidate];
        [countDownLabel removeFromParent];
        [self handleGameStart];
    } else {
        count--;
        [self runAction: [Helpers changeLabel: count : countDownLabel]];
    }
}

/**
 *  This method starts the timer for the game.
 */
- (void)startGameTimer {
    gameHasStarted = true;
    secondCount = secondsSet;
    NSTimer *gameTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(handleGameSecond:) userInfo: nil repeats: true];
    [[NSRunLoop currentRunLoop] addTimer: gameTimer forMode:NSRunLoopCommonModes];
}

/** 
 *  This method runs every game second.
 */
- (void)handleGameSecond: (NSTimer *)timer {
    if (secondCount == 0) {
        [timer invalidate];
        [self handleGameOver];
    } else {
        secondCount--;
        int bubblesToAdd = arc4random_uniform((int)maxBubblesSet);  // get random amount of bubbles.
        for (int i = 0; i < bubblesToAdd; i++) { [self createOneBubble]; }  // create all new bubbles.
        if(secondCount <= 20) { timerLabel.fontColor = [UIColor redColor];}
        timerLabel.text = [NSString stringWithFormat: @"%02d", secondCount];
        [self removeRandom: bubblesToAdd];
    }
}

/**
 *  Method simply initiated a new bubble and adds it to self and 
 *  bubbleArr.
 */
- (void)createOneBubble {
    if (bubbleArr.count >= maxBubblesSet) { return; }
    Bubble *thisBubble = [[Bubble alloc] initWithName: width: height];
    [self addChild: thisBubble];
    [bubbleArr addObject: thisBubble];
}

/**
 *  This method selects a random number within the bounds of the bubbleArr to remove and
 *  does so accordingly.
 */
- (void)removeRandom: (int)amountAdded {
    if ((int)bubbleArr.count == 0) { return; }
    int bubblesToRemove = arc4random_uniform((int)bubbleArr.count / 2);
    for (int i = 0; i < bubblesToRemove - 1; i++) {
        [self decideMovePoint: [bubbleArr objectAtIndex: i]];
        [bubbleArr removeObjectAtIndex: i];
    }
}

/**
 *  This method decides to which side of the screen a bubble should shoot off to when tapped.
 */
- (void)decideMovePoint: (Bubble *)bubble {
    bubble.physicsBody = nil;
    if (bubble.position.x > 0 && bubble.position.y < height / 5) {
        [Bubble animateToPos: CGPointMake(width, bubble.position.y) : bubble];
    } else if (bubble.position.x < 0 && bubble.position.y > -(height / 5)) {
        [Bubble animateToPos: CGPointMake(-width, bubble.position.y) : bubble];
    } else if (bubble.position.y > height / 5) {
        [Bubble animateToPos: CGPointMake(bubble.position.x, height) : bubble];
    } else {
        [Bubble animateToPos: CGPointMake(bubble.position.x, -height) : bubble];
    }
}

/**
 *  This method creates the in game menu dispay, e.g score and second count.
 */
- (SKSpriteNode *)createInGameMenu {
    CGSize menuS = CGSizeMake( width, height);
    SKSpriteNode *gameMenu = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    timerLabel = [[SKLabelNode alloc] init];
    timerLabel = [Helpers configureLabelNode: timerLabel : (width / 15) : CGPointMake(0, (height / 2.425)) : [NSString stringWithFormat: @"%i", secondsSet]];
    timerLabel.fontColor = [UIColor yellowColor];
    scoreLabel = [[SKLabelNode alloc] init];
    scoreLabel = [Helpers configureLabelNode: scoreLabel : (width / 15) : CGPointMake((width / 2.5), (height / 2.425)): @"0"];
    comboLabel = [[SKLabelNode alloc] init];
    comboLabel = [Helpers configureLabelNode: comboLabel : (width / 18.75) : CGPointMake(0, (height / 2.7)) : @""];
    comboLabel.alpha = 0;
    highestScoreLabel = [[SKLabelNode alloc] init];
    highestScoreLabel = [Helpers configureLabelNode: highestScoreLabel : (width / 15) : CGPointMake(-(width / 3), (height / 2.425)) : [NSString stringWithFormat: @"hs:%i", highestScore]];
    [gameMenu addChild: comboLabel];
    [gameMenu addChild: timerLabel];
    [gameMenu addChild: scoreLabel];
    [gameMenu addChild: highestScoreLabel];
    return gameMenu;
}

/**
 *  Following two methods increment values and update corresponding labels.
 */
- (void)incrementScore: (int)scoreToAdd {
    score += scoreToAdd;
    NSString *currentScore = [NSString stringWithFormat: @"%i", score];
    scoreLabel.text = currentScore;
    if (score > highestScore) {
        highestScoreLabel.text = [NSString stringWithFormat: @"hs:%i", score];
    }
}

- (void)incrementCombo {
    combo++;
    [comboLabel removeAllActions];
    NSString *currentCombo = [NSString stringWithFormat: @"combo %i x 1.5", combo];
    comboLabel.alpha = 0;
    comboLabel.text = currentCombo;
    [Helpers animateComboSequence: comboLabel];
}



/**
 *  This method checks if the last object in tapped bubbles has same multiplier, if so
 *  then we add scores * 1.5.
 */
- (void)handleBubbleMultipliers: (Bubble *)tappedBubble {
    if ([tappedBubbles lastObject].scoreMultiplier == tappedBubble.scoreMultiplier) {
        [self incrementScore: (int)(tappedBubble.scoreMultiplier * 1.5)];
        [self incrementCombo];
    } else {
        [self incrementScore: tappedBubble.scoreMultiplier];
        combo = 0;
    }
}

/**
 *  This method creates the bounding walls of the screen so no bubbles go off screen.
 */
- (void)createWalls {
    SKSpriteNode *leftWall = [SKSpriteNode spriteNodeWithColor: [UIColor blueColor] size: CGSizeMake(width / 25, height)];
    SKSpriteNode *rightWall = [SKSpriteNode spriteNodeWithColor: [UIColor blueColor] size: CGSizeMake(width / 25, height)];
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size: CGSizeMake(width, height / 50)];
    SKSpriteNode *bottomWall = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size: CGSizeMake(width, height / 50)];
    leftWall = [Helpers configureSpriteNode: leftWall : CGPointMake( -(width / 2) - leftWall.frame.size.width / 2, 0)];
    rightWall = [Helpers configureSpriteNode: rightWall : CGPointMake( (width / 2) + leftWall.frame.size.width / 2, 0)];
    topWall = [Helpers configureSpriteNode: topWall : CGPointMake(0, (height / 2) + topWall.frame.size.height / 2)];
    bottomWall = [Helpers configureSpriteNode: bottomWall : CGPointMake(0, -(height / 2) - bottomWall.frame.size.height / 2)];
    [self addChild: leftWall];
    [self addChild: rightWall];
    [self addChild: topWall];
    [self addChild: bottomWall];
}

//MARK: - Delegate methods.

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    self.playerNameEntered = textField.text;
    [[NSUserDefaults standardUserDefaults] setValue: playerNameEntered forKey: @"enteredName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (void)delegateBubbleTouch: (CGPoint)location {  // custom written delegate (detect bubble touched).
    Bubble *tappedBubble;
    for (Bubble *bubble in bubbleArr) {
        if ([bubble containsPoint: location] && [bubble parent]) {
            tappedBubble = bubble;
            [sound playPopSound];
            [self handleBubbleMultipliers: bubble];
            [tappedBubbles addObject: bubble];
            [self decideMovePoint: bubble];
        }
    }
    [bubbleArr removeObject: tappedBubble];
}

- (IBAction)secondsSliderMoved: (id)sender {
    UISlider * slider = (UISlider*)sender;
    secondsSet = (int)[slider value];
    secondsLabel.text = [NSString stringWithFormat: @"seconds: %i", secondsSet];
    [Helpers setNumberDefault: @"timeSeconds" : [NSNumber numberWithInteger: secondsSet]];
}

- (IBAction)maxBubblesSliderMoved: (id)sender {
    UISlider * slider = (UISlider*)sender;
    maxBubblesSet = (int)[slider value];
    maxBubblesLabel.text = [NSString stringWithFormat: @"max bubbles: %i", maxBubblesSet];
    [Helpers setNumberDefault: @"maxBubbles" : [NSNumber numberWithInteger: maxBubblesSet]];
}

@end
