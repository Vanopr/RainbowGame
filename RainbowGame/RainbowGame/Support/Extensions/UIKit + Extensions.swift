//
//  UIKit + Extensions.swift
//  RainbowGame
//
//  Created by Сазонов Станислав on 18.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, fontSize: CGFloat) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.text = text
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIStackView {
    convenience init(spacing: CGFloat, axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


extension UISlider {
    convenience init(maximumValue: Float) {
        self .init()
        self.minimumTrackTintColor = .orange
        self.maximumValue = maximumValue
        self.minimumValue = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    convenience init(vectorIsHidden: Bool) {
        self.init()
        self.image = UIImage(named: "vector")
        self.isHidden = vectorIsHidden
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    convenience init(whiteVectorIsHidden: Bool) {
        self.init()
        self.image = UIImage(named: "whiteVector")
        self.isHidden = whiteVectorIsHidden
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    convenience init(buttonColor : UIColor) {
        self.init()
        self.backgroundColor = buttonColor
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
    }
}
