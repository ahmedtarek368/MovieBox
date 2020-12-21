//
//  MovieDetailsViewController.swift
//  movieapptst
//
//  Created by Ahmed Tarek on 7/27/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class MovieDetailsViewController: UIViewController {
    
    var dic : Dictionary<String,Any> = [:]
    var connStat = false
    var mdvcGenres : Array<Dictionary<String,Any>> = []
    
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    
    @IBOutlet var MDVController: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelImg: UIImageView!
    @IBOutlet weak var labelOverView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starRatingView.maximumValue = 10
        starRatingView.backgroundColor = .clear
        setBlurGround()
        labelTitle.text = dic["title"] as? String
        
       // Float(truncating: temp["rating"] as! NSNumber)
        let rate : Float = Float(truncating: dic["vote_average"] as! NSNumber)
        labelRating.text = String(rate)
        starRatingView.value = CGFloat(rate)
        
        let year = dic["release_date"]
        labelRelease.text = year as? String
        
        let posterPath : String = String(describing: dic["poster_path"])
        if posterPath != "Optional(<null>)"{
            do
            {
                labelImg.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://image.tmdb.org/t/p/w500\(dic["poster_path"] as! String)")! as URL))
            }catch{ }
        }else{
            labelImg.image = UIImage(named:"noImage2.png")
        }
        
        labelOverView.text = dic["overview"] as? String
        
        //https://api.themoviedb.org/3/genre/movie/list?api_key=3e7ed4340ee87b1eae88e0e9c8f214a9&language=en-US
        let genreArr : Array<Int> = dic["genre_ids"] as! Array<Int>
        labelGenre.text = ""
                for index in 0..<genreArr.count {
                    for i in 0..<mdvcGenres.count{
                        let temp = mdvcGenres[i]
                        let id : Int = temp["id"] as! Int
                        if genreArr[index] == id{
                            let name : String = temp["name"] as! String
                            labelGenre.text = labelGenre.text! + name//String(describing: genreArr[index])
                            if index != genreArr.count-1 {
                                labelGenre.text = labelGenre.text! + ", "
                            }
                        }
                    }
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setBlurGround(){
        
        let backGroundImage = UIImageView()
        MDVController.addSubview(backGroundImage)
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        backGroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backGroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        MDVController.sendSubviewToBack(backGroundImage)
        
        let posterPath : String = String(describing: dic["poster_path"])
        if posterPath != "Optional(<null>)"{
            do{
                backGroundImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "https://image.tmdb.org/t/p/original\(dic["poster_path"] as! String)")! as URL))
            }catch{ }
        }else{
            backGroundImage.image = UIImage(named:"black1.jpg")
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
   /* func editLabel(){
        labelTitle.layer.masksToBounds = true
        labelTitle.layer.cornerRadius = labelTitle.frame.height/2
        labelRating.layer.masksToBounds = true
        labelRating.layer.cornerRadius = labelTitle.frame.height/2
        labelRelease.layer.masksToBounds = true
        labelRelease.layer.cornerRadius = labelTitle.frame.height/2
        labelGenre.layer.masksToBounds = true
        labelGenre.layer.cornerRadius = labelTitle.frame.height/2
        //labelTitle.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
