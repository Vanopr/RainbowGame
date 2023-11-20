//
//  ResultCell.swift
//  RainbowGame
//
//  Created by sidzhe on 17.11.2023.
//

import UIKit

final class ResultCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    private let gameNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.textAlignment = .left
        return label
    }()
    
    private let gameTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let gameSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let gameResultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textColor = .green
        label.textAlignment = .right
        return label
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupCollectionCell
    private func setupCollectionCell() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        
        addSubview(gameNumberLabel)
        addSubview(gameTimeLabel)
        addSubview(gameSpeedLabel)
        addSubview(gameResultLabel)
        
        gameNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        gameTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(gameNumberLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        gameSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        gameResultLabel.snp.makeConstraints { make in
            make.top.equalTo(gameSpeedLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    //MARK: - Configure
    func configure(_ model: ResultsModel, number: Int) {
        gameNumberLabel.text = "Игра № \(number + 1)"
        gameTimeLabel.text = "Время игры: \(model.time) мин"
        gameSpeedLabel.text = "Скорость \(model.speed)"
        gameResultLabel.text = "Угадано \(model.answer ?? 0)"
    }
}
