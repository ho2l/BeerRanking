//
//  LoggedViewController.swift
//  BeerRanking
//
//  Created by Developer on 31/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class LoggedViewController: UIViewController {
    
    /*override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(true)
        if (NSUserDefaults.standardUserDefaults().boolForKey("logged") == true){
            self.view.hidden = true
            performSegueWithIdentifier("logViewSegue", sender: MasterViewController.self)
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("logged") == true){
            self.view.hidden = true
            performSegueWithIdentifier("logViewSegue", sender: MasterViewController.self)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
