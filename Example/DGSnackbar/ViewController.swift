//
//  ViewController.swift
//  DGSnackbar
//
//  Created by Dhaval Golakiya on 11/18/2015.
//  Copyright (c) 2015 Dhaval Golakiya. All rights reserved.
//

import UIKit
import DGSnackbar


class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var fruitsArray = [String]()
    
    @IBOutlet weak var fruitListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitsArray = ["Apple","Banana","Cherry","Grape","Guava","Mango","Orange","Pepper","Pineapple", "Strawberry"]
        
        fruitListTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return fruitsArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = fruitsArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let fruitName = fruitsArray[indexPath.row]
        self.fruitsArray.removeAtIndex(indexPath.row)
        self.fruitListTableView.reloadData()
        DGSnackbar().makeSnackbar(fruitName + " removed", actionButtonImage: UIImage(named: "ic_done_white"), interval: 3, actionButtonBlock: {action in
            self.fruitsArray.insert(fruitName, atIndex: indexPath.row)
            self.fruitListTableView.reloadData()
            }, dismisBlock:  {acion in
        })
        //        DGSnackbar.makeSnackbar(fruitName + " removed", actionButtonImage: UIImage(named: "ic_done_white"), interval: 3, actionButtonBlock: {action in
        //            self.fruitsArray.insert(fruitName, atIndex: indexPath.row)
        //            self.fruitListTableView.reloadData()
        //            }, dismisBlock:  {acion in
        //        })
        //                DGSnackbar().makeSnackbar(fruitName + " removed", actionButtonTitle: "Undo", interval: 3, actionButtonBlock: {action in
        //                    self.fruitsArray.insert(fruitName, atIndex: indexPath.row)
        //                    self.fruitListTableView.reloadData()
        //                    }, dismisBlock:  {acion in
        //        
        //                })
    }
    
}

