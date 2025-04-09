//
//  TodoModel.swift
//  TodoApp
//
//  Created by Yung Hak Lee on 4/9/25.
//

import Foundation

struct TodoList: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
