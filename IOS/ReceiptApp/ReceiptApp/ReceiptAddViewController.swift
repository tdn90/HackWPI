//
//  ReceiptAddViewController.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/19/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReceiptAddViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var kbdh:CGFloat = 0
    var data:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ReceiptAddViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReceiptAddViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.height == UIScreen.main.bounds.height {
                //self.view.frame.origin.y -= keyboardSize.height
                if (self.kbdh == 0) {
                    self.kbdh = keyboardSize.height
                }
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: UIScreen.main.bounds.height - self.kbdh)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: UIScreen.main.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.dictionary!["result"]!.array!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReceiptLineitem = tableView.dequeueReusableCell(withIdentifier: "lineitemIdentifier", for: indexPath) as! ReceiptLineitem
        let json:[JSON] = data!.dictionary!["result"]!.array![indexPath.row].array!
        cell.name.text = json[0].string!
        if (json[1].string != nil) {
            cell.price.text = json[1].string!
        }
        return cell
    }
    
    
}
