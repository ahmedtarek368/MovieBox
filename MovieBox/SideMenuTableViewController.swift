//
//  SideMenuTableViewController.swift
//  MovieBox
//
//  Created by Ahmed Tarek on 8/21/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mdvcSM : CollectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "cvc") as! CollectionViewController
        let topRated = 1
        if indexPath.row == topRated {
            var MovSM : Array<Dictionary<String,Any>>=[]
            for i in 1...3{
                let url = URL(string:"https://api.themoviedb.org/3/movie/top_rated?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US&page=\(i)" )
                let request = URLRequest(url: url!)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request){ (data, response, error)in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                        let temp = json!["results"] as! Array<Dictionary<String, Any>>
                        if json != nil{
                            for j in 0..<temp.count {
                                let img = temp[j]
                                print(img["title"]!)
                                MovSM.append(temp[j])
                            }
                        }
                        print(MovSM.count)
                        if i == 3 {
                            DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                mdvcSM.menuStatue = topRated
                                mdvcSM.MovC = MovSM
                                self.navigationController?.pushViewController(mdvcSM, animated: true)
                            }
                        }
                    }catch let error{
                        print(error)
                    }
                }
                task.resume()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        let popular = 2
        if indexPath.row == popular{
            var MovSM : Array<Dictionary<String,Any>>=[]
            for i in 1...2{
                let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US&page=\(i)" )
                let request = URLRequest(url: url!)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request){ (data, response, error)in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                        let temp = json!["results"] as! Array<Dictionary<String, Any>>
                        if json != nil{
                            for j in 0..<temp.count {
                                let img = temp[j]
                                print(img["title"]!)
                                MovSM.append(temp[j])
                            }
                        }
                        print(MovSM.count)
                        if i == 2 {
                            DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                mdvcSM.menuStatue = popular
                                mdvcSM.MovC = MovSM
                                self.navigationController?.pushViewController(mdvcSM, animated: true)
                            }
                        }
                    }catch let error{
                        print(error)
                    }
                }
                task.resume()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        let mostrecent = 3
        if indexPath.row == mostrecent{
            var MovSM : Array<Dictionary<String,Any>>=[]
            for i in 1...3{
                let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US&page=\(i)" )
                let request = URLRequest(url: url!)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request){ (data, response, error)in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                        let temp = json!["results"] as! Array<Dictionary<String, Any>>
                        if json != nil{
                            for j in 0..<temp.count {
                                let img = temp[j]
                                print(img["title"]!)
                                MovSM.append(temp[j])
                            }
                        }
                        print(MovSM.count)
                        if i == 3 {
                            DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                mdvcSM.menuStatue = mostrecent
                                mdvcSM.MovC = MovSM
                                self.navigationController?.pushViewController(mdvcSM, animated: true)
                            }
                        }
                    }catch let error{
                        print(error)
                    }
                }
                task.resume()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        let upcoming = 4
        if indexPath.row == upcoming{
            var MovSM : Array<Dictionary<String,Any>>=[]
            for i in 1...3{
                let url = URL(string:"https://api.themoviedb.org/3/movie/upcoming?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US&page=\(i)" )
                let request = URLRequest(url: url!)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request){ (data, response, error)in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                        let temp = json!["results"] as! Array<Dictionary<String, Any>>
                        if json != nil{
                            for j in 0..<temp.count {
                                let img = temp[j]
                                print(img["title"]!)
                                MovSM.append(temp[j])
                            }
                        }
                        print(MovSM.count)
                        if i == 3 {
                            DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                mdvcSM.menuStatue = upcoming
                                mdvcSM.MovC = MovSM
                                self.navigationController?.pushViewController(mdvcSM, animated: true)
                            }
                        }
                    }catch let error{
                        print(error)
                    }
                }
                task.resume()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        let favourite = 5
        if indexPath.row == favourite{
            var MovSM : Array<Dictionary<String,Any>>=[]
            MovSM = CDFetching()
            mdvcSM.menuStatue = favourite
            mdvcSM.MovC = MovSM
            self.navigationController?.pushViewController(mdvcSM, animated: true)
        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
