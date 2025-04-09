//
//  TodoListView.swift
//  TodoApp
//
//  Created by Yung Hak Lee on 4/9/25.
//

import SwiftUI


struct TodoListView: View {
    @StateObject var viewmodel = TodoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("할 일 입력", text: $viewmodel.newTodoList)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewmodel.addTodoList()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
                .padding()
                
                List {
                    ForEach(Array(viewmodel.todoLists.enumerated()), id: \.element.id) { index, item in
                        HStack {
                            Button (action: {
                                viewmodel.toggleComplete(id: item.id)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .blue : .gray)
                            }
                            
                            Text(item.title)
                                .strikethrough(item.isCompleted)
                        }
                    }
                    .onDelete(perform: viewmodel.removeTodoList)
                }
            }
            .navigationTitle("할 일 목록")
        }
    }
}

