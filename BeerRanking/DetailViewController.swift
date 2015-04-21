//
//  DetailViewController.swift
//  BeerRanking
//
//  Created by Developer on 24/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDesciption: UILabel!
    @IBOutlet weak var detailRate: UISlider!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailAvgRate: UILabel!
    @IBOutlet weak var detailYourRate: UILabel!
    @IBOutlet weak var detailRateButton: UIButton!
    var detailId:String?
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Beer = self.detailItem as? Beer {
            if let label = self.detailName {
                label.text=detail.name
            }
            if let label = self.detailDesciption {
                label.text=detail.description
            }
            if let label = self.detailAvgRate {
                label.text="Average Rate : \(detail.rate!)"
                if (detail.rate?.isNaN == true) {
                    label.text = "Average Rate : Unrated"
                }
            }
            detailId=detail.id
        }
    }
    
    @IBAction func Rating(sender: UISlider) {
        var currentValue = Float(round(sender.value*2.0)/2.0)
        detailRating.text = "\(currentValue)"
    }
    
    @IBAction func RatingSend(sender: AnyObject) {
        var RatingSender = PFObject(className: "rate")
        RatingSender["id_beer"]=detailId
        RatingSender["id_user"]=NSUserDefaults.standardUserDefaults().objectForKey("userID")
        RatingSender["rating"]=Float(round(detailRate.value*2.0)/2.0)
        RatingSender.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                self.viewDidLoad()
                println("Succes !")
            } else {
                println("Error !")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("logged") == true)
        {
            var query = PFQuery(className: "rate")
            query.whereKey("id_beer", equalTo: detailId)
            query.whereKey("id_user", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("userID"))
            var objects = query.findObjects() as [PFObject]
            if (objects.count>0){
                self.detailRate.hidden=true
                detailRating.hidden=true
                detailRateButton.hidden=true
                for object in objects {
                    var rate = object["rating"]
                    detailYourRate.text="Your Rate : \(rate)"
                }
            }
            else {
                self.detailRate.hidden=false
            }
        }
        else{
            println("Logged in detail")
            detailRating.hidden=true
            detailRate.hidden=true
            detailRateButton.hidden=true
            detailYourRate.hidden=true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

