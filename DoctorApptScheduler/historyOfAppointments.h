//
//  historyOfAppointments.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"

@interface historyOfAppointments : ViewController<UITableViewDataSource,
UITableViewDelegate>

{
    IBOutlet UIDatePicker *datePickerHistory;
    IBOutlet UITextField *dateChangeHistory;
    IBOutlet UITextField *segmentChangeHistory;
    IBOutlet UILabel *doctorName;
       IBOutlet UITableView *docTableView;
     NSArray *artArrayPendingList;
        
}
@property (nonatomic, strong) UITextField *dateChangeHistory;
@property (nonatomic, strong) UITextField *segmentChangeHistory;
@property (nonatomic, strong) UITableView *docTableView;
@property (nonatomic, strong) UILabel *doctorName;
@property (nonatomic, strong) NSString *doctorsName;
@property (nonatomic, strong) NSString *doctorsId;
@property (nonatomic, strong) NSArray *accRejLists;




- (IBAction)indexChanged:(UISegmentedControl *)sender;
-(IBAction)pickerDateChanged:(UIDatePicker *)sender;


@end
