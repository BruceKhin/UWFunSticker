//
//  SocialPopupVC.swift
//  UWFunSticker
//
//  Created by Bruce Khin on 25/03/2017.
//  Copyright © 2017 Bruce Khin. All rights reserved.
//

import UIKit

protocol SocialPopupDelegate{
    func socialSelected(socialName:String)
}

class SocialPopupVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate:SocialPopupDelegate?
    
    let reuseIdentifier = "socialCellIdentifier" // also enter this string as the cell identifier in the storyboard
    var items = ["Messages", "WhatsAPP", "Twitter", "Instagram", "Facebook", "Photos"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SocialButtonCVC
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.lblSocialName.text = self.items[indexPath.item]
        cell.ivSocialIcon.image = UIImage(named:self.items[indexPath.item])        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        delegate?.socialSelected(socialName: self.items[indexPath.item])
        self.dismiss(animated: true, completion: nil)
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
