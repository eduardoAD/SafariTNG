//
//  ViewController.m
//  SafariTNG
//
//  Created by Eduardo Alvarado Díaz on 10/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () < UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak,nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHomePage];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Bad error... No Biscuit";
    alertView.message = error.localizedDescription;
    [alertView addButtonWithTitle:@"That's all"];
    [alertView addButtonWithTitle:@"Go home"];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [self loadHomePage];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadURLString:textField.text];
    return YES;
}

- (void) loadURLString: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void) loadHomePage {
    [self loadURLString:@"http://www.mobilemakers.co"];
}

@end
