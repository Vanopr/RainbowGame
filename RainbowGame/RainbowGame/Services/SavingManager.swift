//
//  SavedToUserDefault.swift
//  RainbowGame
//
//  Created by Vanopr on 17.11.2023.
//

import Foundation

//MARK: - SettingKey
enum SettingKey: String {
    case firstLaunch
    case timeNumber
    case speedNumber
    case substrateSwitchStatus
    case gameCheckSwitchStatus
    case colors
    case textSize
    case backgroundColor
    case ifRandomLocation
    case ifContinueGame
    case timeLeft
    case resultsModel
    case gameColors
}

//MARK: - SavingManager
struct SavingManager {
    
    //MARK: - Properties
    static let userDefaults = UserDefaults.standard
    static let settingManager = SettingsManager.shared
    static let resultsManager = ResultsManager.shared
    
    //MARK: - Methods
    static func getInitialValuesFromUD() {
        if getValueOfBool(forKey: .firstLaunch) {
            settingManager.timeNumber = getValueOfInt(forKey: .timeNumber)
            settingManager.speedNumber = getValueOfInt(forKey: .speedNumber)
            settingManager.gameCheckSwitchStatus = getValueOfBool(forKey: .gameCheckSwitchStatus)
            settingManager.substrateSwitchStatus = getValueOfBool(forKey: .substrateSwitchStatus)
            settingManager.sizeOfText = getValueOfInt(forKey: .textSize)
            settingManager.backgroundColor = getValueOfInt(forKey: .backgroundColor)
            settingManager.ifRandomLocation = getValueOfBool(forKey: .ifRandomLocation)
            loadResultsModel()
            print("Getting")
        } else {
            saveValue(value: true, forKey: .firstLaunch)
        }
    }
    
    static func saveSettings() {
        saveValue(value: settingManager.timeNumber, forKey: .timeNumber)
        saveValue(value: settingManager.speedNumber, forKey: .speedNumber)
        saveValue(value: settingManager.substrateSwitchStatus, forKey: .substrateSwitchStatus)
        saveValue(value: settingManager.gameCheckSwitchStatus, forKey: .gameCheckSwitchStatus)
        saveValue(value: settingManager.sizeOfText, forKey: .textSize)
        saveValue(value: settingManager.backgroundColor, forKey: .backgroundColor)
        saveValue(value: settingManager.ifRandomLocation, forKey: .ifRandomLocation)
        saveModel(model: ResultsManager.shared.resultsModel, key: .resultsModel)
        saveColorsState()
    }
    
    static func saveValue<T>(value: T, forKey key: SettingKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    static func getValueOfInt(forKey key: SettingKey) -> Int {
        userDefaults.integer(forKey: key.rawValue)
    }
    
    static func getValueOfBool(forKey key: SettingKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
    
    static func saveModel<T: Codable>(model: T, key: SettingKey) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(model)
            userDefaults.set(encodedData, forKey: key.rawValue)
            print("Модель сохранена")
        } catch {
            print("Не удалось сохранить модель")
        }
    }
    
    static func saveColorsState() {
        let colorState = settingManager.selectedColors.map { $0.isSelected }
        userDefaults.set(colorState, forKey: "colorState")
        print("Цвета сохранены")
    }
    
    static func loadResultsModel() {
        if let savedData = userDefaults.data(forKey: SettingKey.resultsModel.rawValue) {
            do {
                let decoder = JSONDecoder()
                let loadedModel = try decoder.decode([ResultsModel].self, from: savedData)
                ResultsManager.shared.resultsModel = loadedModel
            } catch {
                print("Не удалось загрузить модель")
                ResultsManager.shared.resultsModel = []
            }
        }
        
        guard let colors = userDefaults.object(forKey: "colorState") as? [Bool] else { return }
        for i in 0...11 {
            SettingsManager.shared.selectedColors[i].isSelected = colors[i]
        }
    }
}
