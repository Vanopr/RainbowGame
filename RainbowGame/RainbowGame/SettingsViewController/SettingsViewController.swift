//
//  SettingsViewController.swift
//  RainbowGame
//
//  Created by sidzhe on 12.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - UI
    
    private let mainStackView = UIStackView(spacing: 20, axis: .vertical, alignment: .center)
    
    private let timeView = UIView(backgroundColor: .white)
    private let timeStackView = UIStackView(spacing: 10, axis: .horizontal, alignment: .center)
    private let timeSlider = UISlider(maximumValue: 22)
    private let timeTextLabel = UILabel(text: "время игры, мин", fontSize: 15)
    private let timeNumber = UILabel(text: "1", fontSize: 20)
    
    private let speedView = UIView(backgroundColor: .white)
    private let speedStackView = UIStackView(spacing: 10, axis: .horizontal, alignment: .center)
    private let speedLabel = UILabel(text: "скорость смены заданий, сек", fontSize: 15)
    private let speedSlider = UISlider(maximumValue: 4)
    private let speedNumber = UILabel(text: "1", fontSize: 20)
    
    private let substrateView = UIView(backgroundColor: .white)
    private let substrateStackView = UIStackView(spacing: 50, axis: .horizontal, alignment: .center)
    private let substrateLabel = UILabel(text: "подложка для букв", fontSize: 15)
    private lazy var switchSubstrate: UISwitch = {
        let element = UISwitch()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let gameCheckView = UIView(backgroundColor: .white)
    private let gameCheckStackView = UIStackView(spacing: 40, axis: .horizontal, alignment: .center)
    private let gameCheckLabel = UILabel(text: "игра с проверкой заданий", fontSize: 15)
    private lazy var gameCheckSwitch: UISwitch = {
        let element = UISwitch()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let wordColorView = UIView(backgroundColor: .white)
    private let wordColorStackView = UIStackView(spacing: 20, axis: .horizontal, alignment: .center)
    private let wordColorLabel = UILabel(text: "цвета букв", fontSize: 15)
    private let wordColorCheckBoxesStackView = UIStackView(spacing: 15, axis: .vertical, alignment: .center)
    
    private let checkBoxesTopStackView = UIStackView(spacing: 10, axis: .horizontal, alignment: .center)
    
    
    private let greenCheckBox = UIButton(buttonColor: .green)
    private let systemGreenCheckBox = UIButton(buttonColor: .systemGreen)
    private let pinkCheckBox = UIButton(buttonColor: .systemPink)
    private let cyanCheckBox = UIButton(buttonColor: .lightBlue)
    private let brownCheckBox = UIButton(buttonColor: .brown)
    private let purpleCheckBox = UIButton(buttonColor: .purple)
    
    private let checkBoxesBottonStackView = UIStackView(spacing: 10, axis: .horizontal, alignment: .center)
    
    private let blueCheckBox = UIButton(buttonColor: .blue)
    private let orangeCheckBox = UIButton(buttonColor: .orange)
    private let redCheckBox = UIButton(buttonColor: .red)
    private let yellowCheckBox = UIButton(buttonColor: .systemYellow)
    private let mintCheckBox = UIButton(buttonColor: .systemMint)
    private let grayCheckBox = UIButton(buttonColor: .gray)
    
    private let wordSizeView = UIView(backgroundColor: .white)
    private let wordSizeStackView = UIStackView(spacing: 35, axis: .horizontal, alignment: .center)
    private let wordSizeLabel = UILabel(text: "размер букв", fontSize: 15)
    private lazy var stepper: UIStepper = {
        let element = UIStepper()
        element.minimumValue = 5
        element.maximumValue = 20
        element.value = 15
        element.stepValue = 1
        element.addTarget(self, action: #selector(tapAddFont), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private let wordSizeSample = UILabel(text: "Aa", fontSize: SettingsManager.shared.wordSize)
    
    private let backgroundColorView = UIView(backgroundColor: .white)
    private let backgroundColorStackView = UIStackView(spacing: 10, axis: .vertical, alignment: .leading)
    private let backgroundColorLabel = UILabel(text: "цвет фона", fontSize: 15)
    private lazy var backgroundColorSegmentedControl: UISegmentedControl = {
        let element = UISegmentedControl()
        element.insertSegment(withTitle: "Серый", at: 1, animated: true)
        element.insertSegment(withTitle: "Белый", at: 2, animated: true)
        element.insertSegment(withTitle: "Черный", at: 3, animated: true)
        element.addTarget(self, action: #selector(backgroundColorSet(_:)), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let wordPositionView = UIView(backgroundColor: .white)
    private let wordPositionStackView = UIStackView(spacing: 10, axis: .vertical, alignment: .leading)
    private let wordPositionLabel = UILabel(text: "расположение слова на экране", fontSize: 15)
    private lazy var wordPositionSegmentedControl: UISegmentedControl = {
        let element = UISegmentedControl()
        element.insertSegment(withTitle: "Случайное", at: 4, animated: true)
        element.insertSegment(withTitle: "По центру", at: 5, animated: true)
        element.addTarget(self, action: #selector(randomLocation(_:)), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    // MARK: - Private Properties
    
    private let gameSettings = SettingsManager.shared
    
    private let widthAnchorConstant: CGFloat = 300
    private let heighAnchorConstant: CGFloat = 65
    
    private let checkboxSize: CGFloat = 25
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        setupRawValue()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SavingManager.saveSettings()
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)
        ]
        let customLeftButton = UIBarButtonItem(
            image: UIImage(named: "backButton"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        customLeftButton.tintColor = .black
        navigationItem.leftBarButtonItem = customLeftButton
        
        view.backgroundColor = .lightGray
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(timeView)
        mainStackView.addArrangedSubview(speedView)
        mainStackView.addArrangedSubview(gameCheckView)
        mainStackView.addArrangedSubview(wordColorView)
        mainStackView.addArrangedSubview(wordSizeView)
        mainStackView.addArrangedSubview(substrateView)
        mainStackView.addArrangedSubview(backgroundColorView)
        mainStackView.addArrangedSubview(wordPositionView)
        
        timeView.addSubview(timeStackView)
        speedView.addSubview(speedStackView)
        gameCheckView.addSubview(gameCheckStackView)
        wordColorView.addSubview(wordColorStackView)
        wordSizeView.addSubview(wordSizeStackView)
        substrateView.addSubview(substrateStackView)
        backgroundColorView.addSubview(backgroundColorStackView)
        wordPositionView.addSubview(wordPositionStackView)
        
        timeStackView.addArrangedSubview(timeTextLabel)
        timeStackView.addArrangedSubview(timeSlider)
        timeStackView.addArrangedSubview(timeNumber)
        
        speedStackView.addArrangedSubview(speedLabel)
        speedStackView.addArrangedSubview(speedSlider)
        speedStackView.addArrangedSubview(speedNumber)
        
        gameCheckStackView.addArrangedSubview(gameCheckLabel)
        gameCheckStackView.addArrangedSubview(gameCheckSwitch)
        
        wordColorStackView.addArrangedSubview(wordColorLabel)
        wordColorStackView.addArrangedSubview(wordColorCheckBoxesStackView)
        
        wordColorCheckBoxesStackView.addArrangedSubview(checkBoxesTopStackView)
        wordColorCheckBoxesStackView.addArrangedSubview(checkBoxesBottonStackView)
        
        checkBoxesTopStackView.addArrangedSubview(greenCheckBox)
        checkBoxesTopStackView.addArrangedSubview(systemGreenCheckBox)
        checkBoxesTopStackView.addArrangedSubview(pinkCheckBox)
        checkBoxesTopStackView.addArrangedSubview(cyanCheckBox)
        checkBoxesTopStackView.addArrangedSubview(brownCheckBox)
        checkBoxesTopStackView.addArrangedSubview(purpleCheckBox)
        
        checkBoxesBottonStackView.addArrangedSubview(blueCheckBox)
        checkBoxesBottonStackView.addArrangedSubview(orangeCheckBox)
        checkBoxesBottonStackView.addArrangedSubview(redCheckBox)
        checkBoxesBottonStackView.addArrangedSubview(yellowCheckBox)
        checkBoxesBottonStackView.addArrangedSubview(mintCheckBox)
        checkBoxesBottonStackView.addArrangedSubview(grayCheckBox)
        
        wordSizeStackView.addArrangedSubview(wordSizeLabel)
        wordSizeStackView.addArrangedSubview(stepper)
        wordSizeStackView.addArrangedSubview(wordSizeSample)
        
        substrateStackView.addArrangedSubview(substrateLabel)
        substrateStackView.addArrangedSubview(switchSubstrate)
        
        backgroundColorStackView.addArrangedSubview(backgroundColorLabel)
        backgroundColorStackView.addArrangedSubview(backgroundColorSegmentedControl)
        
        wordPositionStackView.addArrangedSubview(wordPositionLabel)
        wordPositionStackView.addArrangedSubview(wordPositionSegmentedControl)
        
        timeSlider.addTarget(self, action: #selector(timeSliderChanged), for: .valueChanged)
        speedSlider.addTarget(self, action: #selector(speedSliderChanged), for: .valueChanged)
        switchSubstrate.addTarget(self, action: #selector(substrateSwitchChanged), for: .valueChanged)
        gameCheckSwitch.addTarget(self, action: #selector(gameCheckChanged), for: .valueChanged)
        
        let checkboxes = [
            greenCheckBox,
            systemGreenCheckBox,
            pinkCheckBox,
            cyanCheckBox,
            brownCheckBox,
            purpleCheckBox,
            blueCheckBox,
            orangeCheckBox,
            redCheckBox,
            yellowCheckBox,
            mintCheckBox,
            grayCheckBox
        ]
        
        for (index, checkbox) in checkboxes.enumerated() {
            checkbox.tag = index
            checkbox.isSelected = SettingsManager.shared.selectedColors[index].isSelected
            checkbox.setImage(UIImage(systemName: "checkmark"), for: .selected)
            checkbox.tintColor = .black
            checkbox.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timeView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            timeView.heightAnchor.constraint(equalToConstant: heighAnchorConstant),
            
            speedView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            speedView.heightAnchor.constraint(equalToConstant: heighAnchorConstant),
            
            gameCheckView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            gameCheckView.heightAnchor.constraint(equalToConstant: heighAnchorConstant),
            
            wordColorView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            wordColorView.heightAnchor.constraint(equalToConstant: 85),
            
            greenCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            greenCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            systemGreenCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            systemGreenCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            pinkCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            pinkCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            cyanCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            cyanCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            brownCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            brownCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            purpleCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            purpleCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            
            blueCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            blueCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            orangeCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            orangeCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            redCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            redCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            yellowCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            yellowCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            mintCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            mintCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            grayCheckBox.widthAnchor.constraint(equalToConstant: checkboxSize),
            grayCheckBox.heightAnchor.constraint(equalToConstant: checkboxSize),
            
            wordSizeView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            wordSizeView.heightAnchor.constraint(equalToConstant: heighAnchorConstant),
            
            substrateView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            substrateView.heightAnchor.constraint(equalToConstant: heighAnchorConstant),
            
            backgroundColorView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            backgroundColorView.heightAnchor.constraint(equalToConstant: 78),
            
            wordPositionView.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            wordPositionView.heightAnchor.constraint(equalToConstant: 78),
            
            timeStackView.topAnchor.constraint(equalTo: timeView.safeAreaLayoutGuide.topAnchor),
            timeStackView.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 10),
            timeStackView.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -10),
            timeStackView.bottomAnchor.constraint(equalTo: timeView.safeAreaLayoutGuide.bottomAnchor),
            
            timeNumber.widthAnchor.constraint(equalToConstant: 25),
            
            speedStackView.topAnchor.constraint(equalTo: speedView.safeAreaLayoutGuide.topAnchor),
            speedStackView.leadingAnchor.constraint(equalTo: speedView.leadingAnchor, constant: 10),
            speedStackView.trailingAnchor.constraint(equalTo: speedView.trailingAnchor, constant: -10),
            speedStackView.bottomAnchor.constraint(equalTo: speedView.safeAreaLayoutGuide.bottomAnchor),
            
            speedNumber.widthAnchor.constraint(equalToConstant: 25),
            
            gameCheckStackView.topAnchor.constraint(equalTo: gameCheckView.safeAreaLayoutGuide.topAnchor),
            gameCheckStackView.leadingAnchor.constraint(equalTo: gameCheckView.leadingAnchor, constant: 10),
            gameCheckStackView.trailingAnchor.constraint(equalTo: gameCheckView.trailingAnchor, constant: -10),
            gameCheckStackView.bottomAnchor.constraint(equalTo: gameCheckView.safeAreaLayoutGuide.bottomAnchor),
            
            wordColorStackView.topAnchor.constraint(equalTo: wordColorView.safeAreaLayoutGuide.topAnchor),
            wordColorStackView.leadingAnchor.constraint(equalTo: wordColorView.leadingAnchor, constant: 10),
            wordColorStackView.trailingAnchor.constraint(equalTo: wordColorView.trailingAnchor, constant: -10),
            wordColorStackView.bottomAnchor.constraint(equalTo: wordColorView.safeAreaLayoutGuide.bottomAnchor),
            
            substrateStackView.topAnchor.constraint(equalTo: substrateView.safeAreaLayoutGuide.topAnchor),
            substrateStackView.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 10),
            substrateStackView.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -10),
            substrateStackView.bottomAnchor.constraint(equalTo: substrateView.safeAreaLayoutGuide.bottomAnchor),
            
            wordSizeStackView.topAnchor.constraint(equalTo: wordSizeView.safeAreaLayoutGuide.topAnchor),
            wordSizeStackView.leadingAnchor.constraint(equalTo: wordSizeView.leadingAnchor, constant: 10),
            wordSizeStackView.trailingAnchor.constraint(equalTo: wordSizeView.trailingAnchor, constant: -10),
            wordSizeStackView.bottomAnchor.constraint(equalTo: wordSizeView.safeAreaLayoutGuide.bottomAnchor),
            
            backgroundColorStackView.topAnchor.constraint(equalTo: backgroundColorView.safeAreaLayoutGuide.topAnchor, constant: 10),
            backgroundColorStackView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 10),
            backgroundColorStackView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -10),
            backgroundColorStackView.bottomAnchor.constraint(equalTo: backgroundColorView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            backgroundColorSegmentedControl.centerXAnchor.constraint(equalTo: backgroundColorView.centerXAnchor),
            
            wordPositionStackView.topAnchor.constraint(equalTo: wordPositionView.safeAreaLayoutGuide.topAnchor, constant: 10),
            wordPositionStackView.leadingAnchor.constraint(equalTo: wordPositionView.leadingAnchor, constant: 10),
            wordPositionStackView.trailingAnchor.constraint(equalTo: wordPositionView.trailingAnchor, constant: -10),
            wordPositionStackView.bottomAnchor.constraint(equalTo: wordPositionView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            wordPositionSegmentedControl.centerXAnchor.constraint(equalTo: wordPositionView.centerXAnchor),
            
        ])
    }
    
    //MARK: - setupRawValue
    private func setupRawValue() {
        timeSlider.value = Float(gameSettings.timeNumber / 60)
        timeNumber.text = String(gameSettings.timeNumber / 60)
        speedSlider.value = Float(gameSettings.speedNumber)
        speedNumber.text = String(gameSettings.speedNumber)
        switchSubstrate.isOn  = gameSettings.substrateSwitchStatus
        gameCheckSwitch.isOn = gameSettings.gameCheckSwitchStatus
        backgroundColorSegmentedControl.selectedSegmentIndex = gameSettings.backgroundColor
        wordPositionSegmentedControl.selectedSegmentIndex = gameSettings.ifRandomLocation ? 0 : 1
    }
    // MARK: - Slider Actions
    
    @objc private func timeSliderChanged(_ sender: UISlider) {
        gameSettings.timeNumber = Int(sender.value * 60)
        timeNumber.text = String(format: "%.f", sender.value)
    }
    
    @objc private func speedSliderChanged(_ sender: UISlider) {
        gameSettings.speedNumber = Int(sender.value)
        speedNumber.text = String(format: "%.f", sender.value)
    }
    
    //MARK: - Back Button
    
    @objc func backButtonTapped() {
        if SettingsManager.shared.selectedColors.filter({ $0.isSelected }).count == 0 {
            alert()
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Switch Actions
    
    @objc private func substrateSwitchChanged(_ sender: UISwitch) {
        gameSettings.substrateSwitchStatus = sender.isOn ? true : false
    }
    
    @objc private func gameCheckChanged(_ sender: UISwitch) {
        gameSettings.gameCheckSwitchStatus = sender.isOn ? true : false
    }
    
    // MARK: - Checkbox Actions
    
    @objc private func checkboxButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        SettingsManager.shared.selectedColors[sender.tag].isSelected = !SettingsManager.shared.selectedColors[sender.tag].isSelected
    }
    //MARK: - Background Color
    
    @objc func backgroundColorSet(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            SettingsManager.shared.backgroundColor = 0
        case 1:
            SettingsManager.shared.backgroundColor = 1
        case 2:
            SettingsManager.shared.backgroundColor = 2
        default:
            break
        }
    }
    
    //MARK: - Location
    
    @objc func randomLocation(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            SettingsManager.shared.ifRandomLocation = true
        case 1:
            SettingsManager.shared.ifRandomLocation = false
        default:
            break
        }
    }
    
    @objc private func tapAddFont(_ sender: UIStepper) {
        wordSizeSample.font = .systemFont(ofSize: sender.value)
        SettingsManager.shared.wordSize = sender.value
    }
    
    //MARK: - Alert
    
    private func alert() {
        let alert = UIAlertController(title: "Внимание", message: "Нужно выбрать хоть один цвет букв", preferredStyle: .alert)
        let action = UIAlertAction(title: "Понял", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}



