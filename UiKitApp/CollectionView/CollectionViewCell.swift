//
//  CollectionViewCell.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    weak var modalDelegate: ModalViewContollerDelegate?
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Show modal", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = tintColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    lazy var containerStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews:
                                        [
                                        titleLabel,
                                        imageView,
                                        spacer,
                                        button
                                        ])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 1.0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        
        contentView.addSubview(containerStackView)
        setupConstraints()
        button.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentModalViewController() {
        modalDelegate?.presentViewController()
    }
}
