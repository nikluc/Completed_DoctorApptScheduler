//
//  ViewController.h
//  DoctorApptScheduler
//
//  Created by administrator on 10/08/14.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
   
    NSArray *artArray;
      NSArray *artArrayDoctorList;
	NSMutableData* responseData;
 }

@property (retain, nonatomic) NSMutableData* responseData;
@property (strong, nonatomic) IBOutlet UITextField *selectSpeciality;
@property (strong, nonatomic) IBOutlet UITextField *selectSpecialityId;
@property (strong, nonatomic) IBOutlet UITextField *enterPinCode;






- (IBAction)findDoctors:(id)sender;
- (IBAction)loginDoctors:(id)sender;
- (IBAction)loginPatients:(id)sender;

 
@end
