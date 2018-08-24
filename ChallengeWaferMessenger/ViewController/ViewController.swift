//
//  ViewController.swift
//  ChallengeWaferMessenger
//
//  Created by Fernanda de Lima on 21/08/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //to manipulate countries
    var countries:[Country] = []
    
    @IBOutlet weak var countriesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.get(success: { (country) in
            self.countries = country
            
            //reload table on main thread
            DispatchQueue.main.async {
                self.countriesTable.reloadData()
            }
            
        }) { (error) in
            
            print("JSON Serialization error")
            print(error.localizedDescription)
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifier") as! CountryCell
        cell.nameLabel.text = countries[indexPath.row].name
        cell.languageLabel.text = countries[indexPath.row].languages[0].name
        cell.currencyLabel.text = countries[indexPath.row].currencies[0].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "") { (action, indexPath) in
            // delete item at indexPath
            self.countries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
        
        delete.setImage(size: CGSize(width: UIScreen.main.bounds.width, height: 60), image: #imageLiteral(resourceName: "bombIcon"), bgColor: .purple)

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            self.countries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }

        deleteAction.image = #imageLiteral(resourceName: "bombIcon")
        deleteAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
    
}

extension UITableViewRowAction {
    
    func setImage(size: CGSize, image: UIImage, bgColor: UIColor) {
        
        // calculate actual size & set title with spaces
        let defaultTextPadding: CGFloat = 15
        let defaultAttributes = [ kCTFontAttributeName: UIFont.systemFont(ofSize: 18)]   // system default rowAction text font
        let oneSpaceWidth = NSString(string: " ").size(withAttributes: defaultAttributes as [NSAttributedStringKey : Any]).width
        let titleWidth = size.width - defaultTextPadding * 2
        let numOfSpace = Int(ceil(titleWidth / oneSpaceWidth))
        
        let placeHolder = String(repeating: " ", count: numOfSpace)
        let newWidth = (placeHolder as NSString).size(withAttributes: defaultAttributes as [NSAttributedStringKey : Any]).width + defaultTextPadding * 2
        let newSize = CGSize(width: newWidth, height: size.height)
        
        title = placeHolder
        
        // set background with pattern image
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.nativeScale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(bgColor.cgColor)
        context.fill(CGRect(origin: .zero, size: newSize))
        
        let originX = (newWidth - image.size.width)
        let originY = (size.height - image.size.height) / 2
        image.draw(in: CGRect(x: originX, y: originY, width: image.size.width, height: image.size.height))
        let patternImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        backgroundColor = UIColor(patternImage: patternImage)
    }
}

