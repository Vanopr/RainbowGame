//
//  RulesViewController.swift
//  RainbowGame
//
//  Created by sidzhe on 12.11.2023.
//

import UIKit
import SnapKit

final class RulesViewController: UIViewController {
    
    //MARK: - UI Elements
    private let backgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let labelRules: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 190/255, green: 46/255, blue: 106/255, alpha: 1)
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.text = "ПРАВИЛА ИГРЫ"
        return label
    }()
    
    private let labelText1: UILabel = {
        let text = "На экране в случайном месте появляется слово, обозначающее цвет, например: написано «синий»:"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 84, length: 7))
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedString
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelText2: UILabel = {
        let text = "Нужно произнести вслух цвет слова (если опция «подложка для букв» выключена) или цвет фона, на котором написано слово (если опция «подложка для букв» включена): говорим «зеленый». \n\nВ игре можно изменять скорость от 1x до 5x. А так же длительность игры."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 161, length: 17))
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedString
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelUnderlayOff: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = "подложка выключена:"
        return label
    }()
    
    private let labelUnderlayOn: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = "подложка включена:"
        return label
    }()
    
    private let labelUnderlayOffExample: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "синий"
        label.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        label.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
        label.layer.shadowOpacity = 0.8
        return label
    }()
    
    private let labelUnderlayOnExample: UILabel = {
        let label = UILabel()
        label.layer.backgroundColor = UIColor.green.cgColor
        label.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        label.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 2
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "синий"
        return label
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    //MARK: - UI
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(backgoundView)
        backgoundView.addSubview(labelText2)
        backgoundView.addSubview(labelUnderlayOnExample)
        backgoundView.addSubview(labelUnderlayOffExample)
        backgoundView.addSubview(labelUnderlayOn)
        backgoundView.addSubview(labelUnderlayOff)
        backgoundView.addSubview(labelText1)
        backgoundView.addSubview(labelRules)
        
        backgoundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(view.snp.top).inset(170)
            make.bottom.equalTo(view.snp.bottom).inset(40)
        }
        
        labelText2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(286)
            make.bottom.equalTo(backgoundView.snp.bottom).inset(10)
        }
        
        labelUnderlayOffExample.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(35)
            make.bottom.equalTo(labelText2.snp.top).inset(-30)
            make.top.equalToSuperview().inset(220)
        }
        
        labelUnderlayOnExample.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(22)
            make.bottom.equalTo(labelText2.snp.top).inset(-30)
            make.top.equalToSuperview().inset(220)
            make.width.equalTo(labelUnderlayOn).inset(0)
        }
        
        labelUnderlayOff.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(22)
            make.bottom.equalTo(labelUnderlayOffExample.snp.top).inset(-10)
            make.top.equalToSuperview().inset(190)
        }
        
        labelUnderlayOn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(22)
            make.bottom.equalTo(labelUnderlayOnExample.snp.top).inset(-10)
            make.top.equalToSuperview().inset(190)
        }
        
        labelText1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(labelUnderlayOff.snp.top).inset(-10)
            make.top.equalToSuperview().inset(45)
        }
        
        labelRules.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(backgoundView.snp.top).inset(16)
            make.bottom.equalTo(labelText1.snp.top).inset(-10)
        }
    }
    
    //MARK: - Methods
    private func setupNavigationBar() {
        title = "Помощь"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)
        ]
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(tapBackButton))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func tapBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func viewRules() {
        let vc = RulesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
