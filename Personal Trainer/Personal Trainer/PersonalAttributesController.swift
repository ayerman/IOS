//
//  PersonalAttributesController.swift
//  Personal Trainer
//
//  Created by Aaron Yerman on 4/5/16.
//  Copyright © 2016 Aaron Yerman. All rights reserved.
//

import UIKit
import CoreData

class PersonalAttributesController: UIViewController {

    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var intake: UITextField!
    @IBOutlet weak var timeExer: UITextField!
    @IBOutlet weak var intensitySelection: UIPickerView!
    @IBOutlet weak var gender: UITextField!
    
    var intensity = ["Light","Medium","Heavy"]
    var selectedItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date : NSDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM-dd-YYYY"
        let str = formatter.stringFromDate(date)
        dateLb.text = str
        selectedItem = intensity[0]
        let doubleFormatter = NSNumberFormatter()
        doubleFormatter.minimumFractionDigits = 0
        doubleFormatter.maximumFractionDigits = 0
        var model = attributesModel()
        model._date = str
        model.getAttributes()
        age.text! = String(model._age)
        height.text! = String(model._height)
        weight.text! = String(model._weight)
        intake.text! = String(model._calorieIntake)
        timeExer.text! = String(model._minworked)
        gender.text! = String(model._gender)
        var count = 0
        for item in intensity {
            if item == model._worktype {
                selectedItem = item
                intensitySelection.selectRow(count,inComponent: 0,animated: true)
            }
            count+=1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func SaveClick(sender: AnyObject) {
        var attAge : Int = 0
        var calIntake : Int = 0
        var attHeight : Int = 0
        var attWeight : Int = 0
        var exerTime : Int = 0
        
        if Int(age.text!) != nil{
            attAge = Int(age.text!)!
        }
        
        if Int(intake.text!) != nil{
            calIntake = Int(intake.text!)!
        }
        
        if Double(height.text!) != nil{
            attHeight = Int(Double(height.text!)!)
        }
        
        if Double(weight.text!) != nil{
            attWeight = Int(Double(weight.text!)!)
        }
        
        if Double(timeExer.text!) != nil{
            exerTime = Int(Double(timeExer.text!)!)
        }
        
        
        var model = attributesModel(age: attAge,Weight:attWeight,Height: attHeight,Cal: calIntake,Gender: gender.text!,Minutes: exerTime,Type: selectedItem,Date: dateLb.text!)
        
        if model.exists(){
            model.update()
        }else{
            model.create()
        }
        
        let controllers = self.tabBarController?.viewControllers
        let resultsController = controllers![1] as! ResultsController
        resultsController.update()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.intensity.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.intensity[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedItem = intensity[row]
    }
}
