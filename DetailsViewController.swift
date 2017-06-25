//
//  DetailsViewController.swift
//  Portfolyo 3
//
//  Created by niyazi on 07/06/2017.
//  Copyright © 2017 tanyildiz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleDetails: UINavigationBar!
    @IBOutlet weak var bigImage: UIImageView!
    
    @IBOutlet var detailVC: UIView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        if let imageToLoad = selectedImage {
            bigImage.image  = UIImage(named: imageToLoad)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
