//
//  LogNavigationController.swift
//  BeerRanking
//
//  Created by Developer on 30/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class LogNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*if ((NSUserDefaults.standardUserDefaults().objectForKey("logged")) as Bool == true){
            performSegueWithIdentifier("Logged", sender: self)
        }
        else {
            performSegueWithIdentifier("LogSign", sender: self)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
