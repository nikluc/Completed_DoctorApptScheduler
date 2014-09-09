//
//  ViewController.m
//  DoctorApptScheduler
//
//  Created by administrator on 10/08/14.
//
//

#import "ViewController.h"
#import "doctorsListView.h"
#import "doctorsLoginView.h"
#import "patientsLoginPage.h"

#import "SBJson.h"

#define selectSpecialityURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=designationlist"
#define selectDoctorListURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=finddoctor"


UIPickerView *pickerView ;

@interface ViewController ()
@property (nonatomic, strong) UITextField *pickerViewTextField;

@end

@implementation ViewController
@synthesize pickerViewTextField = _pickerViewTextField;
@synthesize responseData;
static CGFloat leftMargin = 28;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
  
     [self selectSpecialityOfDoctors]; 
    
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:selectSpecialityURL]];
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
  


    }

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x += leftMargin;
    
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x += leftMargin;
    
    return bounds;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
   
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
		self.responseData = nil;
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError* error;
    
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"Guide: %@", json);
  
    artArray = [json objectForKey:@"designation"];
    
    [pickerView reloadAllComponents] ;
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//*******Picker view for CHOOSING SPECIALITY

-(void)selectSpecialityOfDoctors
{
    self.pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextField];
    
    
    
    
  self.selectSpeciality.delegate = self;
 [self.view addSubview:self.selectSpeciality];
    
   pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    //  self.pickerViewTextField.inputView = pickerView;
    self.selectSpeciality.inputView = pickerView;
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    //  self.pickerViewTextField.inputAccessoryView = toolBar;
    
    
    self.selectSpeciality.inputAccessoryView = toolBar;


}



- (void)cancelTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.selectSpeciality resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.selectSpeciality resignFirstResponder];
    
    // perform some action
}




#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [artArray count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *dict = [artArray objectAtIndex:row];
    NSLog(@"dict: %@", dict);
    return [dict objectForKey:@"designation"];
    
    
  //  NSString *item = [artArray objectAtIndex:row];
    
  //  return item;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSDictionary *dict = [artArray objectAtIndex:row];
    
    NSString* testVal =[dict objectForKey:@"designation"];
    NSString* testVal1 =[dict objectForKey:@"des_sk"];
    self.selectSpecialityId.text = [NSString stringWithFormat:@"%@",testVal1];
    
    self.selectSpeciality.text = [NSString stringWithFormat:@"%@",testVal];
}
//***************************************//


-(IBAction)findDoctors:(id)sender
{
 

    
  
    
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"speciality=%@&pincode=%@&tag=%s",[self.selectSpecialityId text],[self.enterPinCode text],"finddoctor"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectDoctorListURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        
      //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
       success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            
             artArrayDoctorList = [jsonData objectForKey:@"doctors"];
            
            doctorsListView *secViewController =     [self.storyboard instantiateViewControllerWithIdentifier:@"doctorsListView"];
            [self.navigationController pushViewController:secViewController animated:YES];
            
           
            
            
          
            secViewController.doctorListArray =artArrayDoctorList;
           
         /*   artArrayDoctorList = [jsonData objectForKey:@"doctors"];
            for (NSDictionary *photo in artArrayDoctorList)
            {
                
                
                NSString *title = [photo objectForKey:@"email"];
                 NSLog(@"email ... : %@",title);
                           }
         
            */
        }
        
        if (errormsg == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Doctors not available in this locality!"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }

        
        
            
        } else {

          NSLog(@"Login FAILED");
        }
     

}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}





- (IBAction)loginDoctors:(id)sender {
    
       
    
  doctorsLoginView *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"doctorsLoginView"];
  [self.navigationController pushViewController:secondViewController animated:YES];
    
}


- (IBAction)loginPatients:(id)sender
{
    patientsLoginPage *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"patientsLoginView"];
    [self.navigationController pushViewController:secondViewController animated:YES];
    
}



- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    if ([textField isEqual:self.enterPinCode])
    {
        if ([string isEqualToString:@" "] )
        {
            return NO;
        }
    }
    return YES;
}


@end
