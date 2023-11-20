//
//  RainbowCardView.swift
//  RainbowGame
//
//  Created by Vanopr on 13.11.2023.
//

import UIKit
import SnapKit

//MARK: - CheckViewDelegate
protocol CheckViewDelegate: AnyObject {
    func button()
}

//MARK: - RainbowCardView
final class RainbowCardView: UIView {
    
    //MARK: - Properties
    weak var delegate: CheckViewDelegate?
    private var cardBackgroundColor: UIColor?
    private var labelText: String?
    private var ifCardBackgroundOn  = SavingManager.getValueOfBool(forKey: .substrateSwitchStatus)
    private var ifCheckButtonOn = SavingManager.getValueOfBool(forKey: .gameCheckSwitchStatus)
    private var textColor: UIColor?
    
    //MARK: - UI Elements
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //MARK: - Init
    init(cardBackgroundColor: UIColor? = nil, labelText: String? = nil, textColor: UIColor?) {
        self.cardBackgroundColor = cardBackgroundColor
        self.labelText = labelText
        self.textColor = textColor
        super.init(frame: CGRect.zero)
        setupView()
        setupCheckButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupView() {
        layer.cornerRadius = 15
        
        if ifCardBackgroundOn {
            backgroundColor = cardBackgroundColor
        } else {
            label.textColor = cardBackgroundColor
        }
        setupLabel()
    }
    
    private func setupLabel() {
        label.text = labelText
        label.textColor = textColor
        label.font = .boldSystemFont(ofSize: SettingsManager.shared.wordSize)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupCheckButton() {
        guard ifCheckButtonOn else {return}
        addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.height.equalTo(self.snp.height).inset(2)
            make.width.equalTo(self.snp.height).inset(2)
        }
        checkButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
        
    private func imageSet(_ button: UIButton, with imageName: String) {
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .medium)
        let image = UIImage(systemName: imageName, withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
    }
    
    //MARK: - Buttons target
    @objc private func didButtonTapped() {
        delegate?.button()
        if checkButton.isSelected {
            checkButton.isSelected = false
            checkButton.setImage(nil, for: .normal)
        } else {
            checkButton.isSelected = true
            checkButton.tintColor = .green
            imageSet(checkButton, with: "checkmark.circle.fill")
        }
        self.reloadInputViews()
    }
}
