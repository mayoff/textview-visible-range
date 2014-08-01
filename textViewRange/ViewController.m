//
//  ViewController.m
//  textViewRange
//
//  Created by Rob Mayoff on 8/1/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *sourceTextView;
@property (strong, nonatomic) IBOutlet UITextView *targetTextView;

@end

@implementation ViewController

- (void)viewDidLayoutSubviews {
    [self updateTargetTextView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateTargetTextView];
}

- (void)updateTargetTextView {
    NSRange range = [self visibleRangeOfTextView:self.sourceTextView];
    NSString *visibleText = [self.sourceTextView.text substringWithRange:range];
    NSAttributedString *trib = [[NSAttributedString alloc] initWithString:visibleText attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:9],
        NSBackgroundColorAttributeName: [UIColor lightGrayColor]}];
    self.targetTextView.attributedText = trib;
}

- (NSRange)visibleRangeOfTextView:(UITextView *)textView {
    CGRect bounds = textView.bounds;
    UITextPosition *start = [textView characterRangeAtPoint:bounds.origin].start;
    UITextPosition *end = [textView characterRangeAtPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))].end;
    return NSMakeRange([textView offsetFromPosition:textView.beginningOfDocument toPosition:start],
        [textView offsetFromPosition:start toPosition:end]);
}


@end
