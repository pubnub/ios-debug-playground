//
//  ViewController.m
//  iOSDebugPlayground
//
//  Created by Jordan Zucker on 3/31/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNub/PubNub.h>
#import "PNDebugConstants.h"
#import "ViewController.h"

@interface ViewController () <
                                UITextFieldDelegate,
                                PNObjectEventListener
                                >
@property (nonatomic, weak) IBOutlet UILabel *publishStatusLabel;
@property (nonatomic, weak) IBOutlet UITextField *publishPayloadTextField;
@property (nonatomic, weak) IBOutlet UIButton *publishButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.client addListener:self];
    self.publishPayloadTextField.delegate = self;
    self.publishStatusLabel.text = @"";
    [self.publishButton addTarget:self action:@selector(publishButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI Actions

- (void)publishButtonTapped:(UIButton *)sender {
    NSString *message = self.publishPayloadTextField.text;
    if (message) {
        __weak typeof (self) wself = self;
        [self.client publish:message toChannel:kPNTestChannelString withCompletion:^(PNPublishStatus * _Nonnull status) {
            __strong typeof (wself) sself = wself;
            sself.publishStatusLabel.text = status.data.information;
        }];
    }
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    NSLog(@"%s client: %@ status: %@", __PRETTY_FUNCTION__, client.debugDescription, status.debugDescription);
}

- (void)client:(PubNub *)client didReceiveMessage:(nonnull PNMessageResult *)message {
    NSLog(@"%s client: %@ message: %@", __PRETTY_FUNCTION__, client.debugDescription, message.debugDescription);
}

- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    NSLog(@"%s client: %@ event: %@", __PRETTY_FUNCTION__, client.debugDescription, event.debugDescription);
}

@end
