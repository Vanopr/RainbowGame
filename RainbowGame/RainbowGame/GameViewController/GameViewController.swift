//
//  GameViewController.swift
//  RainbowGame
//
//  Created by sidzhe on 12.11.2023.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    //MARK: - Data
    let background = Background()
    var cardViews: [RainbowCardView] = []
    var timer: Timer?
    var secondsPassed: Int = 0
    var isTimerPaused: Bool = false
    var isRandomLocationOn: Bool = SettingsManager.shared.ifRandomLocation
    var isContinueGame: Bool?
    var gameTime: Int = SettingsManager.shared.timeNumber
    var updateTime: Int = SettingsManager.shared.speedNumber
    var answerCheck: Int?
    var speed = 0
    var currentSpeedValue = 1
    
    //MARK: - UI Elements
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 40
        button.setTitle("X2", for: .normal)
        button.addTarget(self, action: #selector(tapXButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ifGameContinue()
        ifCheckButtonOn()
        setupBackGround()
        setupNavBar()
        setupCards()
        setupButton()
        startTimer()
    }
    //MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    //MARK: - SetupScreen
    private func setupCards() {
        let colors = SettingsManager.shared.selectedColors
        let colorsName = colors.shuffled()
        let textColor = SettingsManager.shared.selectedColors.filter { $0.isSelected }
        var top = 120
        for i in 0...5 {
            let colorText = textColor.shuffled().first
            let currentColors = colors.filter({ $0.color != colorText?.color })
            let card = RainbowCardView(cardBackgroundColor: currentColors[i].color , labelText: colorsName[i].colorName, textColor: colorText?.color )
            card.delegate = self
            view.addSubview(card)
            ifRandomLocationOn(top: top, card: card)
            top += (Int(view.frame.height) - 120) / 7
            cardViews.append(card)
        }
    }
    
    //MARK: - Location
    private func ifRandomLocationOn(top : Int, card: RainbowCardView) {
        if isRandomLocationOn {
            let leading = Int.random(in: 20...150)
            card.snp.makeConstraints { make in
                make.leading.equalTo(leading)
            }
        } else {
            card.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
            }
        }
        card.snp.makeConstraints { make in
            make.top.equalTo(top)
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
    }
    
    //MARK: - Setup UI
    private func setupBackGround() {
        view.backgroundColor = .white
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        title = formatTime(seconds: gameTime)
        let customLeftButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backButtonTapped))
        let customRightButton = UIBarButtonItem(image: UIImage(named: "pauseButton"), style: .plain, target: self, action: #selector(pauseButtonTapped))
        (background.backgroundColor == .black) ? (customLeftButton.tintColor = .white) : (customLeftButton.tintColor = .black)
        (background.backgroundColor == .black) ? (customRightButton.tintColor = .white) : (customRightButton.tintColor = .black)
        navigationItem.leftBarButtonItem = customLeftButton
        navigationItem.rightBarButtonItem = customRightButton
        navigationItem.rightBarButtonItem?.isSelected = false
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
        ]
    }
    
    private func setupButton() {
        view.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(50)
        }
    }
    
    //MARK: - Logic
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func formatTime(seconds: Int) -> String {
        // Функция для форматирования времени в формат "00:00"
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func ifGameContinue() {
        guard let unwrappedBool = isContinueGame, unwrappedBool else {return}
        gameTime = SavingManager.getValueOfInt(forKey: .timeLeft)
    }
    
    private func ifCheckButtonOn() {
        let ifCheckButtonOn = SavingManager.getValueOfBool(forKey: .gameCheckSwitchStatus)
        guard ifCheckButtonOn else {return}
        answerCheck = 0
    }
    
    //MARK: - Targets
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
        SavingManager.saveValue(value: true, forKey: .ifContinueGame)
        SavingManager.saveValue(value: gameTime - secondsPassed, forKey: .timeLeft)
        SavingManager.saveValue(value: SettingsManager.shared.speedNumber, forKey: .speedNumber)
    }
    
    @objc private func pauseButtonTapped() {
        isTimerPaused.toggle()
        guard let isSelected = navigationItem.rightBarButtonItem?.isSelected else {return}
        if !isSelected {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "playButton")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "pauseButton")
        }
        navigationItem.rightBarButtonItem?.isSelected.toggle()
    }
    
    @objc private func updateTimer() {
        guard !isTimerPaused else {
            updateButton.isEnabled = false
            return
        }
        updateButton.isEnabled = true
        secondsPassed += 1
        title = formatTime(seconds: gameTime - secondsPassed)
        if secondsPassed == gameTime {
            ResultsManager.shared.saveResult(
                time: gameTime / 60,
                speed: SettingsManager.shared.speedNumber,
                answer: answerCheck)
            timer?.invalidate()
            present(ResultsViewController(), animated: true)
        } else if secondsPassed % updateTime == 0 {
            cardViews.forEach { $0.removeFromSuperview() }
            setupCards()
        }
    }
    
    @objc private func tapXButton(_ sender: UIButton) {
        currentSpeedValue += 1
        switch currentSpeedValue {
        case 1 :
            sender.setTitle("X2", for: .normal)
            updateTime = 2
        case 2 :
            sender.setTitle("X3", for: .normal)
            updateTime = 3
        case 3 :
            sender.setTitle("X4", for: .normal)
            updateTime = 4
        case 4 :
            sender.setTitle("X1", for: .normal)
            updateTime = 1
            currentSpeedValue = 0
        default:
            break
        }
    }
}

//MARK: - Extension
extension GameViewController: CheckViewDelegate {
    func button() {
        guard  answerCheck != nil else {return}
        answerCheck! += 1
        print("+1")
    }
}
