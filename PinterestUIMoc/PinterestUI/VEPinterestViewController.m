//
//  VEPinterestUIViewController.m
//  PinterestUIMoc
//
//  Created by Mitsuyoshi Yamazaki on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VEPinterestViewController.h"

@interface VEPinterestViewController ()

@end

@implementation VEPinterestViewController

@synthesize pinterestView = _pinterestView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_pinterestView release], _pinterestView = nil;
	
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
}

#pragma mark - VEPinterestViewDelegate 
- (void)pinterestView:(VEPinterestView *)pinterestView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)pinterestView:(VEPinterestView *)pinterestView didLongPressCellAtIndexPath:(NSIndexPath *)indexPath {
	
}

#pragma mark - VEPinterestViewDatasource 
- (CGSize)sizeOfCellInPinterestView:(VEPinterestView *)pinterestView atIndexPath:(NSIndexPath *)indexPath {
	
}

- (NSUInteger)numberOfSectionsInPinterestView:(VEPinterestView *)pinterestView {
	
}

- (NSUInteger)numberOfCellsInPinterestView:(VEPinterestView *)pinterestView section:(NSUInteger)section {
	
}

- (void)pinterestView:(VEPinterestView *)pinterestView configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath {
	
}

- (NSString *)titleForHeaderInSection:(NSUInteger)section {
	
}

@end
