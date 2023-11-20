//
//  MainViewController.swift
//  RainbowGame
//
//  Created by sidzhe on 12.11.2023.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - UI Elements
    private let rainbowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rainbow")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let rainbowLabel: UILabel = {
        let label = UILabel()
        label.text = "Игра Радуга"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Новая игра", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 222/255, green: 34/255, blue: 34/255, alpha: 1.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(MainViewController.buttonNewGamePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueGameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 47/255, green: 134/255, blue: 183/255, alpha: 1.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(MainViewController.buttonContinuePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var statisticsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Статистика", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 48/255, green: 167/255, blue: 74/255, alpha: 1.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(MainViewController.buttonStatisticsPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.setImage(UIImage (named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(MainViewController.buttonSettingsPressed), for: .touchUpInside)
        return button
    }()
    
    private let rulesButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.setImage(UIImage (named: "question"), for: .normal)
        button.addTarget(nil, action: #selector(MainViewController.buttonRulesPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        isContinueButtonAvailable()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
    }
    
    //MARK: - Setup UI
    private func initialize() {
        view.backgroundColor = UIColor.gray
        view.addSubview(rainbowImage)
        view.addSubview(rainbowLabel)
        view.addSubview(newGameButton)
        view.addSubview(continueGameButton)
        view.addSubview(statisticsButton)
        view.addSubview(settingsButton)
        view.addSubview(rulesButton)
        
        rainbowImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(200)
        }
        
        rainbowLabel.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.top.equalTo(rainbowImage.snp.bottom).offset(5)
            make.height.equalTo(100)
        }
        
        newGameButton.snp.makeConstraints {make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.bottom.equalTo(continueGameButton.snp.top).inset(-16)
            make.height.equalTo(84)
        }
        
        continueGameButton.snp.makeConstraints {make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.bottom.equalTo(statisticsButton.snp.top).inset(-16)
            make.height.equalTo(84)
        }
        
        statisticsButton.snp.makeConstraints {make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(128)
            make.height.equalTo(84)
        }
        
        settingsButton.snp.makeConstraints {make in
            make.left.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(35)
            make.size.equalTo(50)
        }
        
        rulesButton.snp.makeConstraints {make in
            make.right.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(35)
            make.size.equalTo(50)
        }
    }
    
    //MARK: - Functions
    private func isContinueButtonAvailable() {
        let ifContinueGame = SavingManager.getValueOfBool(forKey: .ifContinueGame)
        ifContinueGame
        ? (continueGameButton.isEnabled = true)
        : (continueGameButton.isEnabled = false)
    }
    
    //MARK: - Targets
    @objc private func  buttonNewGamePressed() {
        let newGameVC = GameViewController()
        newGameVC.isContinueGame = false
        navigationController?.pushViewController(newGameVC, animated: true)
    }
    
    @objc private func  buttonContinuePressed() {
        let gameTime = SavingManager.getValueOfInt(forKey: .timeLeft)
        if gameTime > 0 {
            let continueGameVC = GameViewController()
            continueGameVC.isContinueGame = true
            navigationController?.pushViewController(continueGameVC, animated: true)
        }
    }
    
    @objc private func  buttonStatisticsPressed() {
        let statisticsVC = ResultsViewController()
        navigationController?.pushViewController(statisticsVC, animated: true)
    }
    
    @objc private func  buttonSettingsPressed() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func  buttonRulesPressed() {
        let rulesVC = RulesViewController()
        navigationController?.pushViewController(rulesVC, animated: true)
    }
}
