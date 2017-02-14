//
//  TodoCell.swift
//  todo
//
//  Created by Alex Danilin on 2/9/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

public class TodoCell: UITableViewCell
{
    @IBOutlet public weak var checkBox: M13Checkbox!
    @IBOutlet public weak var label: UILabel!
    
    public var todo: Todo? // TODO not use now. maybe remove
    private let repository: Repository = Repository(); // TODO remove. will be Injected?!

    
    @IBAction func toggleCheckbox(_ sender: M13Checkbox) {
        self.todo?.isCompleted = sender.checkState.rawValue == "Checked"
        self.repository.persistTodoStatus(todo: self.todo!)
        self.updateViewLabel()
    }
    
    public func updateViewElements() {
        self.selectionStyle =  UITableViewCellSelectionStyle.none // remove selection style
        
        self.updateViewCheckbox()
        self.updateViewLabel()
    }
    
    public func updateViewCheckbox() {
        if (self.todo?.isCompleted == true) {
            self.checkBox.checkState = M13Checkbox.CheckState(rawValue: "Checked")!
        } else {
            self.checkBox.checkState = M13Checkbox.CheckState(rawValue: "Unchecked")!
        }
    }
    
    public func updateViewLabel() {
        //self.textLabel?.text = self.todo?.text
        
        if (self.todo?.isCompleted == true) {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (todo?.text)!)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.label.attributedText = attributeString
        } else {
            self.label.attributedText = nil;
            self.label.text = self.todo?.text
        }
    }

}
