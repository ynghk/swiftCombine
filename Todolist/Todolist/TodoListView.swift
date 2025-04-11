//
//  TodoListView.swift
//  Todolist
//
//  Created by Yung Hak Lee on 4/10/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            Button(action: {
                                viewModel.toggleIsCompleted(for: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                    .foregroundColor(item.isCompleted ? .blue : .gray)
                            }
                            Text(item.title)
                                .strikethrough(item.isCompleted)
                            Spacer()
                        }
                    }
                    .onDelete(perform: viewModel.removeTodoItem)
                }
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TodoListDetailView(viewModel: viewModel)) {
                        Image(systemName: "plus.circle.fill").font(.title2)
                    }
                }
            }
        }
    }
}
