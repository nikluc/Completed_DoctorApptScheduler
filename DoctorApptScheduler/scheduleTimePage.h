//
//  scheduleTimePage.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"

@protocol senddataProtocol <NSObject>
-(void)sendDataToA:(NSArray *)array;
@end

@interface scheduleTimePage : ViewController<UITextViewDelegate>



{
     IBOutlet UIDatePicker *datePickerShed;
    NSArray *artArrayAcceptRejectList;
}
@property(nonatomic,assign)id delegate;

@property (nonatomic) UIDatePickerMode *testDate;
@property (nonatomic, strong) NSString *appIdDetails;
@property (nonatomic, strong) NSString *patientNameDetails;
@property (nonatomic, strong) NSString *patientReasonDetails;


@property (nonatomic, strong) IBOutlet UIDatePicker *datePickerShed;
@property (nonatomic, weak) IBOutlet UITextField *patientNameShed;
@property (nonatomic, weak) IBOutlet UITextField *patientReasonShed;
@property (nonatomic, weak) IBOutlet UITextField *currentDateShed;
@property (nonatomic, weak) IBOutlet UITextField *acceptRejectShed;

- (IBAction)statusChanged:(UISegmentedControl *)sender;


@end
