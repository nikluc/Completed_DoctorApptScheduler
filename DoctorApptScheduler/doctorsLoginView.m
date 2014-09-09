//
//  doctorsLoginView.m
//  DoctorApptScheduler
//
//  Created by administrator on 11/08/14.
//
//

#import "doctorsLoginView.h"
#import "historyOfAppointments.h"
#import "SBJson.h"



#define selectDesigURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=designationlist"
#define selectDoctorRegURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=docregistration"
#define selectDoctorLoginURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=doctorlogin"

NSString *name;
NSString *doctorId;
UIPickerView *pickerView ;
NSData* imageData;
NSString *imageName ;
@interface doctorsLoginView ()
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITextField *pickerViewTextFieldDoc;
@end

@implementation doctorsLoginView
@synthesize pickerViewTextFieldDoc = _pickerViewTextFieldDoc;
@synthesize responseDoctorRegister,logoDoc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self selectDesigOfDoctors];
    
    self.responseDoctorRegister = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:selectDesigURL]];
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];

  
   
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.segmentedControl.selectedSegmentIndex=1;
    
    
    [self.logLicence setHidden:NO];
    [self.logLicenceText setHidden:NO];
    [self.logDesignation setHidden:NO];
    [self.logDesignationText setHidden:NO];
    [self.logFirstname setHidden:NO];
    [self.logFirstnameText setHidden:NO];
    [self.logLastname setHidden:NO];
    [self.logLastnameText setHidden:NO];
    [self.logEmail setHidden:NO];
    [self.logEmailText setHidden:NO];
    [self.logPhone setHidden:NO];
    [self.logPhoneText setHidden:NO];
    
    [self.logAddress setHidden:NO];
    [self.logAddressText setHidden:NO];
    [self.logCity setHidden:NO];
    [self.logCityText setHidden:NO];
    [self.logState setHidden:NO];
    [self.logStateText setHidden:NO];
    [self.logCountry setHidden:NO];
    [self.logCountryText setHidden:NO];
    [self.logPincode setHidden:NO];
    [self.logPincodeText setHidden:NO];
    
    [self.doctorRegister setHidden:NO];
    [self.logPass setHidden:NO];
    [self.logPassReg setHidden:NO];
    [self.uploadPic setHidden:NO];
    [self.logAge setHidden:NO];
    
    [self.logAgeText setHidden:NO];
    [self.logDescription setHidden:NO];
    [self.logDesgText setHidden:NO];
    
   
    [self.logoDoc setHidden:YES];
    [self.logDoctorId setHidden:YES];
    [self.logDoctorPassword setHidden:YES];
    [self.doctorLogin setHidden:YES];
    [self.forgotPassword setHidden:YES];
    [self.logPasswordReq setHidden:YES];
    [self.sendPasswordRequest setHidden:YES];
    
   
    
}





- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseDoctorRegister setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseDoctorRegister appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseDoctorRegister = nil;
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError* error;
    
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseDoctorRegister options:kNilOptions error:&error];
    NSLog(@"Guide: %@", json);
    
    artArrayChooseDesg = [json objectForKey:@"designation"];
    
    [pickerView reloadAllComponents] ;
    
}

//*******Picker view for CHOOSING SPECIALITY

-(void)selectDesigOfDoctors
{
    self.pickerViewTextFieldDoc = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextFieldDoc];
    
    
    
    
    self.logDesignationText.delegate = self;
   // [self.view addSubview:self.logDesignationText];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
   
    
   
    self.logDesignationText.inputView = pickerView;
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    //  self.pickerViewTextField.inputAccessoryView = toolBar;
    
    
    self.logDesignationText.inputAccessoryView = toolBar;
    
    
}



- (void)cancelTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.logDesignationText resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.logDesignationText resignFirstResponder];
    
    // perform some action
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [artArrayChooseDesg count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *dict = [artArrayChooseDesg objectAtIndex:row];
    NSLog(@"dict: %@", dict);
    return [dict objectForKey:@"designation"];
    
    
    //  NSString *item = [artArrayChooseDesg objectAtIndex:row];
    
    //  return item;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSDictionary *dict = [artArrayChooseDesg objectAtIndex:row];
    
    NSString* testVal =[dict objectForKey:@"designation"];
    NSString* testVal1 =[dict objectForKey:@"des_sk"];
    self.logDesignationTextId.text = [NSString stringWithFormat:@"%@",testVal1];
    
    self.logDesignationText.text = [NSString stringWithFormat:@"%@",testVal];
}
//***************************************//






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)doctorLogin:(id)sender
{
    NSInteger success = 0;
    NSInteger errormsg = 0;
     NSInteger errormsginvalid = 0;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    
    
    if ([emailTest evaluateWithObject:self.logDoctorId.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter valid email ID !"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    
    else{
        if ( self.logDoctorPassword.text.length<7){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid username/password !"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }
        else{
            
            
            
            NSString *post =[[NSString alloc] initWithFormat:@"docemail=%@&docpassword=%@&tag=%s",[self.logDoctorId text],[self.logDoctorPassword text],"doctorlogin"];
            NSLog(@"PostData: %@",post);
            
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSURL *url = [NSURL URLWithString:[selectDoctorLoginURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString* resData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", resData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:resData error:nil];
                NSLog(@"%@",jsonData);
                
               
                success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                 errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
                errormsginvalid = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
                NSLog(@"succeeessss %d",success);
                if(success == 1)
                {
                    NSLog(@"entered success");
                   NSDictionary*test = [jsonData objectForKey:@"doctor"];
                   
                   
                    NSString *firname =[test objectForKey:@"firstname"];
                    NSString *lasname =[test objectForKey:@"lastname"];
                name = [NSString stringWithFormat: @"%@ %@", firname, lasname];
                   
                    NSLog(@"doctor name%@",name);
                doctorId = [test objectForKey:@"doctor_sk"];
                     NSLog(@"doctor id%@",doctorId);
                        
                       
            
                    
                    self.logDoctorId.text =@"";
                    self.logDoctorPassword.text =@"";
                  
                    
                    
                    [self.view endEditing:YES];
                    
                    
                    
                   historyOfAppointments *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"listOfPendingAppts"];
                   [self.navigationController pushViewController:secondViewController animated:YES];
                      secondViewController.doctorsName =name;
                        secondViewController.doctorsId =doctorId;
                    
                }
                if (errormsg == 2) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approval status Pending !"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    
                    [alert show];

                }
                if (errormsginvalid == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid email & password !"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    
                    [alert show];
                    
                }
                
                
                
            }
            
        }        }
 








 

}

- (IBAction)uploadPic:(id)sender
{
    imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    imagePickerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // requestType = 8;

    // Access the uncropped image from info dictionary
    int seconds = [[NSDate date] timeIntervalSince1970];
    imageName = [NSString stringWithFormat:@"%d.png", seconds];
      NSLog(@"imageeeeee  name  :%@",imageName);
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageData=UIImageJPEGRepresentation(image, 1.0);
    
   
    
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
 
    //    [picker release]

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




-(IBAction)doctorRegister:(id)sender
{
    NSString *phoneRegex = @"^[0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
   NSString *passRegex = @"^([a-zA-Z0-9]{4,18}?)$";
     NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
 
    
    if (self.logPhoneText.text.length<1 ||self.logAgeText.text.length>2 ||self.logPassReg.text.length<7 || self.logLicenceText.text.length<1 || self.logDesignationTextId.text.length<1 ||self.logFirstnameText.text.length<1 || self.logAddressText.text.length<1 ||self.logCityText.text.length<1||self.logStateText.text.length<1 || self.logCountryText.text.length<1 ||self.logPincodeText.text.length<1  ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Not Successful !"
                                                        message:@"Check Your Fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
        
        else{
            
            
            if ([emailTest evaluateWithObject:self.logEmailText.text] == NO) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter a valid EmailID !"
                                                                message:@""
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];        }
            
            else{
                
                if ([passwordTest evaluateWithObject:self.logPassReg.text] == NO) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter password without space !"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    
                    [alert show];        }
                
                else{
                
                    if ([phoneTest evaluateWithObject:self.logPhoneText.text] == NO) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter valid phone number !"
                                                                        message:@""
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        
                        [alert show];        }
               
                    else{
        
        NSInteger success = 0;
     
    
        
        
        
        NSString *boundary = @"0xKhTmLbOuNdArY";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //Set the filename
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",imageName]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //append the image data
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        

        
       
        
        
        NSString *post =[[NSString alloc] initWithFormat:@"doclicence=%@&designationid=%@&docfirstname=%@&doclastname=%@&docemail=%@&docphone=%@&docaddress=%@&doccity=%@&docstate=%@&doccountry=%@&docpincode=%@&docphoto=%@&docpassword=%@&docdescription=%@&docage=%@&docgender=%@&tag=%s",[self.logLicenceText text],[self.logDesignationTextId text],[self.logFirstnameText text],[self.logLastnameText text],[self.logEmailText text],[self.logPhoneText text],[self.logAddressText text],[self.logCityText text],[self.logStateText text],[self.logCountryText text],[self.logPincodeText text],body,[self.logPassReg text],[self.logDesgText text],[self.logAgeText text],[self.logGenderText text],"docregistration"];
        NSLog(@"PostData: %@",post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
      
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSURL *url = [NSURL URLWithString:[selectDoctorRegURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [request setHTTPBody:postData];
        
        
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %d", [response statusCode]);
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString* resData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", resData);
            
            SBJsonParser *jsonParser = [SBJsonParser new];
            NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:resData error:nil];
            NSLog(@"%@",jsonData);
            
            //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
            success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
            NSLog(@"%d",success);
            if(success == 1)
            {
                
                self.logLicenceText.text =@"";
                self.logDesignationTextId.text =@"";
                self.logDesignationText.text =@"";
                self.logFirstnameText.text =@"";
                self.logLastnameText.text =@"";
                self.logEmailText.text =@"";
                self.logPhoneText.text =@"";
                self.logAddressText.text =@"";
                self.logCityText.text =@"";
                self.logStateText.text =@"";
                self.logCountryText.text =@"";
                self.logPincodeText.text =@"";
               self.logPassReg.text=@"";
                self.logDesgText.text=@"";
                self.logAgeText.text=@"";
                self.logGenderText.text=@"";
                
            
                
                [self.view endEditing:YES];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Successful !"
                                                                message:@""
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
            }
            
        }
            }
        }
    }
   
        }

}




-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [self.logLicence setHidden:YES];
            [self.logLicenceText setHidden:YES];
            [self.logDesignation setHidden:YES];
            [self.logDesignationText setHidden:YES];
            [self.logFirstname setHidden:YES];
            [self.logFirstnameText setHidden:YES];
            [self.logLastname setHidden:YES];
            [self.logLastnameText setHidden:YES];
            [self.logEmail setHidden:YES];
            [self.logEmailText setHidden:YES];
            [self.logPhone setHidden:YES];
            [self.logPhoneText setHidden:YES];
            
            [self.logAddress setHidden:YES];
            [self.logAddressText setHidden:YES];
            [self.logCity setHidden:YES];
            [self.logCityText setHidden:YES];
            [self.logState setHidden:YES];
            [self.logStateText setHidden:YES];
            [self.logCountry setHidden:YES];
            [self.logCountryText setHidden:YES];
            [self.logPincode setHidden:YES];
            [self.logPincodeText setHidden:YES];
          
            [self.logPasswordReq setHidden:YES];
            [self.sendPasswordRequest setHidden:YES];
            [self.doctorRegister setHidden:YES];
            [self.logPass setHidden:YES];
            [self.logPassReg setHidden:YES];
            [self.uploadPic setHidden:YES];
            [self.logAge setHidden:YES];
            
            [self.logAgeText setHidden:YES];
            [self.logDescription setHidden:YES];
            [self.logDesgText setHidden:YES];
            
            
            [self.logoDoc setHidden:NO];
            [self.logDoctorId setHidden:NO];
            [self.logDoctorPassword setHidden:NO];
            [self.doctorLogin setHidden:NO];
            [self.forgotPassword setHidden:NO];
            
            break;
        case 1:
            
            [self.logLicence setHidden:NO];
            [self.logLicenceText setHidden:NO];
            [self.logDesignation setHidden:NO];
            [self.logDesignationText setHidden:NO];
            [self.logFirstname setHidden:NO];
            [self.logFirstnameText setHidden:NO];
            [self.logLastname setHidden:NO];
            [self.logLastnameText setHidden:NO];
            [self.logEmail setHidden:NO];
            [self.logEmailText setHidden:NO];
            [self.logPhone setHidden:NO];
            [self.logPhoneText setHidden:NO];
            
            [self.logAddress setHidden:NO];
            [self.logAddressText setHidden:NO];
            [self.logCity setHidden:NO];
            [self.logCityText setHidden:NO];
            [self.logState setHidden:NO];
            [self.logStateText setHidden:NO];
            [self.logCountry setHidden:NO];
            [self.logCountryText setHidden:NO];
            [self.logPincode setHidden:NO];
            [self.logPincodeText setHidden:NO];
          
            [self.doctorRegister setHidden:NO];
            [self.logPass setHidden:NO];
            [self.logPassReg setHidden:NO];
            [self.uploadPic setHidden:NO];
            [self.logAge setHidden:NO];
            
            [self.logAgeText setHidden:NO];
            [self.logDescription setHidden:NO];
            [self.logDesgText setHidden:NO];
            
            [self.logoDoc setHidden:YES];
            [self.logDoctorId setHidden:YES];
            [self.logDoctorPassword setHidden:YES];
            [self.doctorLogin setHidden:YES];
            [self.forgotPassword setHidden:YES];
            [self.logPasswordReq setHidden:YES];
            [self.sendPasswordRequest setHidden:YES];
            break;
        default:
            
            break;
    }
}


- (IBAction)forgotPassword:(id)sender
{
    [self.logPasswordReq setHidden:NO];
    [self.sendPasswordRequest setHidden:NO];
}
- (IBAction)sendPasswordRequest:(id)sender
{
    [self.logPasswordReq setHidden:YES];
    [self.sendPasswordRequest setHidden:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Sent !"
                                                    message:@"Check Your Mail"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];

}




@end
