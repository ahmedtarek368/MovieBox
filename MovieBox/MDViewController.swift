//
//  MDViewController.swift
//  MovieBox
//
//  Created by Ahmed Tarek on 8/20/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class MDViewController: UIViewController {
    var favBtn : UIBarButtonItem?
    var dic : Dictionary<String,Any> = [:]
    var mdvcGenres : Array<Dictionary<String,Any>> = []
    var genresArrStr : Array<String> = []
    var menuStatue : Int = 0
    var delegate:reloadData?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    @IBOutlet var MDVCController: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelImg: UIImageView!
    @IBOutlet weak var labelOverView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        scrollView.setContentOffset(CGPoint.zero, animated: false)
        starRatingView.maximumValue = 10
        starRatingView.backgroundColor = .clear
        setBlurGround()
        labelTitle.text = dic["title"] as? String
        
        let rate : Float = Float(truncating: dic["vote_average"] as! NSNumber)
        labelRating.text = String(rate)
        starRatingView.value = CGFloat(rate)
        
        let year = dic["release_date"]
        labelRelease.text = year as? String
        
        if menuStatue != 5{
            let posterPath : String = String(describing: dic["poster_path"])
            if posterPath != "Optional(<null>)"{
                do
                {
                    labelImg.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://image.tmdb.org/t/p/w500\(dic["poster_path"] as! String)")! as URL))
                }catch{ }
            }else{
                labelImg.image = UIImage(named:"noImage2.png")
            }
        }else if menuStatue == 5{
            labelImg.image = UIImage(data: dic["poster_path"] as! Data)
        }
        
        labelOverView.text = dic["overview"] as? String
        
        if menuStatue != 5{
            let genreArr : Array<Int> = dic["genre_ids"] as! Array<Int>
            labelGenre.text = ""
            for index in 0..<genreArr.count {
                for i in 0..<mdvcGenres.count{
                    let temp = mdvcGenres[i]
                    let id : Int = temp["id"] as! Int
                    if genreArr[index] == id{
                        let name : String = temp["name"] as! String
                        genresArrStr.append(name)
                        labelGenre.text = labelGenre.text! + name
                        if index != genreArr.count-1 {
                            labelGenre.text = labelGenre.text! + ", "
                        }
                    }
                }
            }
        }else if menuStatue == 5{
            labelGenre.text = ""
            let genre = dic["genre"] as! Array<String>
            for i in 0..<genre.count{
                labelGenre.text = labelGenre.text! + genre[i]
                if i != genre.count-1 {
                    labelGenre.text = labelGenre.text! + ", "
                }
            }
        }
}
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        if isAttributeExist(Title: dic["title"] as! String) == true {
            favBtn = UIBarButtonItem(image: UIImage(named: "favBtnfilled48.png"), style: .plain, target: self, action: #selector(favBtnAction))
            self.navigationItem.rightBarButtonItem = favBtn
        }else{
            favBtn = UIBarButtonItem(image: UIImage(named: "favBtnunfilled48.png"), style: .plain, target: self, action: #selector(favBtnAction))
            self.navigationItem.rightBarButtonItem = favBtn
        }
        
}
    
    func setBlurGround(){
        
        let backGroundImage = UIImageView()
        MDVCController.addSubview(backGroundImage)
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        backGroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backGroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        MDVCController.sendSubviewToBack(backGroundImage)
        if menuStatue != 5{
            let posterPath : String = String(describing: dic["poster_path"])
            if posterPath != "Optional(<null>)"{
                do{
                    backGroundImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://image.tmdb.org/t/p/original\(dic["poster_path"] as! String)")! as URL))
                }catch{ }
            }else{
                backGroundImage.image = UIImage(named:"black1.jpg")
            }
        }else if menuStatue == 5{
            backGroundImage.image = UIImage(data: dic["poster_path"] as! Data)
        }
        
        
        let blurGround = UIVisualEffectView()
        let blur : UIBlurEffect = UIBlurEffect(style: .dark)
        blurGround.effect = blur
        backGroundImage.addSubview(blurGround)
        blurGround.translatesAutoresizingMaskIntoConstraints = false
        blurGround.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurGround.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        blurGround.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blurGround.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    @objc func favBtnAction(){
        if isAttributeExist(Title: dic["title"] as! String) == true{
            favBtn = UIBarButtonItem(image: UIImage(named: "favBtnunfilled48.png"), style: .plain, target: self, action: #selector(favBtnAction))
            self.navigationItem.rightBarButtonItem = favBtn
            
            CDDeletion(Title: dic["title"] as! String)
            print("data deleted")
            if menuStatue == 5{
                let MovC = CDFetching()
                delegate?.reloadcollViewData(Mov: MovC)
            }
            
        }else{
            favBtn = UIBarButtonItem(image: UIImage(named: "favBtnfilled48.png"), style: .plain, target: self, action: #selector(favBtnAction))
            self.navigationItem.rightBarButtonItem = favBtn
            
            let rate : Float = Float(truncating: dic["vote_average"] as! NSNumber)
            CDInsertion(Title: dic["title"] as! String, Rating: rate, releaseYear: dic["release_date"] as! String, Genre: genresArrStr, Image: labelImg.image!, OverView: labelOverView.text)
            if menuStatue == 5{
                let MovC = CDFetching()
                delegate?.reloadcollViewData(Mov: MovC)
            }
            
        }
    }
}
