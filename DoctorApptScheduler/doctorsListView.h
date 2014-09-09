//
//  doctorsListView.h
//  DoctorApptScheduler
//
//  Created by administrator on 11/08/14.
//
//

#import <UIKit/UIKit.h>

@interface doctorsListView : UITableViewController
{
    UIImageView *imageView;
    
}

@property (nonatomic, retain) UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSArray *doctorListArray;
@end
