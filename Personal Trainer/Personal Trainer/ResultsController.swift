//
//  ResultsController.swift
//  Personal Trainer
//
//  Created by Aaron Yerman on 4/5/16.
//  Copyright © 2016 Aaron Yerman. All rights reserved.
//

import UIKit
import CoreData

class ResultsController: UIViewController {

    @IBOutlet weak var bmiLb: UILabel!
    @IBOutlet weak var avgWeightLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    public func update(){
        if bmiLb != nil {
            let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context : NSManagedObjectContext = appDel.managedObjectContext
        
            do{
                let request = NSFetchRequest(entityName: "Attributes")
                let results = try context.executeFetchRequest(request)
                var currentModel = attributesModel()
                var avgWeight : Int = 0
            
                if results.count > 0 {
                    var latestDate : NSDate? = nil
                    for item in results as! [NSManagedObject] {
                        avgWeight += (item.valueForKey("weight") as! Int)
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MMM-dd-yyyy"
                        var date = dateFormatter.dateFromString((item.valueForKey("date") as! String))!
                        if let newDate = latestDate{
                            let test = newDate.compare(date)
                            if  test == NSComparisonResult.OrderedDescending {
                                latestDate = date
                                currentModel._age = (item.valueForKey("age") as! Int)
                                currentModel._calorieIntake = (item.valueForKey("calorieintake") as! Int)
                                currentModel._date = (item.valueForKey("date") as! String)
                                currentModel._gender = (item.valueForKey("gender") as! String)
                                currentModel._height = (item.valueForKey("height") as! Int)
                                currentModel._minworked = (item.valueForKey("minworked") as! Int)
                                currentModel._weight = (item.valueForKey("weight") as! Int)
                                currentModel._worktype = (item.valueForKey("worktype") as! String)
                            }
                        }else{
                            latestDate = date
                            currentModel._age = (item.valueForKey("age") as! Int)
                            currentModel._calorieIntake = (item.valueForKey("calorieintake") as! Int)
                            currentModel._date = (item.valueForKey("date") as! String)
                            currentModel._gender = (item.valueForKey("gender") as! String)
                            currentModel._height = (item.valueForKey("height") as! Int)
                            currentModel._minworked = (item.valueForKey("minworked") as! Int)
                            currentModel._weight = (item.valueForKey("weight") as! Int)
                            currentModel._worktype = (item.valueForKey("worktype") as! String)
                        }
                    }
                
                }
                var bmiVal : Double = 0
                if currentModel._height != 0{
                    bmiVal = Double(currentModel._weight * 703)/pow(Double(currentModel._height),2.0)
                }
                let formatter = NSNumberFormatter()
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                if bmiVal != 0 {
                    bmiLb.text! = formatter.stringFromNumber(bmiVal)!
                }else{
                    bmiLb.text! = String("No bmi for " + currentModel._date)
                }
                avgWeightLb.text! = String(avgWeight)
            }
            catch{
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
