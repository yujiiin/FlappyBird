//
//  ViewController.m
//  Flappy Bird
//
//  Created by Yuji Shimizu on 3/31/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)Gameover{
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    Exit.hidden = NO;

}

-(IBAction)Exit:(id)sender{
    NSString *strURL = [NSString stringWithFormat:@"http://yujiiin.com/flappy/insert_score.php?score=%d",ScoreNumber];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self viewDidLoad];
}

-(void)Scoring{
    ScoreNumber++;
    Score.text = [NSString stringWithFormat:@"%i",ScoreNumber];

}

-(void)TunnelMovement{
    TunnelTop.center = CGPointMake(TunnelTop.center.x -1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x -1, TunnelBottom.center.y);
    
    if(TunnelTop.center.x < -28){
        [self PlaceTunnel];
    }
    
    if(TunnelTop.center.x == 30){
        [self Scoring];
    }
    
    if(CGRectIntersectsRect(Bird.frame, TunnelTop.frame)){
        [self Gameover];
    }
    if(CGRectIntersectsRect(Bird.frame, TunnelBottom.frame)){
        [self Gameover];
    }
    if(CGRectIntersectsRect(Bird.frame, Top.frame)){
        [self Gameover];
    }
    if(CGRectIntersectsRect(Bird.frame, Bottom.frame)){
        [self Gameover];
    }
   
    
}


-(void)PlaceTunnel{
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition - 228;
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 655;
    
    TunnelTop.center = CGPointMake(340, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(340, RandomBottomTunnelPosition);

}

-(IBAction)StartGame:(id)sender{
    StartGame.hidden = YES;
    HighScore.hidden = YES;
    AppName.hidden = YES;
    TunnelTop.hidden = NO;
    TunnelBottom.hidden = NO;
    Score.hidden = NO;
    ScoreNumber = 0;
    Score.text = [NSString stringWithFormat:@"%i",ScoreNumber];
    
    BirdMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    [self PlaceTunnel];
    TunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(TunnelMovement) userInfo:nil repeats:YES];
}

-(void)BirdMoving{
    Bird.center = CGPointMake(Bird.center.x,Bird.center.y - BirdFlight);
    BirdFlight = BirdFlight - 5;
    
    if(BirdFlight < -15){
        BirdFlight = -15;
    }
    if(BirdFlight > 0){
        Bird.image = [UIImage imageNamed:@"birdDown.png"];
    }
    if(BirdFlight < 0){
        Bird.image = [UIImage imageNamed:@"birdUp.png"];
    }
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BirdFlight = 25;

}



- (void)viewDidLoad
{
    TunnelBottom.hidden = YES;
    TunnelTop.hidden = YES;
    Exit.hidden = YES;
    Score.hidden = YES;
    StartGame.hidden = NO;
    HighScore.hidden = NO;
    Bird.center = CGPointMake(50,250);
    
    
    NSString *strURL = [NSString stringWithFormat:@"http://yujiiin.com/flappy/select_score.php"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    HighScore.text = [NSString stringWithFormat:@"HighScore : %@",result];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
