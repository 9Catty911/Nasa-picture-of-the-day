//
//  ViewController.swift
//  Nasa picture of the day
//
//  Created by Programming on 25.05.2019.
//  Copyright © 2019 Programming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    
    let url = URL (string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            guard let photoInfo = try? decoder.decode(Photoinfo.self, from: data) else { return }
            
            DispatchQueue.main.async {
                self.titleLable.text = photoInfo.title
                self.explanationLabel.text = photoInfo.explanation
            }
            
            
            guard let imageURL = URL(string: photoInfo.url) else { return }
            
            URLSession.shared.dataTask(with: imageURL) { imageData, _, _ in
                guard let imageData = imageData else { return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                }.resume ()
        }
        
        task.resume()
    }
    
    
}




