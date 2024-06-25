//
//  ContentView.swift
//  iExpense
//
//  Created by Christopher Endress on 6/23/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("Personal Expenses") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(styleExpense(item.amount))
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Personal")
                    }
                }
                
                Section("Business Expenses") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(styleExpense(item.amount))
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Business")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isShowingAddView = true
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, from type: String) {
        let itemsToRemove = offsets.map { expenses.items.filter { $0.type == type }[$0] }
        for item in itemsToRemove {
            if let index = expenses.items.firstIndex(of: item) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func styleExpense(_ expenseItem: Double) -> Color {
        switch expenseItem {
        case 0..<10:
            return .green
        case 10..<100:
            return .orange
        case 100..<Double.infinity:
            return .red
        default:
            return .orange
        }
    }
}

#Preview {
    ContentView()
}
