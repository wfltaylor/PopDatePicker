//
//  PopDatePicker.swift
//  PopDatePicker
//
//  Created by Adam Hartford on 4/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa

public class PopDatePicker: NSDatePicker {
    
    let controller = PopDatePickerController()
    let popover = NSPopover()
    var showingPopover = false
    
    public var preferredPopoverEdge = NSRectEdge.maxX
    public var shouldShowPopover = { return true }
    
    public override func awakeFromNib() {
        action = "dateAction"
        controller.datePicker.action = "popoverDateAction"
        controller.datePicker.bind(NSBindingName.value, to: self, withKeyPath: "dateValue", options: nil)
        popover.contentViewController = controller
        popover.behavior = .semitransient
    }
    
    func popoverDateAction() {
        if let bindingInfo = infoForBinding(NSBindingName.value) as? NSDictionary {
            if let keyPath = bindingInfo.value(forKey: NSBindingInfoKey.observedKeyPath.rawValue) as? String {
                (bindingInfo.value(forKey: NSBindingInfoKey.observedObject.rawValue) as AnyObject).setValue(dateValue, forKeyPath: keyPath)
            }
        }
    }
    
    func dateAction() {
        controller.datePicker.dateValue = dateValue
    }
    
    public override func mouseDown(with theEvent: NSEvent) {
        becomeFirstResponder()
        super.mouseDown(with: theEvent)
    }
    
    public override func becomeFirstResponder() -> Bool {
        if shouldShowPopover() {
            showingPopover = true
            controller.datePicker.dateValue = dateValue
            popover.show(relativeTo: bounds, of: self, preferredEdge: preferredPopoverEdge)
            showingPopover = false
        }
        return super.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        if showingPopover {
            return false
        }
        popover.close()
        return super.resignFirstResponder()
    }
}

class PopDatePickerController: NSViewController {
    
    let datePicker: NSDatePicker
    
    required init?(coder: NSCoder) {
        datePicker = NSDatePicker()
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        datePicker = NSDatePicker(frame: NSMakeRect(22, 17, 139, 148))
        super.init(nibName: nil, bundle: nil)
        
        let popoverView = NSView(frame: NSMakeRect(0, 0, 180, 180))
        datePicker.datePickerStyle = .clockAndCalendar
        datePicker.drawsBackground = false
        let cell = datePicker.cell as? NSDatePickerCell
        cell?.isBezeled = false
        cell?.sendAction(on: NSEvent.EventTypeMask(rawValue: UInt64(Int(NSEvent.EventType.leftMouseDown.rawValue))))
        popoverView.addSubview(datePicker)
        view = popoverView
    }
    
}
