//
//  EntriesListViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 23.11.2021.
//

import UIKit
import CoreData
import Combine

class EntriesListViewController: UICollectionViewController {
    let entriesProvider: EntriesProvider
    var dataSource: UICollectionViewDiffableDataSource<Int, NSManagedObjectID>!
    var cancellables = Set<AnyCancellable>()
    weak var modalDelegate: ModalViewContollerDelegate?
    
    init(persistenceController: PersistenceController, collectionViewLayout: UICollectionViewLayout) {
        self.entriesProvider = EntriesProvider(controller: persistenceController)
        
        super.init(collectionViewLayout: collectionViewLayout)
        self.modalDelegate = self
    }
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Add entry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        return button
    }()

    
    override func viewDidLoad() {
        dataSource = makeDataSource()
        collectionView.dataSource = dataSource
        
        entriesProvider.$snapshot
            .sink(receiveValue: { [weak self] snapshot in
                if let snapshot = snapshot {
                    self?.dataSource.apply(snapshot)
                }
            })
            .store(in: &cancellables)
        
        collectionView.addSubview(button)
        setupButtonConstraints()
        button.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, NSManagedObjectID> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, NSManagedObjectID> { [weak self] (cell, indexPath, item) in
            
            guard let entry = self?.entriesProvider.object(at: indexPath) else { return }
            
            var content = cell.defaultContentConfiguration()
            content.text = entry.situation
            cell.contentConfiguration = content
        }
        
        return UICollectionViewDiffableDataSource<Int, NSManagedObjectID>(collectionView: collectionView) { collectionView, indexPath, identifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
    
    @objc func presentModalViewController() {
        modalDelegate?.presentViewController()
    }
}

extension EntriesListViewController: ModalViewContollerDelegate {
    func presentViewController() {
        let viewController = ModalViewContoller()
        viewController.textFieldDelegate = self
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
    }
}


extension EntriesListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        if let situation = textField.text {
            entriesProvider.createEntry(situation: situation)
        }
        return true
    }
}
