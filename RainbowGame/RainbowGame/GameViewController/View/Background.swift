//
//  Background.swift
//  RainbowGame
//
//  Created by Vanopr on 13.11.2023.
//

import UIKit

final class Background: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        switch SettingsManager.shared.backgroundColor {
        case 0:
            backgroundColor = .background
        case 1:
            backgroundColor = .white
        case 2:
            backgroundColor = .black
        default:
            backgroundColor = .background
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
