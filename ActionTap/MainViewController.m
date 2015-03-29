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
@interface MainViewController ()<RecorderDelegate>
@property Recorder *recorder;
@property UIView *currentBar;
@property NSMutableArray *allBars;
@property UIButton *touchDetector;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshAllPatterns];
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
	
	[self.view addSubview:self.pageControl];
    
	
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
	
    // Do any additional setup after loading the view.
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 100)];
	[title setText:@"jarvis"];
	[title setTextColor:[UIColor whiteColor]];
	[title setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:72]];
	[title setTextAlignment:NSTextAlignmentCenter];
	[title setCenter:CGPointMake(self.view.frame.size.width/2, 75)];
	[self.page1 addSubview:title];
	
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
	
	UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, self.view.frame.size.height - 250)];
	[tableView setDataSource:self];
	[tableView setDelegate:self];
	self.tableView = tableView;
	[self.page2 addSubview:tableView];
	
	
	//PAGE 3
	
	UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
	title3.text = @"Action";
	title3.textAlignment = NSTextAlignmentCenter;
	title3.font = [UIFont boldSystemFontOfSize:40];
	[self.page3 addSubview:title3];
	
	UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, self.view.frame.size.height*2/3, 80, 80)];
	startButton.backgroundColor = [UIColor greenColor];
    [startButton setImage:[UIImage imageNamed:@"recordButton"] forState:UIControlStateNormal];
	[startButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
	self.startButton = startButton;
	[self.page3 addSubview:startButton];
	
	UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80, self.view.frame.size.height*3/4, 80, 80)];
	confirmButton.backgroundColor = [UIColor greenColor];
	//[confirmButton addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
	self.confirmButton = confirmButton;
	//[self.page3 addSubview:replayButton];
	
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
    self.recorder = [[Recorder alloc] init];
    self.recorder.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSLog(@"scrolling");
    if (self.scrollLock) {
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage *self.view.frame.size.width, 0);
        return;
    }
    CGFloat pageWidth = self.scrollView.frame.size.width;
	float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	NSInteger page = lround(fractionalPage);
	self.pageControl.currentPage = page;
 
}
#pragma mark - Table View

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatternCell"];
    Pattern  *pattern = [self.allPatternsForTV objectAtIndex:indexPath.row];
    cell.textLabel.text =pattern.name;
	
	[cell.textLabel setTextAlignment: NSTextAlignmentLeft];
	[cell setTag: indexPath.row];
	[cell.textLabel setTextColor:[UIColor blackColor]];
	
	
	
	[cell.layer setCornerRadius:10.0];
	[cell.layer setBorderWidth:2.0];
	[cell.layer setBorderColor:[UIColor colorWithRed:14/255.0 green:191/255.0 blue:233/255.0 alpha:1.0].CGColor];
	cell.layer.masksToBounds = YES;
	[cell setBackgroundColor:[UIColor whiteColor]];
	
	
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [self.allPatternsForTV count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 90.0f;
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
    NSManagedObjectContext *context = [DataAccess context];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
    NSArray *tempAll = [context executeFetchRequest:request error:nil];
    self.allPatterns = [[NSMutableDictionary alloc]init];
    for (Pattern *p in tempAll) {
        [self.allPatterns  setValue:p forKey:p.name];
    }
    
    
}


-(void)startRecording
{
    if(self.recorder.isRecording == NO)
    {
        [self.recorder.audioRecorder recordAudio];
        [self.recorder startNewPatternWithName:@"testName" withURL:[NSURL URLWithString: @"testUrl"]];
    } else
    {
        [self.recorder.audioRecorder stopAudio];
        [self.recorder stopRecording];
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Patern"];
    self.allPatternsForTV = [context executeFetchRequest:request error:nil];
    
}

@end
