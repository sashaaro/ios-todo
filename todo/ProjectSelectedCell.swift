//
//  ProjectSelectedCell.swift
//  todo
//
//  Created by Alex Danilin on 2/14/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit

public class ProjectSelectedCell: UITableViewCell {
    @IBOutlet weak var doneImageView: UIImageView!
    
    public func updateViewElements() {
        self.selectionStyle =  UITableViewCellSelectionStyle.none // remove selection style
        //self.doneImageView.isHidden = !self.isSelected;
    }
}

