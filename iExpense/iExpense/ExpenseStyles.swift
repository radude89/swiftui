//
//  ExpenseStyles.swift
//  iExpense
//
//  Created by Radu Dan on 22/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ExpenseMinimumStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.orange)
    }
}

struct ExpenseDefaultStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
    }
}

struct ExpenseHighStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.green)
    }
}

extension View {
    var minAmountStyle: some View {
        modifier(ExpenseMinimumStyle())
    }
    
    var defaultAmountStyle: some View {
        modifier(ExpenseDefaultStyle())
    }
    
    var highAmountStyle: some View {
        modifier(ExpenseHighStyle())
    }
}

struct AmountText: View {
    let amount: Int
    
    var body: some View {
        switch amount {
        case ..<10:
            return AnyView(Text("$\(amount)").minAmountStyle)
        case 10..<100:
            return AnyView(Text("$\(amount)").defaultAmountStyle)
        default:
            return AnyView(Text("$\(amount)").highAmountStyle)
        }
    }
}
