//
//  TodoListDetailView.swift
//  Todolist
//
//  Created by Yung Hak Lee on 4/10/25.
//

import SwiftUI

struct TodoListDetailView: View {
    @ObservedObject var viewModel: TodoListViewModel
    @State private var title: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            Form {
                Section(header: Text("Title")) {
                    TextField("What to do?", text: $title)
                }
                
                Section {
                    Button("Add") {
                        viewModel.newTodoItem = title
                        viewModel.addTodoItem()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("New Todo List")
    }
}
