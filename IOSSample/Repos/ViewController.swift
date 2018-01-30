//
//  ViewController.swift
//  IOSSample
//
//  Created by Ankit Kumar on 26/01/2018.
//  Copyright © 2018 Ankit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var array = [ArrayItem]()
    var selectedNumber: Int?
    
    var pageNum = 1
    var shouldLoadMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ankit")
        tableview.dataSource = self
        tableview.delegate = self
        navigationItem.title = "REST API"
        
        self.title = "Header"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        //        tableview.estimatedRowHeight = 10
        
        //Implementing URLSession
        //        let urlString = "https://swift.mrgott.pro/blog.json"
        //End implementing URLSession
        
        callApi()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callApi() {
        let urlString = "https://api.github.com/users/AnkitDroidGit/repos?page=\(pageNum)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard data != nil else { return }
            
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData : [ArrayItem] = try JSONDecoder().decode([ArrayItem].self, from: data!)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    print(articlesData)
                    if articlesData.count > 0 {
                        //self.array.append(articlesData)
                        self.array.append(contentsOf: articlesData)
                        
                        self.tableview.reloadData()
                    }
                    else {
                        self.shouldLoadMore = false
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print(array.count)
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellItem
        cell.lbl.text = array[indexPath.row].name
        //cell.lbl2.text = array[indexPath.row].name
        cell.backgroundColor = UIColor.brown
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedNumber {
            return 50 * 2
        }
        else
        {
            return 50
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        selectedNumber = row;
        tableview.beginUpdates()
        tableview.endUpdates()
        
        print("\(indexPath.row) clicked")
        print(array[indexPath.row].url ?? "")
        UIApplication.shared.open(NSURL(string: array[indexPath.row].html_url!)! as URL, options: [ : ], completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.array.count - 3
        if indexPath.row == lastElement && shouldLoadMore {
            pageNum = pageNum + 1
            callApi()
            
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        view.backgroundColor = .red
//
//        let lbl = UILabel(frame: view.bounds)
//        lbl.text = "Header"
//
//        view.addSubview(lbl)
//
//        return view
//    }
}

