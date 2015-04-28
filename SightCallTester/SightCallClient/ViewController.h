//
//  ViewController.h
//  SightCallClient
//
//  Created by Ihawk on 4/23/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
#import "CallManager.h"
#import "RTccCallManager.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"
#import "CallsGenerator.h"
#import "CallsReceiver.h"
#import "Auth.h"

#import "CallManager1.h"
#import "CallReceiver1.h"

@interface ViewController : UIViewController<CMDelegate, CMCallDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *inView;
@property (weak, nonatomic) IBOutlet UIView *outView;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (nonatomic) RtccCallManager * cm;
@property (nonatomic) CallsTester * ct;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIPickerView *managerPickerView;
@property (weak, nonatomic) IBOutlet UILabel *managerInfoLabel;

-(NSString*)defaultUserID;
-(NSString*)authServerURL;
-(NSString*)appID;
-(NSArray*)managerClasses;

@end

