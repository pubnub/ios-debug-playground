//
//  ViewController.h
//  iOSDebugPlayground
//
//  Created by Jordan Zucker on 3/31/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PubNub;
@interface ViewController : UIViewController

@property (nonatomic, weak) PubNub *client;

@end

