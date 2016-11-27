//
//  EditCashViewController.swift
//  PocketBank
//
//  Created by Евгений on 15.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit

class EditCashViewController: UIViewController {
    
    var wallet: [String:Int] = [ : ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if UserDefaults.standard.dictionary(forKey: "wallet") != nil {
            
            wallet = UserDefaults.standard.dictionary(forKey: "wallet") as! [String : Int]
            
        }
        else {
            
            wallet = [ : ]
            
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var dateSender: UIDatePicker! {
        didSet {
            
            dateSender.locale = Locale(identifier: "ru")
            
        }
    }
    
    @IBAction func refreshMoneyDate(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "wallet")
        
        wallet = [ : ]
        
        view.endEditing(true)
        
        }
    
    @IBAction func addMoneyDate(_ sender: Any) {
        
        let text1 = DateFormatter.localizedString(from: dateSender.date, dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.none)
        
        let cash = Int(textField.text!)
        
        wallet [text1] = cash
                
        UserDefaults.standard.set(wallet, forKey: "wallet")
        
        view.endEditing(true)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
}

