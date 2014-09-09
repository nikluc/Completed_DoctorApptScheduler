//
//  patientsLoginPage.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"


@interface patientsLoginPage : ViewController<UITextFieldDelegate>

{
    NSArray *artArrayPatientList;
}

- (IBAction)patientRegister:(id)sender;
- (IBAction)patientLogin:(id)sender;


@property (nonatomic, weak) IBOutlet UILabel *loginName;
@property (nonatomic, weak) IBOutlet UILabel *loginEmail;
@property (nonatomic, weak) IBOutlet UILabel *loginCreatePassword;
@property (nonatomic, weak) IBOutlet UILabel *loginAge;
@property (nonatomic, weak) IBOutlet UILabel *loginSex;


@property (nonatomic, weak) IBOutlet UITextField *loginEmailId;
@property (nonatomic, weak) IBOutlet UITextField *loginPassword;
@property (nonatomic, weak) IBOutlet UITextField *regFirstName;
@property (nonatomic, weak) IBOutlet UITextField *regLastName;
@property (nonatomic, weak) IBOutlet UITextField *regEmail;
@property (nonatomic, weak) IBOutlet UITextField *regPasswrod;
@property (nonatomic, weak) IBOutlet UITextField *regAge;
@property (nonatomic, weak) IBOutlet UITextField *regSex;

@property (nonatomic, weak) IBOutlet UIButton *patientLogin;
@property (nonatomic, weak) IBOutlet UIButton *PatientRegister;


- (IBAction)indexChanged:(UISegmentedControl *)sender;
- (IBAction)sexChanged:(UISegmentedControl *)sender;



@end
