//
//  ViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 01.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    let cells = ["drop","flame","bolt","allergens","ladybug","ladybug"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTablewView()
        title = "Nature objects"
        // Do any additional setup after loading the view.
    }

    func configureTablewView() {
        tableView.rowHeight = 100
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.registerID)
    }
}

// MARK: - UITableViewDataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.registerID) as! TableCell
        let label = cells[indexPath.row]
        
//        cell.cellImageView.image = UIImage(systemName: label)
        cell.cellLabelView.text = label
        cell.cellLabelView.layer.borderWidth = 2
        
        print(cell.frame, cell.bounds)

        return cell
    }
}
