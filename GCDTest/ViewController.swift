//
//  ViewController.swift
//  GCDTest
//
//  Created by user on 23/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // URL for the image resource
        guard let imageUlr = URL(string: "https://cdn.photographylife.com/wp-content/uploads/2014/09/Nikon-D750-Image-Samples-2.jpg") else { return }
        guard let imageUlr2 = URL(string: "https://photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-4.jpg") else { return }
        guard let imageUlr3 = URL(string: "https://cdn.photographylife.com/wp-content/uploads/2012/02/Nikon-D800-Image-Sample-3.jpg") else { return }
        // All urls in array
        let imageArray = [imageUlr, imageUlr2, imageUlr3]
        
        //  Serial Queue
//        let serialQ = DispatchQueue(label: "serial queue")
//        serialQ.async {
//            for i in 0...2 {
//                guard let data = try? Data(contentsOf: imageArray[i]), let image = UIImage(data: data) else { return}
//                DispatchQueue.main.async {
//                    switch i {
//                        case 0 : self.myImageView.image = image
//                        case 1 : self.imageView2.image = image
//                        case 2 : self.imageView3.image = image
//                        default:
//                            print("no data")
//                    }
//                }
//            }
//        }
        
        // Concurrent queue
        let concurrentQ  = DispatchQueue(label: "concurrent queue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        concurrentQ.async {
            for i in 0...2 {
                guard let data = try? Data(contentsOf: imageArray[i]), let image = UIImage(data: data) else { return}
                DispatchQueue.main.async {
                    switch i {
                        case 0 : self.myImageView.image = image
                        case 1 : self.imageView2.image = image
                        case 2 : self.imageView3.image = image
                        default:
                            print("no data")
                    }
                }
            }
        }
        // Make network request
//        let dataTask = URLSession.shared.dataTask(with: imageUlr) { (data, response, error ) in
//            guard let imageData = data, let image = UIImage(data: imageData) else { return }
//            DispatchQueue.main.async {
//                self.myImageView.image = image
//            }
//        }
//        dataTask.resume()
    }


}

