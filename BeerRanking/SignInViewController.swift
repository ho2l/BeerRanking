//
//  SignInViewController.swift
//  BeerRanking
//
//  Created by Developer on 07/04/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Pwd: UITextField!
    @IBOutlet weak var PwdConf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn(sender: AnyObject) {
        if (Pwd.hasText()==true && Name.hasText()==true && Email.hasText()==true && Pwd.text==PwdConf.text){
            var SignIn = PFObject(className: "user")
            SignIn["name"]=Name.text
            SignIn["email"]=Email.text
            SignIn["hash"]=Pwd.text
            SignIn.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    self.performSegueWithIdentifier("SignInSucces", sender: SignInViewController.self)
                    println("Succes !")
                } else {
                    println("Error !")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
