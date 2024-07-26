//
//  DetailViewController.swift
//  Project-1
//
//  Created by Kevin Cuadros on 26/07/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
    }
    

}
