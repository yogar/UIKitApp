//
//  TableCell.swift
//  UiKitApp
//
//  Created by Егор Пехота on 04.11.2021.
//

import UIKit

class TableCell: UITableViewCell {
    
    static let registerID = "TableCell"
    
    var cellImageView = UIImageView()
    var cellLabelView = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addSubview(cellImageView)
        addSubview(cellLabelView)
        
        configureImageView()
        configureTitleLable()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
    }
    
    func configureTitleLable() {
        cellLabelView.textColor = .black
        cellLabelView.numberOfLines = 0
        cellLabelView.adjustsFontSizeToFitWidth = true
    }
    
    func configureImageConstraints() {
//        cellImageView.translatesAutoresizingMaskIntoConstraints = false
//        cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        cellImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor).isActive = true
    }

    func configureLableConstraints() {
//        cellLabelView.translatesAutoresizingMaskIntoConstraints = false
//        cellLabelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        cellLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        cellLabelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        cellLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}


