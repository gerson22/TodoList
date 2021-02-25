//
//  Task.swift
//  TodoListA
//
//  Created by Gerson Isaias on 18/02/21.
//

import UIKit

class Task: Codable {
    
    var id:Int!
    var name:String!
    public private(set) var done:Bool?
    
    init(_ name:String, done:Bool) {
        self.name = name
        self.done = done
    }
    
    func add(completion:()->()) {
        App.shared.tasks = Task.all()
        self.id = App.shared.tasks.count+1
        App.shared.tasks.append(self)
        self.store()
        completion()
    }
    
    func store(){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(App.shared.tasks)
            App.shared.defaults.set(data, forKey: "tasks")
            App.shared.defaults.synchronize()
        }catch {
            print("Error serailization \(error)")
        }
    }
    
    func wasDone(){
        var tasks:[Task] = Task.all()
        var newTasks:[Task] = [Task]()
        tasks.forEach { (task) in
            if(task.id == self.id){
                task.done = true
            }
            newTasks.append(task)
        }
        App.shared.tasks = tasks
        
        self.store()
    }
    
    static func all() -> [Task]{
        if let data = App.shared.defaults.object(forKey: "tasks") as? Data {
            let decoder = JSONDecoder()
            guard let tasks = try? decoder.decode([Task].self, from: data) else { return [Task]() }
            return tasks
        }
        return [Task]()
    }
    
    

}
