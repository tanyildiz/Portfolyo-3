//
//  ViewController.swift
//  Portfolyo
//
//  Created by Niyazi TANYILDIZ on 29/05/2017.
//  Copyright © 2017 nt. All rights reserved.
//
import UIKit
import SDWebImage
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workNames = [String]()
    var images = [String]()
    var videos = [String]()
    
    let urlStr = "http://www.tanyildiz.com/?json=1"

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: self.urlStr)

        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if let urlVeri = data
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: urlVeri, options: .mutableContainers) as? NSDictionary
                    
                    if let posts = json
                    {
                        let titles = posts.value(forKeyPath: "posts.title") as! NSArray
                        for i in titles
                        {
                            self.workNames.append(i as! String)
                        }
                        
                        let imgUrl = posts.value(forKey: "posts") as! NSArray
                        let allimages = imgUrl.value(forKeyPath: "attachments.url") as! NSArray
                        for i in (allimages as? [NSArray])!
                        {
                            let k = i[0] as! String
                            if k.hasSuffix("m4v") || k.hasSuffix("mov") {
                                self.videos.append(k)
                                print(self.videos)
                            } else if k.hasSuffix("png") || k.hasSuffix("jpg"){
                             self.images.append(k)
                            }
                        }
                        
                    }
                    // YORUM 1:  Burayı eklemezseniz tabloya veri doldurmaz. AŞAĞIDA 2 yorum daha yazdım
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
                }
                catch
                {
                    print(error)
                }
            }
            
        }
        task.resume()
        //print(self.images)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! SampleTableViewCell
        
        cell.workName.text = workNames[indexPath.row]
        
        let imgView = cell.viewWithTag(1) as? UIImageView
        
        if ((imgView?.image) != nil) {
            imgView?.sd_setImage(with: URL(string: images[indexPath.row]))

        } else {
            
            let player = AVPlayer(url: (NSURL(string: videos[indexPath.row]) as URL?)!)
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = cell.bounds
            
            cell.layer.addSublayer(playerLayer)
            player.play()

            }
        
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
