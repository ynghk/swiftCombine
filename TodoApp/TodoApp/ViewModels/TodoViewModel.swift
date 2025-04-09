//
//  TodoViewModel.swift
//  TodoApp
//
//  Created by Yung Hak Lee on 4/9/25.
//

import SwiftUI
import Combine

// MARK: Properties
class TodoViewModel: ObservableObject {
    @Published var todoLists: [TodoList] = []
    @Published var newTodoList: String = ""
    @Published var filterOption: FilterOption = .all
    @Published private(set) var filteredItems: [TodoList] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Filter Options
    enum FilterOption {
        case all
        case active
        case completed
    }
    
    // MARK: Initialization
    init() {
        loadTodoList()
        setupBindings()
    }
        
    // MARK: Bindings
    private func setupBindings() {
        $todoLists
            .combineLatest($filterOption)
            .map(filterTodoLists)
            .sink{ [weak self] filteredItems in
                self?.filteredItems = filteredItems
            }
            .store(in: &cancellables)
    }
    
    // MARK: Filtering
    private func filterTodoLists(todoLists: [TodoList], filter: FilterOption) -> [TodoList] {
                switch filter {
                case .all: return todoLists
                case .active: return todoLists.filter{ !$0.isCompleted }
                case .completed: return todoLists.filter{ $0.isCompleted }
                }
            }
        
    // MARK: Data Management
    func loadTodoList() {
        // 여기에서 데이터 로드
            todoLists = []
        }
    
    func addTodoList() {
        guard !newTodoList.isEmpty else { return }
        
        let newTodo = TodoList(title: newTodoList, isCompleted: false)
        todoLists.append(newTodo)
        newTodoList = ""
    }
    
    func toggleComplete(id: UUID) {
        if let index = todoLists.firstIndex(where: { $0.id == id}) {
            todoLists[index].isCompleted.toggle()
        }
    }
    
    func removeTodoList(at offsets: IndexSet) {
        todoLists.remove(atOffsets: offsets)
    }
}
