//
//  MasterViewController.swift
//  BeerRanking
//
//  Created by Developer on 24/03/2015.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var userId:Int?


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        /*let logButton = UIBarButtonItem(title: "Log In", style: .Plain, target: AccountViewController.self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = logButton*/
        navigationItem.setHidesBackButton(true, animated: true)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        var query = PFQuery(className:"beer")
        query.findObjectsInBackgroundWithBlock {
            (beers: [AnyObject]!, error: NSError!) -> Void in
            if error == nil && beers != nil {
                if let beers = beers as? [PFObject] {
                    for beer in beers {
                        var beerObject = Beer()
                        var count:Float = 0
                        var sum:Float = 0
                        var query2 = PFQuery(className: "rate")
                        query2.whereKey("id_beer", equalTo: beer.objectId)
                        var rates = query2.findObjects() as [PFObject]
                        println(rates.count)
                        for rate in rates {
                            println(rate["rating"])
                            var rating:Float = rate["rating"] as Float
                            sum = (sum+rating)
                            count = count+1
                            println(sum)
                        }
                        var finalRate=(sum/count)
                        beerObject.change(beer.objectId, name: beer["name"] as String, description: beer["description"] as String, rate: finalRate)
                        self.objects.insertObject(beerObject, atIndex: 0)
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        println(beerObject.rate)
                        println(beer.objectId)
                    }
                }
            } else {
                println(error)
            }
            
        }
    }
    
    func insertNewObject(sender: UIBarButtonItem) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as Beer
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as Beer
        cell.textLabel.text = object.name
        if (object.rate?.isNaN == true){
            cell.detailTextLabel?.text = "Unrated"
        }
        else {
            cell.detailTextLabel?.text = "\(object.rate!)"
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

