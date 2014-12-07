//
//  BBPlayerViewController.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBPlayerViewController : UIViewController

/**
 *  设置视频源地址
 *
 *  @param url 视频地址
 */
-(void)setVideoURL:(NSURL *)url;


/**
 *  开始播放
 */
-(void)play;

@end
