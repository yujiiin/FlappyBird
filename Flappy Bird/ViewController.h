//
//  ViewController.h
//  Flappy Bird
//
//  Created by Yuji Shimizu on 3/31/14.
//  Copyright (c) 2014 Yuji Shimizu. All rights reserved.
//

#import <UIKit/UIKit.h>

int BirdFlight;
int RandomTopTunnelPosition;
int RandomBottomTunnelPosition;
int ScoreNumber;
NSInteger HighScoreNumber;


@interface ViewController : UIViewController
{
    IBOutlet UIImageView *Bird;
    IBOutlet UIButton *StartGame;
    IBOutlet UILabel *HighScore;
    IBOutlet UILabel *AppName;
    IBOutlet UIImageView *TunnelTop;
    IBOutlet UIImageView *TunnelBottom;
    IBOutlet UIImageView *Top;
    IBOutlet UIImageView *Bottom;
    IBOutlet UILabel *Score;
    IBOutlet UIButton *Exit;
    
    NSTimer *BirdMovement;
    NSTimer *TunnelMovement;
}

-(IBAction)StartGame:(id)sender;
-(IBAction)Exit:(id)sender;
-(void)BirdMoving;
-(void)TunnelMovement;
-(void)PlaceTunnel;
-(void)Scoring;
-(void)Gameover;

@end
