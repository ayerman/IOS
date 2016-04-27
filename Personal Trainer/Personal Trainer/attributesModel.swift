//
//  attributesModel.swift
//  Personal Trainer
//
//  Created by Aaron Yerman on 4/26/16.
//  Copyright © 2016 Aaron Yerman. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class attributesModel{
    public var _age : Int
    public var _weight : Int
    public var _height : Int
    public var _calorieIntake : Int
    public var _gender : String
    public var _minworked : Int
    public var _worktype : String
    public var _date : String

    init(age : Int,Weight weight:Int,Height height:Int,Cal calorieIntake:Int,Gender gender:String,Minutes minworked:Int,Type worktype:String,Date date:String){
        _age = age
        _weight = weight
        _height = height
        _calorieIntake = calorieIntake
        _gender = gender
        _minworked = minworked
        _worktype = worktype
        _date = date
    }
    
    init(){
        _age = 0
        _weight = 0
        _height = 0
        _calorieIntake = 0
        _gender = ""
        _minworked = 0
        _worktype = ""
        _date = ""
    }
    
    public func create(){
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Attributes",inManagedObjectContext:  context) as NSManagedObject
        
        newUser.setValue( _age , forKey: "age")
        newUser.setValue( _calorieIntake , forKey: "calorieintake")
        newUser.setValue( _height , forKey: "height")
        newUser.setValue( _weight , forKey: "weight")
        newUser.setValue( _minworked , forKey: "minworked")
        newUser.setValue( _worktype , forKey: "worktype")
        newUser.setValue( _date , forKey: "date")
        newUser.setValue( _gender , forKey: "gender")
        
        do{
            try context.save()
        }
        catch{
            
        }
    }
    
    public func update(){
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        do{
            let request = NSFetchRequest(entityName: "Attributes")
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    var date = (item.valueForKey("date") as! String)
                    if date == _date{
                        item.setValue( _age , forKey: "age")
                        item.setValue( _calorieIntake , forKey: "calorieintake")
                        item.setValue( _height , forKey: "height")
                        item.setValue( _weight , forKey: "weight")
                        item.setValue( _minworked , forKey: "minworked")
                        item.setValue( _worktype , forKey: "worktype")
                        item.setValue( _date , forKey: "date")
                        item.setValue( _gender , forKey: "gender")
                        do{
                            try context.save()
                        }
                        catch{
                            
                        }
                    }
                }
                
            }
        }
        catch{
            
        }
    }
    
    public func exists() -> Bool{
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        do{
            let request = NSFetchRequest(entityName: "Attributes")
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    var date = (item.valueForKey("date") as! String)
                    if date == _date{
                        return true
                    }
                }
                
            }
        }
        catch{
            
        }
        return false
    }
    
    
}