//
//  NetListController.swift
//  NJUHRNet
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit
//import Kanna

class NetListController: UITableViewController, URLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NetListCell", for: indexPath) as? NetListCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Configure the cell...
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var htmlString: String?
    
    func loadNet() {
        let myURL = URL(string: "http://hr.nju.edu.cn")
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(url: myURL!) as URLRequest, queue: OperationQueue()) {
            (resp:URLResponse!, data:Data!, error:Error!) -> Void in   //闭包函数
            
            self.htmlString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
    }
    
    /*func htmlContentGet() {
        var err : NSError?
        var doc = HTML(html: htmlString, error: &err)
        if err != nil {
            print(err)
            exit(1)
        }

        var bodyNode   = parser.body

        if let inputNodes = bodyNode?.findChildTags("b") {
            for node in inputNodes {
                println(node.contents)
            }
        }

        if let inputNodes = bodyNode?.findChildTags("a") {
            for node in inputNodes {
                println(node.contents)  //取得内容
                println(node.getAttributeNamed("href")) //取得属性值

            }
        }
    }*/

}
