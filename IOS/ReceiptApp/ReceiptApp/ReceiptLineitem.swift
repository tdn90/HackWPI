//
//  ReceiptLineitem.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/19/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit
import SwiftyJSON
class ReceiptLineitem : UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var view: UIView!
    var tableView:ReceiptAddViewController?;
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(ReceiptLineitem.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.price.inputAccessoryView = toolbar
        self.name.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    @IBAction func update(_ sender: Any) {
        let row = (self.superview as! UITableView).indexPath(for: self)
        if var el:JSON = (self.tableView?.data?.dictionary?["result"]) {
            if var el2:JSON = (el.array?[row!.row]) {
                el2.arrayObject?[0] = JSON(stringLiteral: name.text!)
                el2.arrayObject?[1] = JSON(stringLiteral: price.text!)
                el.arrayObject?[row!.row] = el2
            }
            self.tableView?.data?.dictionaryObject?["result"] = el
        } else {
            print("FAIL")
        }
    }
}
