//
//  GameModel.swift
//  MultiplicationTable
//
//  Created by Radu Dan on 16/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct GameItem {
    let question: String
    let answer: String
}

struct Game {
    var items: [GameItem]
}

enum GameFactory {
    static func makeGame(numberOfQuestions: Int,
                         multiplicationTable: Int,
                         maximumTable: Int) -> Game {
        let items = makeAllItems(multiplicationTable: multiplicationTable,
                                 maximumTable: maximumTable)
        
        if numberOfQuestions >= items.count {
            return Game(items: items)
        }
        
        let subItems = Array(items.shuffled().prefix(numberOfQuestions))
        
        return Game(items: subItems)
    }
    
    private static func makeAllItems(multiplicationTable: Int,
                                     maximumTable: Int) -> [GameItem] {
        var items: [GameItem] = []
        
        for number in 1...multiplicationTable {
            for number2 in 1...maximumTable {
                let question = "How much is \(number) x \(number2)?"
                let answer = "\(number * number2)"
                items.append(GameItem(question: question, answer: answer))
            }
        }
        
        return items
    }
}
