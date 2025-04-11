//
//  TodoListViewModel.swift
//  Todolist
//
//  Created by Yung Hak Lee on 4/10/25.
//

import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = []
    @Published var newTodoItem: String = ""
    @Published var filterOption: FilteredItems = .all
    
    @Published private(set) var filteredItems: [TodoItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    enum FilteredItems {
        case all
        case active
        case completed
    }
    
    init() {
        loadTodoItems()
        setupBindings()
    }
    
    func loadTodoItems() {
        self.todoItems = []
    }
    
    func setupBindings() {
        Publishers.CombineLatest($todoItems, $filterOption)
            .map { items, filter in
                switch filter {
                case .all:
                    return items
                case .active:
                    return items.filter { !$0.isCompleted }
                case .completed:
                    return items.filter { $0.isCompleted }
                }
            }
            .sink{ [weak self] filtered in
                self?.filteredItems = filtered
            }
            .store(in: &cancellables)
    }
    
    func addTodoItem() {
        guard !newTodoItem.isEmpty else { return }
        
        let newTodoItem = TodoItem(id: UUID(), title: newTodoItem, isCompleted: false)
        self.todoItems.append(newTodoItem)
        self.newTodoItem = ""
    }
    
    func removeTodoItem(at indexSet: IndexSet) {
        todoItems.remove(atOffsets: indexSet)
    }
    
    func toggleIsCompleted(for item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id}) {
            todoItems[index].isCompleted.toggle()
        }
    }
}
