//
//  SplashScreen.swift
//  movieapptst
//
//  Created by Ahmed Tarek on 8/4/19.
//  Copyright © 2019 Ahmed Tarek. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {
    var background = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackGround()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+4){
            self.performSegue(withIdentifier: "skipSplash", sender: nil)
        }
        
    }
    func setBackGround(){

        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.image = UIImage(named: "splashscreen1.jpg")
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
