//
//  TodoModel.swift
//  Todolist
//
//  Created by Yung Hak Lee on 4/10/25.
//

import Foundation

struct TodoItem: Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
    
    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        lhs.id == rhs.id
    }
}
