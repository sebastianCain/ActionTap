//
//  MainViewController.m
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "MainViewController.h"
#import "MyActionsViewController.h"
#import "ActionViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "DataAccess.h"
#import "Pattern+Pattern_Functions.h"
#import "Recorder.h"
#import "BTSSineWaveView.h"
#import "BTSSineWaveLayer.h"
#import "CreateViewController.h"
@interface MainViewController ()<RecorderDelegate>
@property Recorder *patternRecorder;
@property Recorder *backgroundRecorder;
@property UIView *currentBar;
@property NSMutableArray *allBars;
@property UIButton *touchDetector;
@property (strong, nonatomic) IBOutlet BTSSineWaveView *sineview;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshAllPatterns];
    NSLog(@"second");
    [self refreshAllPatternsForTV];
    self.allBars = [[NSMutableArray alloc]init];
	[self.view setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	
	self.page1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	self.page2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
	self.page3 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
	
	
	//SCROLL VIEW SETUP
	
	CGRect scrollViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
	self.scrollView.delegate = self;
	[self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height)];
	[self.scrollView setPagingEnabled:YES];
	self.scrollView.showsHorizontalScrollIndicator = YES;
	[self.view addSubview:self.scrollView];
	
	//PAGE CONTROL SETUP
	
	self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,15)];
	[self.pageControl setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame)-20)];
	self.pageControl.numberOfPages = 3;
	self.pageControl.currentPage = 0;
	self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
	self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
	//[self.view addSubview:self.pageControl];

	
    // Do any additional setup after loading the view.
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 100)];
	[title setText:@"jarvis"];
	[title setTextColor:[UIColor whiteColor]];
	[title setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:72]];
	[title setTextAlignment:NSTextAlignmentCenter];
	[title setCenter:CGPointMake(self.view.frame.size.width/2, 75)];
	[self.page1 addSubview:title];
	
	self.sineview = [[BTSSineWaveView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 400)];
	[self.sineview setTag:100];
	[self.sineview setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 100)];
	[self.sineview setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	[self.sineview.layer setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0].CGColor];
	[self.sineview.layer setContentsScale:[[UIScreen mainScreen] scale]];
	[self.page1 addSubview:self.sineview];
	
	[(BTSSineWaveLayer *)self.sineview.layer setAmplitude:10];
	[(BTSSineWaveLayer *)self.sineview.layer setFrequency:0.01];
	[(BTSSineWaveLayer *)self.sineview.layer setPhase:1];
	
	[self.sineview.layer setNeedsDisplay];

	
	UIImageView *bgimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"willsmith.png"]];
	[bgimage setFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2-30, self.view.frame.size.width, self.view.frame.size.width)];
	[bgimage setContentMode:UIViewContentModeScaleAspectFill];
	
	CAGradientLayer *l = [CAGradientLayer layer];
	l.frame = bgimage.bounds;
	l.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
	l.startPoint = CGPointMake(0.5f, 0.5f);
	l.endPoint = CGPointMake(0.5f, 1.0f);
	bgimage.layer.mask = l;
	[self.page1 addSubview:bgimage];
	
	NSLog(@"%@", bgimage);
	//int swaggyp = (self.view.frame.size.width-80)/3;
	/*
	UIButton *newAction = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[newAction.layer setCornerRadius:swaggyp/2];
	[newAction.layer setBorderWidth:2];
	[newAction.layer setBorderColor:[UIColor whiteColor].CGColor];
	[newAction.layer setMasksToBounds:YES];
	[newAction.titleLabel setNumberOfLines:2];
	[newAction setTitle:@"new\naction" forState:UIControlStateNormal];
	[newAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[newAction.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[newAction.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[newAction setCenter:CGPointMake(self.view.frame.size.width/2-swaggyp-20, self.view.frame.size.height-70)];
	[newAction addTarget:self action:@selector(newAction) forControlEvents:UIControlEventTouchUpInside];
	[self.page1 addSubview:newAction];
	
	UIButton *myActions = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[myActions.layer setCornerRadius:swaggyp/2];
	[myActions.layer setBorderWidth:2];
	[myActions.layer setBorderColor:[UIColor whiteColor].CGColor];
	[myActions.layer setMasksToBounds:YES];
	[myActions.titleLabel setNumberOfLines:2];
	[myActions setTitle:@"my\nactions" forState:UIControlStateNormal];
	[myActions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[myActions.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[myActions.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[myActions setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-70)];
	[myActions addTarget:self action:@selector(myActions) forControlEvents:UIControlEventTouchUpInside];
	[self.page1 addSubview:myActions];
	
	UIButton *settings = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[settings.layer setCornerRadius:swaggyp/2];
	[settings.layer setBorderWidth:2];
	[settings.layer setBorderColor:[UIColor whiteColor].CGColor];
	[settings.layer setMasksToBounds:YES];
	[settings.titleLabel setNumberOfLines:2];
	[settings setTitle:@"settings" forState:UIControlStateNormal];
	[settings setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[settings.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[settings.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[settings setCenter:CGPointMake(self.view.frame.size.width/2+swaggyp+20, self.view.frame.size.height-70)];
	[settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
	[self.page1 addSubview:settings];
	
	*/
	
	//PAGE 2
	
	
	UIView *coverView2 = [[UIView alloc]initWithFrame: self.view.frame];
	[coverView2 setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	[self.page2 addSubview:coverView2];
	
	UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, self.view.frame.size.height - 250)];
	[tableView setDataSource:self];
	[tableView setDelegate:self];
	[tableView setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	self.tableView = tableView;
	[self.page2 addSubview:tableView];

	//PAGE 3
	
	
	UIView *coverView3 = [[UIView alloc]initWithFrame: self.view.frame];
	[coverView3 setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	[self.page3 addSubview:coverView3];
	
	UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
	title3.text = @"Action";
	title3.textAlignment = NSTextAlignmentCenter;
	title3.font = [UIFont boldSystemFontOfSize:40];
	[self.page3 addSubview:title3];
	
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width-40, 40)];
    [tf setDelegate:self];
    [tf setPlaceholder:@"put action name here"];
    [tf setTintColor:[UIColor whiteColor]];
    [tf setTextColor:[UIColor whiteColor]];
    [tf setTextAlignment:NSTextAlignmentCenter];
    [tf.layer setCornerRadius:10.0];
    [tf.layer setMasksToBounds:YES];
    [tf.layer setBorderWidth:2.0];
    [tf.layer setBorderColor:[UIColor whiteColor].CGColor];
    [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.page3 addSubview:tf];
    self.textField = tf;
    
    
	UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, self.view.frame.size.height*2/3, 80, 80)];
    [startButton setImage:[UIImage imageNamed:@"recordButton"] forState:UIControlStateNormal];
	[startButton addTarget:self action:@selector(startRecordingNewPattern) forControlEvents:UIControlEventTouchUpInside];
	self.startButton = startButton;
	[self.page3 addSubview:startButton];
    
    UIButton *calibrateButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, self.view.frame.size.height - 40, 80, 80)];
    [calibrateButton setImage:[UIImage imageNamed:@"calibrateButton"] forState:UIControlStateNormal];
    [calibrateButton addTarget:self action:@selector(startRecordingNewPattern) forControlEvents:UIControlEventTouchUpInside];
    [self.page3 addSubview:calibrateButton];
    
    UIButton *actionsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height*(2/3), 200, 100)];
    actionsButton.backgroundColor  = [UIColor blueColor];
    [actionsButton addTarget:self action:@selector(showActions) forControlEvents:UIControlEventTouchUpInside];
    self.actionsButton = actionsButton;
    [self.page3 addSubview:actionsButton];
	
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 170, self.view.frame.size.width/2-40, 40)];
    confirmButton.titleLabel.text = @"Confirm Changes?";
    [self.page3 addSubview: confirmButton];
    [confirmButton addTarget:self action:@selector(confirmChanges) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.backgroundColor = [UIColor greenColor];
    self.confirmButton = confirmButton;
    
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20+self.view.frame.size.width/2, 170, self.view.frame.size.width/2-40, 40)];
    cancelButton.titleLabel.text = @"Confirm Changes?";
    [self.page3 addSubview: cancelButton];
    [cancelButton addTarget:self action:@selector(cancelChanges) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor = [UIColor redColor];
    self.cancelButton = cancelButton;
	
	self.currentBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-50, 4, 100)];
	self.currentBar.backgroundColor = [UIColor redColor];
	[self.page3 addSubview:self.currentBar];
	
    UIButton *touchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.page3.frame.size.width, self.page3.frame.size.height)];
    touchButton.userInteractionEnabled = NO;
    [self.page3 addSubview:touchButton];
    [touchButton addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //touchButton.backgroundColor= [UIColor redColor];
    self.touchDetector = touchButton;
	
	[self.scrollView addSubview:self.page1];
	[self.scrollView addSubview:self.page2];
	[self.scrollView addSubview:self.page3];
    
    //Recorder set up
    self.patternRecorder = [[Recorder alloc] init];
    self.patternRecorder.delegate = self;
    self.backgroundRecorder = [[Recorder alloc]init];
    self.backgroundRecorder.delegate = self;
    
    
    if (self.shouldJumpToPage3) {
        [self jumpToPage3];
    }
    
    NSManagedObjectContext *context = [DataAccess context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
    NSArray *allPatterns = [context executeFetchRequest:request error:nil];
    Pattern *backgroundPattern;
    for(Pattern *p in allPatterns ) {
        if([p.name isEqualToString:@"BackgroundPattern"]){
            backgroundPattern = p;
        }
    }
    if (!backgroundPattern) {
        backgroundPattern =[NSEntityDescription insertNewObjectForEntityForName:@"Pattern" inManagedObjectContext:context];
        backgroundPattern.name= @"BackgroundPattern";
    }
    self.backgroudPattern = backgroundPattern;
    
    [self startRecordingInBackground];
    
    [self comparePattern:nil withPattern:nil];
}

-(void)jumpToPage3{
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width*2, 0)];
    self.scrollLock = YES;
}
-(void)showActions {
    [self performSegueWithIdentifier:@"showCreate" sender:self];
    
}

-(void)confirmChanges{
    if ([self.pickedPattern.name isEqualToString:@""]) {
        NSLog(@"Please name your pattern");
        return;
    }
    [self.textField resignFirstResponder];
    [self refreshAllPatternsForTV];
    self.editingPattern = NO;
    self.scrollLock = NO;
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    [[DataAccess sharedInstance] saveContext];
    [self.tableView reloadData];
}

-(void)cancelChanges{
    self.scrollLock = NO;
    [self.textField resignFirstResponder];
    [self refreshActionPage];
}


- (IBAction)updateAmplitude:(id)sender
{
	BTSSineWaveLayer *layer = [self sineWaveLayer];
	float amplitude = [(UISlider *)sender value];
	[layer setAmplitude:(CGFloat)amplitude];
	[layer setNeedsDisplay];
}

- (IBAction)updateFrequency:(id)sender
{
	BTSSineWaveLayer *layer = [self sineWaveLayer];
	float frequency = [(UISlider *)sender value];
	[layer setFrequency:(CGFloat)frequency];
	[layer setNeedsDisplay];
}

- (IBAction)updatePhase:(id)sender
{
	BTSSineWaveLayer *layer = [self sineWaveLayer];
	float phase = [(UISlider *)sender value];
	[layer setPhase:(CGFloat)phase];
	[layer setNeedsDisplay];
}

- (BTSSineWaveLayer *)sineWaveLayer
{
	return (BTSSineWaveLayer *)[[[self view] viewWithTag:100] layer];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrolling");
    if (self.scrollLock) {
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage *self.view.frame.size.width, 0);
        return;
    }
    if (self.pageControl.currentPage !=0) {
        [self.backgroundRecorder stopRecording];
    }
    
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
    
    if (self.pageControl.currentPage==1) {
        self.pickedPatternName = @"";
        [self refreshAllPatternsForTV];
        
    }
    
    if (self.pageControl.currentPage ==2){
        [self refreshActionPage];
        [self refreshAllPatterns];
        NSManagedObjectContext *context = [DataAccess context];
        Pattern *pattern;
        if (![self.pickedPattern.name isEqualToString:self.pickedPatternName]) {
            if (self.patternPicked) {
                NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
                NSArray *all = [context executeFetchRequest:request error:nil];
                for(Pattern* p in all) {
                    if ([p.name isEqualToString:self.pickedPatternName]) {
                        pattern = p;
                    }
                }
            }else if([self.pickedPatternName isEqualToString:@""]){
                pattern = [NSEntityDescription insertNewObjectForEntityForName:@"Pattern" inManagedObjectContext:context];
                pattern.name = @"";
            }
            self.pickedPattern = pattern;
        }
        [self refreshActionPage];
        [self refreshAllPatterns];
    }
    NSLog(@"scrolling- %d",self.pageControl.currentPage);
    

 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.pickedPatternName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
     self.patternPicked = YES;
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width*2, 0)animated:NO];
    [self refreshLines];
}

-(void)refreshActionPage{
    NSLog(@"refreshActionPage");
    self.textField.text= self.pickedPattern.name;
}

#pragma mark - Text View


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.pickedPattern.name = textField.text;
    return YES;
}

-(void)textFieldDidChange:(UITextField*)textField{
    self.pickedPattern.name = textField.text;
    self.pickedPatternName = textField.text;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.scrollLock = YES;
    self.editingPattern = YES;
    self.pickedPattern.name = textField.text;
}

-(void)setEditingPattern:(BOOL)editingPattern
{
    _editingPattern = editingPattern;
    if (_editingPattern) {
        self.scrollLock =YES;
    }
    
}

#pragma mark - Table View

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatternCell"];
    Pattern  *pattern = [self.allPatternsForTV objectAtIndex:indexPath.row];
    cell.textLabel.text =pattern.name;
	
	[cell setTag: indexPath.row];
	
	[cell setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];

	UIView *bgColorView = [[UIView alloc] initWithFrame:cell.frame];

    bgColorView.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    //[cell setBackgroundView:bgColorView];
	[cell setSelectedBackgroundView:bgColorView];
	[cell.textLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[cell.textLabel setTextColor:[UIColor whiteColor]];
	//[cell setBackgroundColor:[UIColor whiteColor]];
	
	
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [self.allPatternsForTV count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50.0f;
}




-(void)newAction {
	[self performSegueWithIdentifier:@"maintoaction" sender:@"new"];
}

-(void)myActions {
	[self performSegueWithIdentifier:@"maintoactions" sender:nil];
}

-(void)settings {
	[self performSegueWithIdentifier:@"maintosettings" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshAllPatterns{
    NSLog(@"refresh patterns");
    NSManagedObjectContext *context = [DataAccess context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
    NSError *error;
    NSArray *tempAll = [context executeFetchRequest:request error:&error];
    self.allPatterns = [[NSMutableDictionary alloc]init];
    for (Pattern *p in tempAll) {
        [self.allPatterns  setValue:p forKey:p.name];
    }
    [[DataAccess sharedInstance]saveContext];
    
}

-(void)recordingFinishedForPatternIsBackground:(BOOL)background{
    if (background) {
        NSLog(@"FINISHED");
        [self.backgroundRecorder stopRecording];
        
        [self compare];
        
        
        
    }else{
        [self refreshLines];

    }
}
-(void)compare{
    NSManagedObjectContext *context = [DataAccess context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
    NSMutableArray *allPatterns = [context executeFetchRequest:request error:nil];
    
}
-(void)refreshLines{
    NSLog(@"refresh lines");
    NSData *test = self.pickedPattern.allTaps;
    if (test ==[NSNull null]) {
        NSLog(@"First Null");
    }
    if (test == nil) {
        NSLog(@"Second nil");
    }
   
    NSLog(self.pickedPattern.name);
    NSArray *allTaps =[NSKeyedUnarchiver unarchiveObjectWithData:self.pickedPattern.allTaps];
    for (UIView *v in self.allBars) {
        [v removeFromSuperview];
    }
    if ([allTaps count]==300) {
        for (UIView *v in self.allBars) {
            [v removeFromSuperview];
        }

        self.allBars = [[NSMutableArray alloc]init];
        for (int i=0; i<300; i++) {
            if ([[allTaps objectAtIndex:i]intValue]==1) {
                UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(i/300.0*self.view.frame.size.width, self.view.frame.size.height/2-50, 4, 100)];
                bar.backgroundColor = [UIColor greenColor];
                bar.tag = 123412;
                [self.page3 addSubview:bar];
                [self.allBars addObject:bar];

            }
        }
        
        
        
    }
}

-(void)startRecordingNewPattern
{
    self.editingPattern = YES;
    self.scrollLock = YES;
    
    if(self.patternRecorder.isRecording == NO)
    {
        self.patternRecorder.delegate = self;
        [self.patternRecorder startNewPatternWithPattern:self.pickedPattern isBackground:NO];
    } else
    {
        [self.patternRecorder stopRecording];
    }
     
    /*
	 self.recording = YES;
	 self.numberOfTaps = 0;
	 [UIView animateWithDuration:0.5 animations:^{
	 self.startButton.alpha = 0.0f;
	 }];
	 self.tapData = [[NSMutableArray alloc]init];
	 self.startTime = CACurrentMediaTime();
	 CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runLoop)];
	 displayLink.frameInterval = 1;
	 [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	 
	 self.currentBar.frame =CGRectMake(0, self.view.frame.size.height/2-50, 4, 100);
	 for (UIView *v in self.allBars) {
	 [v removeFromSuperview];
	 }
	 self.allBars = [[NSMutableArray alloc]init];
	 
    self.touchDetector.userInteractionEnabled = YES;
    self.scrollLock = YES;
	*/
	
}

-(void)startRecordingInBackground{
    
    if(self.backgroundRecorder.isRecording == NO &&self.pageControl.currentPage ==0)
    {
        self.backgroundRecorder.delegate = self;
        [self.backgroundRecorder startNewPatternWithPattern:self.backgroudPattern isBackground:YES];
    }
}

-(void)runLoop{
	if (self.recording) {
		if (self.lastTapTime >self.startTime) {
			
			self.currentBar.center = CGPointMake(((CACurrentMediaTime() - self.startTime)/5)*self.view.frame.size.width, self.view.frame.size.height/2);
		}
		
		if ((CACurrentMediaTime() - self.startTime >5 )&&[self.tapData count]) {
			self.recording = NO;
			[UIView animateWithDuration:1.0 animations:^{
				self.startButton.alpha = 1.0;
			}];
            self.touchDetector.userInteractionEnabled = NO;
            self.scrollLock = NO;
			return;
		}
	}
	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
	if (self.recording) {
		if (CACurrentMediaTime() - self.startTime >5 ) {
			self.recording = NO;
			[UIView animateWithDuration:1.0 animations:^{
				self.startButton.alpha = 1.0;
			}];
            self.touchDetector.userInteractionEnabled = NO;
            self.scrollLock = NO;
			return;
		}
		
		if ([self.tapData count] == 0) {
			self.startTime = CACurrentMediaTime();
			self.lastTapTime = CACurrentMediaTime();
			[self.tapData addObject:[NSNumber numberWithDouble:0.0]];
			UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-50, 4, 100)];
			bar.backgroundColor = [UIColor greenColor];
			[self.page3 addSubview:bar];
			[self.allBars addObject:bar];
		}else{
			UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(((CACurrentMediaTime() - self.startTime)/5)*self.view.frame.size.width, self.view.frame.size.height/2-50, 4, 100)];
			bar.backgroundColor = [UIColor greenColor];
			[self.page3 addSubview:bar];
			[self.allBars addObject:bar];
			NSLog(@"Seconds from last tap - %f", CACurrentMediaTime()-self.lastTapTime);
			[self.tapData addObject:[NSNumber numberWithDouble:(CACurrentMediaTime()-self.lastTapTime)]];
			self.lastTapTime = CACurrentMediaTime();
		}
		
		self.numberOfTaps +=1;
		NSLog(@"tapCount - %d",self.numberOfTaps);
		
	}
}

-(void)refreshAllPatternsForTV{
    self.allPatternsForTV = [[NSMutableArray alloc]init];
    NSManagedObjectContext *context = [DataAccess context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    self.allPatternsForTV = [[context executeFetchRequest:request error:nil] mutableCopy];
    Pattern *p;
    for (int i=0; i<[self.allPatternsForTV count]; i++) {
        p=[self.allPatternsForTV objectAtIndex:i];
        if ([p.name isEqualToString:@"BackgroundPattern"]) {
            [self.allPatternsForTV removeObject:p];
        }
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CreateViewController *cVC = (CreateViewController *)segue.destinationViewController;
    cVC.pickedPattern = self.pickedPattern;
    cVC.patternPicked = YES;
    cVC.pickedPatternName = self.pickedPatternName;
    
    
}

-(int)comparePattern:(Pattern*)first withPattern:(Pattern*)second{
    double score = 0;
    
    /*
    NSData *test = first.allTaps;
    if (test ==[NSNull null]) {
        NSLog(@"First Null");
        return 100000000;
    }
    if (test == nil) {
        NSLog(@"First nil");
        return 100000000;
    }
    
    test = second.allTaps;
    if (test ==[NSNull null]) {
        NSLog(@"First Null");
        return 100000000;
    }
    if (test == nil) {
        NSLog(@"Second nil");
        return 100000000;
    }
    */
    int lastIndex1=0, lastIndex2=0;
    NSMutableArray *firstPatternRaw = [NSKeyedUnarchiver unarchiveObjectWithData:first.allTaps];
    NSMutableArray *secondPatternRaw =[NSKeyedUnarchiver unarchiveObjectWithData:second.allTaps];
    firstPatternRaw = [[NSMutableArray alloc] init];
    for(int i = 0; i < 300; i++)
    {
        [firstPatternRaw addObject:[NSNumber numberWithInt:0]];
    }
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:35];
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:61];
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:88];
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:100];
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:125];
    [firstPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:217];
    
    secondPatternRaw = [[NSMutableArray alloc] init];
    for(int i = 0; i < 300; i++)
    {
        [secondPatternRaw addObject:[NSNumber numberWithInt:0]];
    }
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:30];
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:65];
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:82];
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:120];
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:155];
    [secondPatternRaw setObject:[NSNumber numberWithInt:1] atIndexedSubscript:237];
    
    
    NSMutableArray *firstPattern = [[NSMutableArray alloc]init];
    NSMutableArray *secondPattern = [[NSMutableArray alloc]init];
    
    for (int i=0; i<300; i++) {
        if ([[firstPatternRaw objectAtIndex:i]intValue]==1) {
            [firstPattern addObject:[NSNumber numberWithDouble:i-lastIndex1]];
            lastIndex1=i;
        }
        if ([[secondPatternRaw objectAtIndex:i]intValue]==1) {
            [secondPattern addObject:[NSNumber numberWithDouble:i-lastIndex2]];
            lastIndex2 = i;
        }
    }
    double count = 0.0;
    double sum = 0;
    for (int i=0; i<[firstPattern count] && i<[secondPattern count]; i++) {
        
        double diff = [firstPattern[i] intValue] - [secondPattern[i] intValue];
        
        sum+= pow(abs(diff), 2);
        count++;
        
        NSLog(@"%d =  %d",i,[[firstPattern objectAtIndex:i]intValue]);
    }
    score += sum/count;
    
    NSLog(@"SECOND");
    
//    for (int i=0; i<[secondPattern count]; i++) {
//        NSLog(@"%d =  %d",i,[[secondPattern objectAtIndex:i]intValue]);
//    }
    
    
    
    NSLog(@"Score - %f",score);
    score += ([firstPattern count]-[secondPattern count])*100;
    
    
    return score;
}

@end
