//
//  CJSViewController.m
//  CoreJSDeme
//
//  Created by muhammad.aftab on 19/11/2013.
//  Copyright (c) 2013 muhammad.aftab. All rights reserved.
//

#import "CJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CJSViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)callJavaSript:(id)sender;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation CJSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"js"];
    NSString *scriptString = [NSString stringWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:nil];
    self.jsContext = [[JSContext alloc] init];
    if (!scriptString.length == 0) {
        [self.jsContext evaluateScript:scriptString];
    }
    
    
    __weak CJSViewController *weakSelf = self;

    self.jsContext[@"sayHello"] = ^(NSString *string){
        weakSelf.textView.text = string;
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callJavaSript:(id)sender {
    JSValue *func = self.jsContext[@"helloWorld"];
    [func callWithArguments:@[]];
    
    
}
@end
