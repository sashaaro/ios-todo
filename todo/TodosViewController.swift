//
//  ViewController.swift
//  todo
//
//  Created by Alex Danilin on 2/9/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit
import Alamofire
import M13Checkbox

class TodosViewController: UITableViewController {
    let repository: Repository = Repository();
    
    public var projects = [Project]()
    @IBOutlet weak var newTodoButton: UIBarButtonItem!

    @IBOutlet var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reloadData()
    }
    
    @IBAction func clickNewTodoButton(_ sender: Any) {
        let addTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
        addTodoViewController.projects = self.projects
        self.navigationController?.pushViewController(addTodoViewController, animated: true)
    }
    
    private func reloadData() {
        self.newTodoButton.isEnabled = false;
        self.repository.findProjects(callback: { projects in
            self.projects = projects
            self.newTodoButton.isEnabled = true;
            self.todoTableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects[section].todos.count;
        //возвращаем количество задач внутри проекта, который находим, используя section
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //возвращаем ячейку для заголовка
        
        //http://stackoverflow.com/questions/31693901/design-uitableviews-section-header-in-interface-builder
        
        // return tableView.dequeueReusableCell(withIdentifier: "header")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
            as? ProjectCell else {
                fatalError("not project cell")
        }
        
        cell.textLabel?.text = self.projects[section].title
        
        return cell
    }
    
    //высота cell (непосредственно само todo)
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35;
    }
    
    //высота заголовка (название проекта)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35;
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
        let project = self.projects[indexPath.section]
        
        cell.todo = project.todos[indexPath.row]
        cell.updateViewElements()
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //возвращаем количество секций (проектов)
        return self.projects.count;
    }
}

