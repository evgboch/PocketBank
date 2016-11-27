//
//  CheckCashViewController.swift
//  PocketBank
//
//  Created by Евгений on 15.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit

class CheckCashViewController: UIViewController {
    
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


    @IBOutlet weak var upLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!

    @IBOutlet weak var sumGetPicker: UIDatePicker! {
        didSet {
            
            sumGetPicker.locale = Locale(identifier: "ru")
        
        }
    }
    
    @IBAction func refreshDate(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "wallet")
        
        wallet = [ : ]
    }
    
    @IBAction func checkDate(_ sender: Any) {
        
        let pickedDate = DateFormatter.localizedString(
            from: sumGetPicker.date,
            dateStyle: DateFormatter.Style.full,
            timeStyle: DateFormatter.Style.none)
        
        for walletKeys in wallet.keys {
            
            if pickedDate == walletKeys {
                
                sumLabel.text = "\( wallet[ walletKeys ]! ) ₽"
                
                break
                
            } else {
                
                sumLabel.text = "Данные отсутствуют"
                
            }
        }
    }
}


