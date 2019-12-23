//
//  NetListController.swift
//  NJUHRNet
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit
import Foundation


class NetListController: UITableViewController, URLSessionDelegate {

    private var newsList = [[News]]()
    private var newsList1 = [News]()
    private var newsList2 = [News]()
    private var newsList3 = [News]()
    private var newsList4 = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadNet()
        let quene = DispatchQueue.global()
        quene.async {
            while self.htmlString == nil {}
            let str = self.htmlContentGet()
            //print(str)
            self.initNewsList(newsString: str)
            /*for news in self.newsList1 {
                print(news.title)
                print(news.netURL)
                print(news.date)
                print(news.clickCount)
            }*/
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if !newsList.isEmpty {
            return newsList[section].count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "人事通知"
        case 1:
            return "人事新闻"
        case 2:
            return "公示公告"
        case 3:
            return "招聘信息"
        default:
            print("error")
        }
        
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NetListCell", for: indexPath) as? NetListCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Configure the cell...
        cell.title.text = newsList[indexPath.section][indexPath.row].title
        cell.date.text = newsList[indexPath.section][indexPath.row].date
        if newsList[indexPath.section][indexPath.row].clickCount > 1000 {
            cell.clickCountIcon.text = "🔥"
        }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        guard let newsDetailViewController = segue.destination as? ViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
         
        guard let selectedNewsCell = sender as? NetListCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
         
        guard let indexPath = tableView.indexPath(for: selectedNewsCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
         
        let selectedNewsURL = newsList[indexPath.section][indexPath.row].netURL
        newsDetailViewController.url = selectedNewsURL
    }
    
    var htmlString: String?
    
    func loadNet() {
        let myURL = URL(string: "https://hr.nju.edu.cn")
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(url: myURL!) as URLRequest, queue: OperationQueue()) {
            (resp:URLResponse!, data:Data!, error:Error!) -> Void in   //闭包函数
            
            //print(NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String)
            self.htmlString = String(NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String)
            //print(self.htmlString)
        }
        //print(self.htmlString)
    }
    
    func htmlContentGet() -> [[String]]{
        //print("test")
        return html_String(html: htmlString!, pattern: "<li class=\"news.*?li>")
    }
    
    func html_String(html: String, pattern: String) -> [[String]]
    {
        var news = [[String]]()
        var news1 = [String]()
        var news2 = [String]()
        var news3 = [String]()
        var news4 = [String]()
        news1.append("news1")
        news2.append("news2")
        news3.append("news3")
        news4.append("news4")
        var flag = 0
        do{
            
            //let pattern = ">.*?<"     //正则匹配的数据格式 ， >.*?<  等价于  <tb> ** <\tb> 数据所取部分的 > ** < ，开头>到<结尾的数据，.*?：是所有的数据 。
            let regular = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let reg = regular.matches(in: html, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, html.count))
            for checking in reg {
                let str = (html as NSString).substring(with: checking.range)
                //str就是正则匹配后拿到的数据，因为这里拿到的数据开头包含了>  、结尾包含了<,这里对数据进行一个替换的处理，当然也可以进行删除的处理，下面进行一个替换的处理
                //str = str.replacingOccurrences(of: ">", with: "")
                //str = str.replacingOccurrences(of: "<", with: "")
                //print(str)      //图下是最终输出
                let pattern1 = "news .*?\""
                let regular1 = try NSRegularExpression(pattern: pattern1, options: NSRegularExpression.Options.caseInsensitive)
                let reg1 = regular1.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
                for checking1 in reg1 {
                    var str1 = (str as NSString).substring(with: checking1.range) as String
                    str1 = str1.replacingOccurrences(of: "news ", with: "")
                    str1 = str1.replacingOccurrences(of: "\"", with: "")
                    str1 = str1.replacingOccurrences(of: "i", with: "")
                    if str1 == "1" {
                        flag = flag + 1
                    }
                    switch flag {
                    case 1:
                        news1.append(str)
                    case 2:
                        news2.append(str)
                    case 3:
                        news3.append(str)
                    case 4:
                        news4.append(str)
                    default:
                        print("error1")
                    }
                }
            }
            //print(news1)
            //print(news2.count)
            //print(news3.count)
            //print(news4.count)
            news.append(news1)
            news.append(news2)
            news.append(news3)
            news.append(news4)
        }
        catch
        {

        }
        return news
    }
    
    func html_String(news: String, pattern: String) -> String {
        do{
        
            //let pattern = ">.*?<"     //正则匹配的数据格式 ， >.*?<  等价于  <tb> ** <\tb> 数据所取部分的 > ** < ，开头>到<结尾的数据，.*?：是所有的数据 。
            let regular = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let reg = regular.matches(in: news, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, news.count))
            for checking in reg {
                let str = (news as NSString).substring(with: checking.range)
                //print(str)
                return str
            }
        }
        catch
        {

        }
        return ""
    }
    
    func initNewsList(newsString: [[String]]) {
        //print(newsString)
        for newsList in newsString {
            for news in newsList {
                if news.count > 10 {
                    var title: String
                    var netURL: String
                    var date: String
                    var clickCount: Int
                    //print(news)
                    title = html_String(news: news, pattern: "title=.*?>")
                    title = title.replacingOccurrences(of: "title=\'", with: "")
                    title = title.replacingOccurrences(of: "\'>", with: "")
                    netURL = html_String(news: news, pattern: "href=\'.*?\' target=")
                    netURL = netURL.replacingOccurrences(of: "href=\'", with: "")
                    netURL = netURL.replacingOccurrences(of: "\' target=", with: "")
                    if netURL.prefix(4) != "http" {
                        //print(netURL.prefix(4))
                        netURL = "https://hr.nju.edu.cn" + netURL
                    }
                    date = html_String(news: news, pattern: "news_meta\">.*?</span>")
                    date = date.replacingOccurrences(of: "news_meta\">", with: "")
                    date = date.replacingOccurrences(of: "</span>", with: "")
                    var temp = html_String(news: news, pattern: "news_meta1\">(.*?)</span>")
                    temp = temp.replacingOccurrences(of: "news_meta1\">(", with: "")
                    temp = temp.replacingOccurrences(of: ")</span>", with: "")
                    clickCount = Int(temp)!
                    
                    let newsNode = News(title: title, netURL: netURL, date: date, clickCount: clickCount)
                    switch newsList[0] {
                    case "news1":
                        newsList1.append(newsNode)
                    case "news2":
                        newsList2.append(newsNode)
                    case "news3":
                        newsList3.append(newsNode)
                    case "news4":
                        newsList4.append(newsNode)
                    default:
                        print("error2")
                    }
                }
            }
        }
        newsList.append(newsList1)
        newsList.append(newsList2)
        newsList.append(newsList3)
        newsList.append(newsList4)
    }
    
}
