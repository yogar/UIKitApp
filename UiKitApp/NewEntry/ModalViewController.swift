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
    
    lazy var textInputView: UITextField = {
        let view = UITextField()
        view.placeholder = "Some text"
        view.borderStyle = .roundedRect
        return view
    }()
    
    let defaultHeight: CGFloat = 400
    let dismissibleHeight: CGFloat = 200
    var currentContainerHeight: CGFloat = 400
    weak var textFieldDelegate: UITextFieldDelegate?
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        view.addSubview(textInputView)
        textInputView.delegate = textFieldDelegate
        
        setupConstraints()
        setupPanGesture()
    }

    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textInputView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textInputView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            textInputView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            textInputView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newHeight = currentContainerHeight - translation.y
        let isDraggingDown = translation.y > 0
        
        switch gesture.state {
        case .changed:
            UIView.animate(withDuration: 0.3) {
                self.containerViewHeightConstraint?.constant = newHeight
                self.view.layoutIfNeeded()
            }
        case .ended:
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.dismiss(animated: true)
            }
            // Condition 2: If new height is below default, animate back to default
            else if newHeight < defaultHeight {
                UIView.animate(withDuration: 0.4) {
                    self.containerViewHeightConstraint?.constant = self.defaultHeight
                    self.view.layoutIfNeeded()
                }
            }
            // Condition 3: If new height is below max and going down, set to default height
            else if newHeight < maximumContainerHeight && isDraggingDown {
                UIView.animate(withDuration: 0.4) {
                    self.containerViewHeightConstraint?.constant = self.defaultHeight
                    self.view.layoutIfNeeded()
                }
            }
            else if newHeight > defaultHeight && !isDraggingDown {
            // Condition 4: If new height is below max and going up, set to max height at top
                UIView.animate(withDuration: 0.4) {
                    self.containerViewHeightConstraint?.constant = self.maximumContainerHeight
                    self.view.layoutIfNeeded()
                }
            }
       default:
           break
       }
    }
    
}
