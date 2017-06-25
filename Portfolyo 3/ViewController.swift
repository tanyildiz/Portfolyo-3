//
//  ViewController.swift
//  Portfolyo
//
//  Created by Niyazi TANYILDIZ on 29/05/2017.
//  Copyright © 2017 nt. All rights reserved.
//
import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import AVKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workNames = [String]()
    var images = [String]()
    let urlStr = "http://www.tanyildiz.com/?json=1"

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: urlStr)
        
        Alamofire.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let posts = json["posts"].stringValue
                print(posts)
                    self.images.append(posts)
                    print(self.images)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return workNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //YORUM 3: Resim alanını burda tanımlamayıp tasarım ekranında tanımlarsanız uygulamanız çalışmaz.
        //Resim olayı için kampanyalar derslerinin tamamını izleyin
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! SampleTableViewCell
        
        cell.workName.text = workNames[indexPath.row]
        
        let imgView = cell.viewWithTag(1) as? UIImageView
        imgView?.sd_setImage(with: URL(string: images[indexPath.row]))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BigImageVC") as? DetailsViewController {
            vc.navigationItem.title = workNames[indexPath.row]
            
            vc.selectedImage = images[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
