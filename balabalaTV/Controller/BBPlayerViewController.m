//
//  BBPlayerViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBPlayerViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface BBPlayerViewController ()<VLCMediaPlayerDelegate>

@property (strong,nonatomic) VLCMediaPlayer *player;

@end

@implementation BBPlayerViewController



#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _player = [[VLCMediaPlayer alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _player = [[VLCMediaPlayer alloc]init];
    _player.drawable = self.view;
    _player.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setVideoURL:(NSURL *)url{
    
    VLCMedia *media = [VLCMedia mediaWithURL:url];
    [_player setMedia:media];
}

-(void)play{
    [_player play];
}



@end
