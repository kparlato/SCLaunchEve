//
//  ViewController.swift
//  SCLaunchEve
//
//  Created by Karen Parlato on 7/23/19.
//  Copyright © 2019 Karen Parlato. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {


    
    @IBOutlet weak var urlEntryField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addButtonOutlet: NSButton!
    @IBOutlet weak var removeButtonOutlet: NSButton!
    
    
    
    
    var websiteArray:[String] = []
    
    
    
    
    @IBAction func addClicked(_ sender: Any) {
        
        let userEntry = urlEntryField.stringValue
        
        if userEntry.isValidURL == true {
            websiteArray.append(userEntry)
            saveArray()
            tableView.reloadData()
        } else {
            print ("URL is bad")
        }
        
        
    }
    
    
    
    
    
    @IBAction func removeClicked(_ sender: Any) {
        websiteArray.remove(at: tableView.selectedRow)
        saveArray()
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedArray = UserDefaults.standard.stringArray(forKey: "websiteArray") {
            websiteArray = loadedArray
            tableView.reloadData()
        } else {
            // create the default array
            websiteArray.append("https://evescoutrescue.com/copilot/index.php")
            websiteArray.append("https://tripwire.eve-apps.com")
            websiteArray.append("http://anoik.is")
            websiteArray.append("http://eve-gatecheck.space/eve/")
            tableView.reloadData()
        }
        removeButtonOutlet.isEnabled = false
        
        
        // Do view setup here.
    }
    
    
    func saveArray() {
        UserDefaults.standard.set(websiteArray, forKey: "websiteArray")
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return websiteArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if (tableColumn?.identifier)?.rawValue == "urlCol" {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "urlCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = websiteArray[row]
                return cell
                
            }
            return nil
        }
        
        if (tableColumn?.identifier)?.rawValue == "deleteCol" {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "deleteCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = websiteArray[row]
                
                return cell
                
            }
            return nil
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow == -1 {
            removeButtonOutlet.isEnabled = false
        } else {
            removeButtonOutlet.isEnabled = true
        }
        
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
