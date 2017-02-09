//
//  ViewController.swift
//  todo
//
//  Created by Alex Danilin on 2/9/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit

class TodosViewController: UITableViewController {

    public var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var project = Project();
        var todo = Todo();
        project.title = "Проект №1"
        todo.text = "Задача 1"
        project.todos.append(todo)
        self.projects.append(project)
        
        project = Project()
        todo = Todo();
        todo.text = "Задача 1"
        
        project.title = "Проект №2"
        project.todos.append(todo)
        self.projects.append(project)
        
        project = Project()
        todo = Todo();
        todo.text = "Задача 1"
        project.title = "Проект №3"
        project.todos.append(todo)
        self.projects.append(project)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects[section].todos.count;
        //возвращаем количество задач внутри проекта, который находим, используя section
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //возвращаем ячейку для заголовка
        
        //http://stackoverflow.com/questions/31693901/design-uitableviews-section-header-in-interface-builder
        
        return tableView.dequeueReusableCell(withIdentifier: "header")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //высота cell (непосредственно само todo)
        return 44;
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //высота заголовка (название проекта)
        return 44;
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //находим cell, используя Identifier, который установили в storyboard, и возвращаем cell для текущего индекса
        
        //пока не нужно устанавливать текст, поскольку мы будем добавлять кастомный компонент - checkbox, а не UILabel, который установлен в стандартной UITableViewCell по умолчанию
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TodoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodoCell  else {
            fatalError("The dequeued cell is not an instance of TodoCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let project = self.projects[indexPath.row]
        
        cell.todo = project.todos.first // TODO
        cell.textLabel?.text = cell.todo?.text
        //cell.photoImageView.image = meal.photo
        //cell.ratingControl.rating = meal.rating
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //возвращаем количество секций (проектов)
        return self.projects.count;
    }}

