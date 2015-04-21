//
//  AccountViewController.swift
//  BeerRanking
//
//  Created by Developer on 30/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backMaster")
        navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogOff(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "logged")
        println(NSUserDefaults.standardUserDefaults().boolForKey("logged"))
        backMaster()
    }
    
    func backMaster(){
        performSegueWithIdentifier("backMaster", sender: self)
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
