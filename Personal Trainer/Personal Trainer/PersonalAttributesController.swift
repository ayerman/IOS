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
        
        if let x: Int = Int(age.text!){
            attAge = x
        }
        
        if let x: Int = Int(intake.text!){
            calIntake = x
        }
        
        if let x: Int = Int(height.text!){
            attHeight = x
        }
        
        if let x: Int = Int(weight.text!){
            attWeight = x
        }
        
        if let x: Int = Int(timeExer.text!){
            exerTime = x
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
