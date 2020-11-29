//
//  UserSettings.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import SwiftUI

final class UserSettings: ObservableObject {
    @Published var numberOfDice = 1
    @Published var sidesPerDice = 6
}
