//
//  ConfigController.swift
//  Personal Trainer
//
//  Created by Aaron Yerman on 4/5/16.
//  Copyright © 2016 Aaron Yerman. All rights reserved.
//

import UIKit
import CoreData

class ConfigController: UIViewController {
    var controllers : [UIViewController]? = nil
    var resultsController : ResultsController? = nil
    
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var resultsPicker: UIPickerView!
    
    var results = ["Weight","Height","Calorie Intake","Workout Minutes"]
    var selectedItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllers = self.tabBarController?.viewControllers
        resultsController = controllers![1] as! ResultsController
        
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        do{
            let request = NSFetchRequest(entityName: "Attributes")
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                var fromDate : NSDate? = nil
                var toDate : NSDate? = nil
                for item in results as! [NSManagedObject] {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MMM-dd-yyyy"
                    var date = dateFormatter.dateFromString((item.valueForKey("date") as! String))!
                    if fromDate == nil{
                        fromDate = date
                        fromDatePicker.date = date
                    }else{
                        let lessThanDate = fromDate!.compare(date)
                        if lessThanDate == NSComparisonResult.OrderedDescending{
                            fromDate = date
                            fromDatePicker.date = date
                        }
                    }
                    
                    if toDate == nil{
                        toDate = date
                        toDatePicker.date = date
                    }else{
                        let greaterThanDate = toDate!.compare(date)
                        if greaterThanDate == NSComparisonResult.OrderedAscending{
                            toDate = date
                            toDatePicker.date = date
                        }
                    }
                }
            }
        }
        catch{
            
        }
        var count = 0
        for item in results {
            if item == resultsController?.resultsView {
                selectedItem = item
                resultsPicker.selectRow(count,inComponent: 0,animated: true)
            }
            count+=1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fromDateChange(sender: UIDatePicker) {
        resultsController!.fromDate = sender.date
        resultsController!.update()
    }
    @IBAction func toDateChanged(sender: UIDatePicker) {
        resultsController!.toDate = sender.date
        resultsController!.update()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.results.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.results[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedItem = results[row]
        resultsController?.resultsView = selectedItem
        resultsController?.update()
    }
    
}
