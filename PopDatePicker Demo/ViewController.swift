//
//  ViewController.swift
//  PopDatePicker Demo
//
//  Created by Adam Hartford on 4/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa
import PopDatePicker

class ViewController: NSViewController {
    
    @IBOutlet weak var datePicker: PopDatePicker!
    @IBOutlet weak var showPopoverButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.dateValue = Date()
        
        datePicker.shouldShowPopover = { [weak self] in
            return self?.showPopoverButton.state == NSControl.StateValue.on
        }
    }
    
    @IBAction func preferredEdgeChanged(sender: NSPopUpButton) {
        switch sender.indexOfSelectedItem {
        case 0:
            datePicker.preferredPopoverEdge = .maxX
        case 1:
            datePicker.preferredPopoverEdge = .minX
        case 2:
            datePicker.preferredPopoverEdge = .maxY
        case 3:
            datePicker.preferredPopoverEdge = .minY
        default:
            break
            
        }
    }

}

