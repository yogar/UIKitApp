//
//  TextEditing.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit

class ModalViewContoller: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 300
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        func animatePresentContainer() {
//            UIView.animate(withDuration: 0.3) {
//                self.containerViewBottomConstraint?.constant = 0
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
    
    func setupConstraints() {

//        view.addSubview(dimmedView)
        view.addSubview(containerView)
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
//            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}
