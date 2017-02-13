
//
//  Repository.swift
//  todo
//
//  Created by Alex Danilin on 2/13/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit
import Alamofire

// API repository
class Repository: NSObject {
    let API_URL = "https://oblakotodo.herokuapp.com/api";
    
    // async fetch projects
    public func findProjects(callback: @escaping ([Project]) -> Void) {
        var projects = [Project]()
        Alamofire.request(self.API_URL + "/projects").responseJSON { response in
            if let JSON = response.result.value {
                let list = JSON as! [Dictionary<String, AnyObject>]
                for projectData in list {
                    let project = Project()
                    project.id = projectData["id"] as? Int
                    project.title = projectData["title"] as? String
                    
                    for todoData in projectData["todos"] as! [Dictionary<String, AnyObject>] {
                        let todo = Todo()
                        todo.id = todoData["id"] as? Int
                        todo.text = todoData["text"] as? String
                        todo.isCopleted = (todoData["isCompleted"] as? Bool)!
                        
                        project.todos.append(todo)
                    }
                    
                    projects.append(project)
                }
                callback(projects)
            } else {
                // TODO
            }
        }
    
    }
}
