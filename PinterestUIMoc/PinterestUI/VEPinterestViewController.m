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

	if (_pinterestView == nil) {
		
		self.view.autoresizesSubviews = YES;
		
		_pinterestView = [[VEPinterestView alloc] initWithFrame:self.view.bounds];
		self.pinterestView.delegate = self;
		self.pinterestView.datasource = self;
		self.pinterestView.backgroundColor = [UIColor clearColor];
		self.pinterestView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		
		[self.view addSubview:self.pinterestView];		
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.pinterestView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [_pinterestView release], _pinterestView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
}

#pragma mark -
#pragma mark - Following methods need override
#pragma mark - VEPinterestViewDelegate 
- (void)pinterestView:(VEPinterestView *)pinterestView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)pinterestView:(VEPinterestView *)pinterestView didLongPressCellAtIndexPath:(NSIndexPath *)indexPath {
	
}

#pragma mark - VEPinterestViewDatasource 
- (CGSize)sizeOfCellInPinterestView:(VEPinterestView *)pinterestView atIndexPath:(NSIndexPath *)indexPath {
	return CGSizeZero;
}

- (NSUInteger)numberOfSectionsInPinterestView:(VEPinterestView *)pinterestView {
	return 0;
}

- (NSUInteger)numberOfCellsInPinterestView:(VEPinterestView *)pinterestView section:(NSUInteger)section {
	return 0;
}

- (void)pinterestView:(VEPinterestView *)pinterestView configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath {
	
}

- (NSString *)pinterestView:(VEPinterestView *)pinterestView titleForHeaderInSection:(NSUInteger)section {
	return nil;
}

@end
