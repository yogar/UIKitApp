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
    
    let defaultHeight: CGFloat = 400
    let dismissibleHeight: CGFloat = 200
    var currentContainerHeight: CGFloat = 400
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupPanGesture()
    }

    
    func setupConstraints() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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

        switch gesture.state {
        case .changed:
            if newHeight < defaultHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
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
//            else if newHeight < maximumContainerHeight && isDraggingDown {
//               // Condition 3: If new height is below max and going down, set to default height
//               animateContainerHeight(defaultHeight)
//            }
//            else if newHeight > defaultHeight && !isDraggingDown {
//               // Condition 4: If new height is below max and going up, set to max height at top
//               animateContainerHeight(maximumContainerHeight)
//            }
       default:
           break
       }
    }
    
}
