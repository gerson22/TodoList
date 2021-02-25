//
//  App.swift
//  TodoListA
//
//  Created by Gerson Isaias on 18/02/21.
//

import UIKit

class App: NSObject {
    static let shared = App()
    let defaults = UserDefaults.standard
    var tasks = [Task]()
}
