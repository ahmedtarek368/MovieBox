//
//  CollectionViewController.swift
//  movieapptst
//
//  Created by Ahmed Tarek on 7/30/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SideMenu
private let reuseIdentifier = "cvc"

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,reloadData {
    
    var connectStatue = false
    var menuStatue : Int = 0
    var genres : Array<Dictionary<String,Any>> = []
    var MovC : Array<Dictionary<String,Any>>=[]
    @IBOutlet var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkReachabilityManager()
        if networkManager?.isReachable == true {
            print("Connected")
            connectStatue = true
            if menuStatue == 0{
                for i in 1...3{
                    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US&page=\(i)")
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
                                    self.MovC.append(temp[j])
                                }
                            }
                            print(self.MovC.count)
                            if i == 3 {
                                DispatchQueue.main.async{
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    self.collView.reloadData()
                                }
                            }
                        }catch let error{
                            print(error)
                        }
                    }
                    task.resume()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            }else if menuStatue != 0{
                collView.reloadData()
                print(MovC.count)
                print(menuStatue)
            }
            if menuStatue != 5 {
                let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US")
                let request = URLRequest(url: url!)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request){ (data, response, error)in
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                        self.genres = json!["genres"] as! Array<Dictionary<String, Any>>
                        print(self.genres)
                        DispatchQueue.main.async{
                            self.collView.reloadData()
                        }
                    }catch let error{
                        print(error)
                    }
                }
                task.resume()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        ///////////////////////Black Transparent Navigation Bar////////////////////////
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "black1.jpg"), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
//        let leftMenuNavigationController = UISideMenuNavigationController(view)
//        SideMenuManager.default.menuLeftNavigationController = leftMenuNavigationController as! UISideMenuNavigationController
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
//        //leftMenuNavigationController.Status
        
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovC.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvc", for: indexPath)
        
        var temp = MovC[indexPath.row]
        let imgLabel :UIImageView = cell.viewWithTag(1) as! UIImageView
        let titleView : UITextView = cell.viewWithTag(4) as! UITextView
        titleView.text = temp["title"] as? String
        if menuStatue == 5 {
            imgLabel.image = UIImage(data: temp["poster_path"] as! Data)
        }else{
            let posterPath : String = String(describing: temp["poster_path"])
            if posterPath != "Optional(<null>)"{
                do{
                    imgLabel.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://image.tmdb.org/t/p/original\(temp["poster_path"] as! String )")! as URL))
                }catch{}
            }else{
                imgLabel.image = UIImage(named:"noImage2.png")
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mdvc2 : MDViewController = self.storyboard?.instantiateViewController(withIdentifier: "mdvc2") as! MDViewController
        mdvc2.delegate = self
        mdvc2.menuStatue = self.menuStatue
        self.navigationController?.pushViewController(mdvc2, animated: true)
        let temp = MovC[indexPath.row]
        mdvc2.dic = temp
        if menuStatue != 5{
            mdvc2.mdvcGenres = genres
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height : CGFloat = self.view.frame.size.height
        let width : CGFloat = self.view.frame.size.width
        return CGSize(width: width * 0.497 , height: height * 0.314 )
        //return CGSize(width: width * 0.497 , height: height * 0.334 )
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2.3
    //    }
    
    // MARK: Menu Bar Button
    
    @IBAction func sideMenu(_ sender: Any) {
        let menu = self.storyboard?.instantiateViewController(withIdentifier: "SMTVC") as! UISideMenuNavigationController
        //MovC = []
        present(menu , animated: true , completion: nil)
    }
    
    func reloadcollViewData(Mov: Array<Dictionary<String, Any>>) {
        self.MovC = Mov
        collView.reloadData()
    }
}
