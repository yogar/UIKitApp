//
//  SFSymbolItem.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit

struct SFSymbolItem: Hashable {
    let name: String
    let image: UIImage
    
    init(name: String) {
        self.name = name
        self.image = UIImage(systemName: name)!
    }
}
