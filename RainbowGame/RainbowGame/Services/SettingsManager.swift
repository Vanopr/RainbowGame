//
//  DataStore.swift
//  RainbowGame
//
//  Created by Сазонов Станислав on 15.11.2023.
//

import UIKit

enum CheckBox: Int {
    case green
    case systemGreen
    case pink
    case cyan
    case brown
    case purple
    case blue
    case orange
    case red
    case yellow
    case black
    case gray
}

final class SettingsManager {
    
    //MARK: - Shared
    static let shared = SettingsManager()
    
    //MARK: - Properties
    var timeNumber: Int = 60
    var speedNumber: Int = 4
    var sizeOfText: Int = 10
    var backgroundColor: Int = 0
    var ifRandomLocation: Bool = true
    
    var substrateSwitchStatus: Bool = false
    var gameCheckSwitchStatus: Bool = false
    
    var textAlignment: NSTextAlignment = .center
    var changeBackgroundColor: UIColor = .white
    var wordSize: CGFloat = 15
    var wordColor: UIColor = .black
    
    var selectedColors: [ColorModel] = [
        ColorModel(color: .green, colorName: "салатовый", isSelected: true),
        ColorModel(color: .systemGreen, colorName: "зеленый", isSelected: true),
        ColorModel(color: .systemPink, colorName: "розовый", isSelected: true),
        ColorModel(color: .lightBlue, colorName: "голубой", isSelected: true),
        ColorModel(color: .brown, colorName: "коричневый", isSelected: true),
        ColorModel(color: .purple, colorName: "фиолетовый", isSelected: true),
        ColorModel(color: .blue, colorName: "синий", isSelected: true),
        ColorModel(color: .orange, colorName: "оранжевый", isSelected: true),
        ColorModel(color: .red, colorName: "красный", isSelected: true),
        ColorModel(color: .systemYellow, colorName: "желтый", isSelected: true),
        ColorModel(color: .systemMint, colorName: "бирюзовый", isSelected: true),
        ColorModel(color: .gray, colorName: "серый", isSelected: true),
    ]
    
    //MARK: - Methods
    func updateTimeNumber(value: Int) {
        timeNumber = value
    }
    
    func updateSpeedNumber(value: Int) {
        speedNumber = value
    }
    
    func convertMinutesToSeconds(minutes: Int) -> Int {
        let seconds = minutes * 60
        return seconds
    }
    
    func updateBackgroundColor(color: UIColor) {
        changeBackgroundColor = color
    }
    
    func updateBackgroundColor(backgroundColor: UIColor) {
        changeBackgroundColor = backgroundColor
    }
    
    func updateTextColor(button: UIButton) {
        guard let checkBox = CheckBox(rawValue: button.tag) else { return }
        switch checkBox {
        case .green:
            wordColor = .green
        case .systemGreen:
            wordColor = .systemGreen
        case .pink:
            wordColor = .systemPink
        case .cyan:
            wordColor = .cyan
        case .brown:
            wordColor = .brown
        case .purple:
            wordColor = .purple
        case .blue:
            wordColor = .blue
        case .orange:
            wordColor = .orange
        case .red:
            wordColor = .red
        case .yellow:
            wordColor = .yellow
        case .black:
            wordColor = .black
        case .gray:
            wordColor = .gray
        }
    }
    
    func updateTextAlignment(alignment: NSTextAlignment) {
        textAlignment = alignment
    }
    
}
