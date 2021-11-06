//
//  ViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 01.11.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    let dataItems = ["drop","flame","bolt","allergens","ladybug","ladybug"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTablewView()
        title = "Nature objects"
    }

    func configureTablewView() {
        tableView.rowHeight = 100
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.registerID)
    }

}

// MARK: - UITableViewDataSource
extension TableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.registerID) as! TableCell
        
        let label = dataItems[indexPath.row]
        
        cell.cellImageView.image = UIImage(systemName: label)
        cell.cellLabelView.text = label
        return cell
    }
}
