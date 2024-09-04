//
//  ViewController.swift
//  Project-1
//
//  Created by Kevin Cuadros on 25/07/24.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var timesSeen = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        DispatchQueue.global(qos: .background).async { [weak self] in
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
        
        let defaults = UserDefaults.standard
        if let savedSeen = defaults.dictionary(forKey: "times") as? [String: Int] {
            timesSeen = savedSeen
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let cellTitle = "Image \(pictures[indexPath.row])"
        let seen = timesSeen[cellTitle] ?? 0
        cell.textLabel?.text = cellTitle
        cell.detailTextLabel?.text = "Seen: \(seen)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the DetailViewController
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // Save times seen image
            if let cellName = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                timesSeen[cellName] = (timesSeen[cellName] ?? 0) + 1
            }
            
            // Set selected image on Tap
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.totalImages = pictures.count
            detailVC.selectedIndex = indexPath.row + 1
            tableView.reloadRows(at: [indexPath], with: .fade)
            
            saveData()
            // Navigate DetailView
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    func saveData(){
        let defaults = UserDefaults.standard
        defaults.setValue(timesSeen, forKey: "times")
    }


}

