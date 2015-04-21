//
//  ActionViewController.swift
//  BeerRanking
//
//  Created by Developer on 24/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var SignIn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logButton(sender: AnyObject) {
        var query = PFQuery(className:"user")
        query.whereKey("email", equalTo:emailField.text)
        query.whereKey("hash", equalTo:pwdField.text)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "logged")
                        NSUserDefaults.standardUserDefaults().setObject(object.objectId, forKey: "userID")
                        self.performSegueWithIdentifier("loginSuccess", sender: LogInViewController.self)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
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
