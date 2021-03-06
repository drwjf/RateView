//
//  STRViewController.m
//  Star
//
//  Created by Tarun Tyagi on 04/07/14.
//  Copyright (c) 2014 Tarun Tyagi. All rights reserved.
//

#import "STRViewController.h"

@interface STRViewController ()

@end

@implementation STRViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    titles = @[@"Default",
               @"Frame :- Extra H(500),W(600) ignored",
               @"Responsive to Star Size",
               @"Customizable Border, Normal, Fill Color",
               @"UIColor MAGIC : colorWithPatternImage:",
               @"Fill Mode - Horizontal",
               @"Fill Mode - Vertical",
               @"Fill Mode - Axial",
               @"Change Star Count & add padding",
               @"CanRate - Try touch / tap / touch drag",
               @"-------END OF STORY-----"];
    
    displayTblVw = [[UITableView alloc] initWithFrame:self.view.frame
                                                style:UITableViewStylePlain];
    displayTblVw.dataSource = self;
    displayTblVw.delegate = self;
    displayTblVw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:displayTblVw];
    [displayTblVw reloadData];
    
    /* Uncomment this to check out individual property here
     RateView* rv = [RateView rateViewWithRating:3.5f];
     [self.view addSubview:rv];
     
     // Extra frames width, height ignored
     rv.frame = CGRectMake(15, 200, 500, 600);
     
     // Responsive to star size
     rv.starSize = 50;
     
     // Customizable border color
     rv.starBorderColor = [UIColor greenColor];
     
     // Customizable star normal color
     rv.starNormalColor = [UIColor redColor];
     
     // Customizable star fill color
     rv.starFillColor = [UIColor yellowColor];
     
     // Customizable star fill mode
     rv.starFillMode = StarFillModeHorizontal;
     
     // Change rating whenever needed
     rv.rating = 2.5f;
     
     // Can Rate (User Interaction, as needed)
     rv.canRate = YES;*/
}

#pragma mark
#pragma mark<UITableViewDataSource Methods>
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger noOfRows = 0;
    if([titles count] > 0)
        noOfRows = [titles count];
    
    return noOfRows;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* cellIdentifier = @"RateViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel* titleLbl = nil;
    RateView* rateVw = nil;
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
        
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14.0];
        titleLbl.textAlignment = NSTextAlignmentLeft;
        titleLbl.textColor = [UIColor darkGrayColor];
        titleLbl.tag = 99999;
        
        rateVw = [RateView rateViewWithRating:2.5f];
        rateVw.frame = CGRectMake(10, 40, 150, 30);
        rateVw.tag = 88888;
        
        [cell.contentView addSubview:titleLbl];
        [cell.contentView addSubview:rateVw];
    }
    else
    {
        titleLbl = (UILabel*)[cell.contentView viewWithTag:99999];
        rateVw = (RateView*)[cell.contentView viewWithTag:88888];
    }
    
    titleLbl.text = titles[indexPath.row];
    rateVw.starSize = (indexPath.row > 1) ? 50 : 30;
    rateVw.rating = 3.4f;
    
    if(indexPath.row == 0)
    {
        rateVw.rating = 3.6f;
    }
    else if(indexPath.row == 1)
    {
        rateVw.rating = 4.4f;
    }
    else if(indexPath.row == 2)
    {
        rateVw.rating = 3.3f;
    }
    else if(indexPath.row == 3)
    {
        rateVw.rating = 4.3f;
        
        rateVw.starNormalColor = [UIColor colorWithRed:255/255.0f green:255/255.0f
                                                  blue:255/255.0 alpha:1.0];
        rateVw.starFillColor = [UIColor colorWithRed:255/255.0f green:209/255.0f
                                                blue:23/255.0 alpha:1.0];
        rateVw.starBorderColor = [UIColor colorWithRed:38/255.0f green:38/255.0f
                                                  blue:38/255.0 alpha:1.0];
    }
    else if(indexPath.row == 4)
    {
        rateVw.rating = 2.6f;
        
        rateVw.starNormalColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"image0.jpeg"]];
        
        rateVw.starFillColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:@"image1.jpeg"]];
        
        rateVw.starBorderColor = [UIColor colorWithPatternImage:
                                  [UIImage imageNamed:@"image2.jpeg"]];
    }
    
    // Modes - Horizontal, Vertical, Axial
    if(indexPath.row == 6)
    {
        rateVw.rating = 2.35f;
        rateVw.starFillMode = StarFillModeVertical;
    }
    else if(indexPath.row == 7)
    {
        rateVw.rating = 3.65f;
        rateVw.starFillMode = StarFillModeAxial;
    }
    else if(indexPath.row == 8)
    {
        [rateVw setStarCount:4];
        [rateVw setPadding:10.0f];
        rateVw.rating = 3.5f;
    }
    else
    {
        rateVw.step = 0.5f;
        rateVw.starFillMode = StarFillModeHorizontal;
    }
    
    rateVw.canRate = (indexPath.row == 8);
    rateVw.delegate = (indexPath.row == 8) ? self : nil;
    rateVw.hidden = (indexPath.row == 9);
    
    return cell;
}

#pragma mark
#pragma mark<UITableViewDelegate Methods>
#pragma mark

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark
#pragma mark<RateViewDelegate Methods>
#pragma mark

-(void)rateView:(RateView*)rateView didUpdateRating:(float)rating
{
    NSLog(@"rateViewDidUpdateRating: %.1f", rating);
}

@end
