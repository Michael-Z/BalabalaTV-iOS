//
//  BBPlayerControlViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBPlayerControlViewController.h"
#import "BBPlayerViewController.h"

@interface BBPlayerControlViewController ()

@property (strong,nonatomic) UIControl *topControlView;
@property (strong,nonatomic) UIControl *bottomControlView;
@property (strong,nonatomic) BBPlayerViewController *rootViewController;
@property (strong,nonatomic) UIControl *backgroundView;

@property (strong,nonatomic) UIButton *exitButton;
@property (strong,nonatomic) UIButton *changeSourceBtn;
@property (strong,nonatomic) UIButton *playStateControl;

@end

@implementation BBPlayerControlViewController

static CGFloat TOP_CONTROL_HEIGHT = 60.0f;//顶部控件视图高度
static CGFloat BOTTOM_CONTROL_HEIGHT = 60.0f;//底部控件视图高度
static UIColor *CONTROL_BGCOLOR = nil;//控件视图颜色
static CGFloat CONTROL_ALPHA = 0.9f;


#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CONTROL_BGCOLOR = [UIColor colorWithWhite:0.186 alpha:1.000];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = self.view.bounds.size;
    
    //初始化Background视图
    _backgroundView = [[UIControl alloc]initWithFrame:self.view.bounds];
    [_backgroundView addTarget:self action:@selector(closePlayerControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backgroundView];
    
    
    //初始化顶部控制视图
    _topControlView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, TOP_CONTROL_HEIGHT)];
    _topControlView.backgroundColor = CONTROL_BGCOLOR;
    _topControlView.alpha = CONTROL_ALPHA;
    [self.view addSubview:_topControlView];
    
    
    //初始化底部控制视图
    _bottomControlView = [[UIControl alloc]initWithFrame:CGRectMake(0, screenSize.height-BOTTOM_CONTROL_HEIGHT, screenSize.width, BOTTOM_CONTROL_HEIGHT)];
    _bottomControlView.backgroundColor = CONTROL_BGCOLOR;
    _bottomControlView.alpha = CONTROL_ALPHA;
    [self.view addSubview:_bottomControlView];
    
    
    //初始化退出按钮
    _exitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGPoint exitBtnCenter = _topControlView.center;
    exitBtnCenter.x = 30.0f;
    exitBtnCenter.y += 5.0f;
    _exitButton.center = exitBtnCenter;
    [_exitButton setBackgroundImage:[UIImage imageNamed:@"btn-back"] forState:UIControlStateNormal];
    [_exitButton addTarget:self action:@selector(didExitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.topControlView addSubview:_exitButton];
    
    
    //播放控制按钮
    _playStateControl = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGPoint playStateCenter = CGPointMake(_bottomControlView.bounds.size.width/2, _bottomControlView.bounds.size.height/2);
    _playStateControl.center = playStateCenter;
    [_playStateControl setImage:[UIImage imageNamed:@"btn-pause"] forState:UIControlStateNormal];
    [_playStateControl addTarget:self action:@selector(didPlayStateControlClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:_playStateControl];
    
    //初始化更换源按钮
    _changeSourceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    CGPoint changeBtnCenter = _topControlView.center;
    changeBtnCenter.x = _topControlView.bounds.size.width - 40.0f;
    changeBtnCenter.y += 5.0f;
    _changeSourceBtn.center = changeBtnCenter;
    [_changeSourceBtn setBackgroundImage:[UIImage imageNamed:@"btn-channel"] forState:UIControlStateNormal];
    [self.topControlView addSubview:_changeSourceBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图控制

-(void)viewWillLayoutSubviews{
    
    CGSize screenSize = self.view.bounds.size;
    
    _backgroundView.frame = self.view.bounds;
    _topControlView.frame = CGRectMake(0, 0, screenSize.width, TOP_CONTROL_HEIGHT);
    _bottomControlView.frame = CGRectMake(0, screenSize.height-BOTTOM_CONTROL_HEIGHT, screenSize.width, BOTTOM_CONTROL_HEIGHT);
    
    //计算旋屏后播放控制按钮的位置
    CGPoint playStateCenter = CGPointMake(_bottomControlView.bounds.size.width/2, _bottomControlView.bounds.size.height/2);
    _playStateControl.center = playStateCenter;
    
    //计算旋屏后换源按钮的位置
    CGPoint changeBtnCenter = _topControlView.center;
    changeBtnCenter.x = _topControlView.bounds.size.width - 40.0f;
    changeBtnCenter.y += 5.0f;
    _changeSourceBtn.center = changeBtnCenter;
    
}

-(void)showPlayerControl:(BBPlayerViewController *)vc{
    self.rootViewController = vc;
    self.view.frame = vc.view.bounds;
    [vc.view addSubview:self.view];
    [vc addChildViewController:self];
    
    //加载动画效果
    CGPoint topControlCenter = _topControlView.center;
    topControlCenter.y-=TOP_CONTROL_HEIGHT;
    _topControlView.center = topControlCenter;
    
    CGPoint bottomControlCenter = _bottomControlView.center;
    bottomControlCenter.y+=BOTTOM_CONTROL_HEIGHT;
    _bottomControlView.center = bottomControlCenter;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint topControlCenter = _topControlView.center;
        topControlCenter.y+=TOP_CONTROL_HEIGHT;
        _topControlView.center = topControlCenter;
        
        CGPoint bottomControlCenter = _bottomControlView.center;
        bottomControlCenter.y-=BOTTOM_CONTROL_HEIGHT;
        _bottomControlView.center = bottomControlCenter;
        
    }];
}

-(void)closePlayerControl{
    
    //退出动画效果
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint topControlCenter = _topControlView.center;
        topControlCenter.y-=TOP_CONTROL_HEIGHT;
        _topControlView.center = topControlCenter;
        
        CGPoint bottomControlCenter = _bottomControlView.center;
        bottomControlCenter.y+=BOTTOM_CONTROL_HEIGHT;
        _bottomControlView.center = bottomControlCenter;
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
    }];
    
    NSLog(@"退出");
}

#pragma mark - 事件监听
//退出按钮点击
-(void)didExitBtnClicked{
    [_rootViewController.player.mediaPlayer stop];
    [_rootViewController dismissViewControllerAnimated:NO completion:nil];
}

//播放控制按钮点击
- (void)didPlayStateControlClicked {

    //加锁防止重复点击
  @synchronized(self) {
    VLCMediaListPlayer *player = _rootViewController.player;
    NSInteger state = player.mediaPlayer.state;

    if ([player.mediaPlayer isPlaying]) {
      [player pause];
      [_playStateControl setImage:[UIImage imageNamed:@"btn-play"]
                         forState:UIControlStateNormal];
    }
      
    if (state == VLCMediaPlayerStatePaused) {
      [player play];
      [_playStateControl setImage:[UIImage imageNamed:@"btn-pause"]
                         forState:UIControlStateNormal];
    }
      
  }
    
}


@end
