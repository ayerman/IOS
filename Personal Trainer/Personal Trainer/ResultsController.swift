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
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var puOut: UILabel!
    @IBOutlet weak var suOut: UILabel!
    @IBOutlet weak var mOut: UILabel!
    
    @IBOutlet weak var burn: UITextField!
    
    var fromDate : NSDate? = nil
    var toDate :NSDate? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    @IBAction func GoClick(sender: AnyObject) {
        var dBurn : Int = 0
        var ddBurn : Double = 0
        
        if Int(burn.text!) != nil{
            dBurn = Int(burn.text!)!
            ddBurn = Double(burn.text!)!
        }
        puOut.text = String(dBurn/10)
        suOut.text = String(dBurn/3)
        mOut.text = String(ddBurn/100)
    }
    
    public func update(){
        if bmiLb != nil {
            let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context : NSManagedObjectContext = appDel.managedObjectContext
            var count = 0
            var latestDate : NSDate? = nil
            do{
                let request = NSFetchRequest(entityName: "Attributes")
                let results = try context.executeFetchRequest(request)
                var currentModel = attributesModel()
                var avgWeight : Int = 0
            
                if results.count > 0 {
                    for item in results as! [NSManagedObject] {
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MMM-dd-yyyy"
                        var date = dateFormatter.dateFromString((item.valueForKey("date") as! String))!
                        if fromDate != nil{
                            let lessThanDate = fromDate!.compare(date)
                            if lessThanDate == NSComparisonResult.OrderedDescending{
                                continue
                            }
                        }
                        if toDate != nil{
                            let greaterThanDate = toDate!.compare(date)
                            if greaterThanDate == NSComparisonResult.OrderedAscending{
                                continue
                            }
                        }
                        count+=1
                        avgWeight += (item.valueForKey("weight") as! Int)
                        if latestDate != nil{
                            let test = latestDate!.compare(date)
                            if  test == NSComparisonResult.OrderedAscending {
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
                    bmiLb.text! = String("No bmi recorded")
                }
                
                if count > 0{
                    avgWeightLb.text! = String(avgWeight/count)
                }else if count == 0{
                    avgWeightLb.text! = "0"
                }
                if latestDate != nil{
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "MMM-dd-YYYY"
                    let str = formatter.stringFromDate(latestDate!)
                    dateLb.text! = str
                }else{
                    dateLb.text! = "No data in selected date range."
                }
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
