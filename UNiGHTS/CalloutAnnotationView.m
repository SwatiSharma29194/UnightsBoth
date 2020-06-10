//
//  CalloutAnnotationView.m
//  CustomCalloutSample
//
//  Created by tochi on 11/05/17.
//  Copyright 2011 aguuu,Inc. All rights reserved.
//

#import "CalloutAnnotationView.h"
#import "CalloutAnnotation.h"

@implementation CalloutAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  
  if (self) {
      self.frame = CGRectMake(0.0f, 0.0f, 50, 50);
      self.backgroundColor = [UIColor colorWithRed:0.9411 green:0.9411 blue:0.9411 alpha:1.0];
      self.layer.borderColor = [UIColor colorWithRed:0.3254 green:0.5843 blue:0.9019 alpha:1.0].CGColor;
      self.layer.borderWidth = 4.0f;
    
//      _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 30.0f, 120.0f, 80.0f)];
//      self.titleLabel.textColor = [UIColor blackColor];
//      self.titleLabel.textAlignment = NSTextAlignmentCenter;
//      self.titleLabel.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0];
//      self.titleLabel.font = [UIFont systemFontOfSize:20];
//      [self addSubview:self.titleLabel];
//
//      _button = [UIButton buttonWithType:UIButtonTypeCustom];
//      [self.button setFrame:CGRectMake(40, 140, 100, 40)];
//      [self.button setTitle:@"more info" forState:UIControlStateNormal];
//      [self.button setTitleColor:[UIColor colorWithRed:0.3254 green:0.5843 blue:0.9019 alpha:1.0] forState:UIControlStateNormal];
//      [self.button addTarget:self action:@selector(calloutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//      [self addSubview:self.button];
  }
  return self;
}


-(void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  self.titleLabel.text = self.title;
}

#pragma mark - Button clicked
- (void)calloutButtonClicked
{
  CalloutAnnotation *annotation = self.annotation;
  [self.delegate calloutButtonClicked:(NSString *)annotation.title];
}
@end
