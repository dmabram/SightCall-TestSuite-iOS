//
//  ViewController.m
//  SightCallClient
//
//  Created by Ihawk on 4/23/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(NSString*)defaultUserID{
	return @"";
}


-(NSString*)authServerURL{
	//put the link to your auth token server here!
	return @"http://My Auth Server";
}

-(NSString*)appID{
	return @"My App ID";
}


-(NSArray*)managerClasses{
	return @[];
}

- (void)viewDidAppear:(BOOL)animated{
	
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	_userTextField.text = [self defaultUserID];
	_managerPickerView.dataSource = self;
	_managerPickerView.delegate = self;
	[_managerPickerView selectRow:0 inComponent:0 animated:NO];
	Class class = [[self managerClasses] objectAtIndex:0];
	_managerInfoLabel.text = [class infoMessage];
}

-(CallsTester*)callsTester{
	//to be overriden
	return nil;
}

#pragma mark Buttons

- (IBAction)onStart{
	
	self.startButton.hidden = YES;
	
	NSString * userID = [self.userTextField text];
	
	NSInteger managerIndex = [self.managerPickerView selectedRowInComponent:0];
	Class managerClass = [[self managerClasses] objectAtIndex:managerIndex];
	
							 self.cm = [[managerClass alloc] initWithAppID:[self appID]
															 authServerURL:[self authServerURL]
																	userID:userID
														   userDisplayName:userID];
							 _ct = [self callsTester];
							 _ct.inView = _inView;
							 _ct.outView = _outView;
							 [_ct start];
}


#pragma mark TextFields

- (IBAction)onEndEdit:(id)sender{
	[sender resignFirstResponder];
}


#pragma mark Picker

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [[self managerClasses] count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	Class class = [[self managerClasses] objectAtIndex:row];
	if(component == 0)
		return NSStringFromClass(class);
	return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	Class class = [[self managerClasses] objectAtIndex:row];
	_managerInfoLabel.text = [class infoMessage];
}

@end
