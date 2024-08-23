//
//  ViewController.swift
//  Project-1
//
//  Created by Kevin Cuadros on 25/07/24.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        DispatchQueue.global().async { [weak self] in
            if let items = try? fm.contentsOfDirectory(atPath: path){
                for item in items {
                    if(item.hasPrefix("nssl")){
                        self?.pictures.append(item)
                    }
                }
                self?.pictures.sort()
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Image \(pictures[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the DetailViewController
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // Set selected image on Tap
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.totalImages = pictures.count
            detailVC.selectedIndex = indexPath.row + 1
            
            // Navigate DetailView
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }


}

