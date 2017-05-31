//
//  ViewController.swift
//  Portfolyo
//
//  Created by Niyazi TANYILDIZ on 29/05/2017.
//  Copyright © 2017 nt. All rights reserved.
//
import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workNames = [String]()
    var images = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlStr = "http://www.tanyildiz.com/?json=1"
        let url = URL(string: urlStr)
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
                        
                        let imgUrl = posts.value(forKeyPath: "posts.attachments.url") as! NSArray
                        
                        for _ in 0..<imgUrl.count
                        {
                            self.images.append(imgUrl.lastObject as! String)
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
        //YORUM 2:Task resume yanlış yerde kullanılmıştı Xcode öncesinde ; öneriyorsa bilinki hata yapmışsınızdır
        task.resume()
        print(self.images)
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
        return 200
    }
    
}
