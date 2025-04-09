//
//  Item.swift
//  TodoApp
//
//  Created by Yung Hak Lee on 4/9/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
