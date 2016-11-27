//
//  RatesViewController.swift
//  PocketBank
//
//  Created by Евгений on 22.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit

class RatesViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    var cdol:Double = 0.0
    var ceur:Double = 0.0

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var eurEdit: UITextField!
    @IBOutlet weak var usdEdit: UITextField!
    
    @IBOutlet weak var rubEurConvertedLabel: UILabel!
    @IBOutlet weak var rubUsdConvertedLabel: UILabel!
    
    @IBAction func refreshRates(_ sender: Any) {
        
        RequestRate()
        
        view.endEditing(true)

    }
    
    func convertEuros() {
        
        RequestRate()
        
        if let eurConvertString = eurEdit.text, let eurRub = Double(eurConvertString) {
            
            let rubles = eurRub * ceur
            
            rubEurConvertedLabel.text = " \(rubles) ₽"
            
        }
    }
    
    func convertUSD() {
        
        RequestRate()
        
        if let usdConvertString = usdEdit.text, let usdRub = Double(usdConvertString) {
            
            let rubles = usdRub * cdol
            
            rubUsdConvertedLabel.text = " \(rubles) ₽"
            
        }
    }
    
    @IBAction func eurFieldChanged(_ sender: Any) {
        convertEuros()
    }
    
    @IBAction func usdFieldChanged(_ sender: Any) {
        convertUSD()
    }
    
    
    func HTTPsendRequest (request: URLRequest, callback: @escaping (String, String?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
            {
                data, response, error in
                if error != nil {
                    callback("", (error!.localizedDescription) as String)
                } else {
                    callback(NSString(data: data!, encoding: String.Encoding.windowsCP1251.rawValue) as! String, nil)
                }
        })
        task.resume()
    }
        
    func HTTPGet(url: String, callback: @escaping (String, String?) -> Void) {
        
        let request = URLRequest(url: URL(string: url)!)
        HTTPsendRequest(request: request, callback: callback)
        
    }
    
    func RequestRate () {
        
        HTTPGet(url: "http://www.cbr.ru/scripts/XML_daily.asp") {
            (data: String, error:String?) -> Void in
            if error != nil {
                self.titleLabel.text = "Ошибка"
            } else {
                
                var num = data.range(of: "USD")!.lowerBound
                var res = data.substring(from: num)
                var num2 = res.range(of: "</Value>")!.lowerBound
                var res2 = res.substring(to: num2)
                var num3 = res2.range(of: "<Value>")!.upperBound
                var USD = res2.substring(from: num3)

                USD = USD.replacingOccurrences(of: ",", with: ".")
                
                self.cdol = Double(USD)!
                
                num = data.range(of: "EUR")!.lowerBound
                res = data.substring(from: num)
                num2 = res.range(of: "</Value>")!.lowerBound
                res2 = res.substring(to: num2)
                num3 = res2.range(of: "<Value>")!.upperBound
                var EUR = res2.substring(from: num3)
                
                EUR = EUR.replacingOccurrences(of: ",", with: ".")
                
                self.ceur = Double(EUR)!
                
                DispatchQueue.main.async {
                    self.usdLabel.text = "USD $: \(USD) ₽"
                    self.eurLabel.text = "EUR €: \(EUR) ₽"
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
}


