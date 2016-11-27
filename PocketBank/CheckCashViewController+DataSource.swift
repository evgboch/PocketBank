//
//  CheckCashViewController+DataSource.swift
//  PocketBank
//
//  Created by Евгений on 17.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit

extension CheckCashViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "reude-id")
        
        let dates = dateList[indexPath.row]
        
        cell?.textLabel?.text = "5000"
        
        return cell!
    }
}

extension CheckCashViewController: UITableViewDelegate {
    
}

