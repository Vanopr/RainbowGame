//
//  ResultsManager.swift
//  RainbowGame
//
//  Created by Vanopr on 17.11.2023.
//

import Foundation

final class ResultsManager {
    static let shared = ResultsManager()
    var resultsModel: [ResultsModel] = []
    
    //MARK: - SaveResultsModel
    func saveResult(time: Int, speed: Int, answer: Int? = nil) {
        resultsModel.append(ResultsModel(time: time, speed: speed, answer: answer))
    }
}
