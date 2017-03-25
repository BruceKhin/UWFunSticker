//
//  ViewController.swift
//  UWFunSticker
//
//  Created by Bruce Khin on 24/03/2017.
//  Copyright © 2017 Bruce Khin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, SocialPopupDelegate,UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var btnSocialIcon: UIButton!
    
    let reuseIdentifier = "stickerIdentifier" // also enter this string as the cell identifier in the storyboard
    var items = ["1.  DiverDown", "2.  Nitrox", "3.  ScubaBuddy", "4.  U:W Camera", "5.  Buddy Calendar", "6.  rib boat diving", "7. Charter Boat Diving", "8.  Wreck Diving", "9.  Reef Diving", "10.  lobster Diving 2", "11. Scuba Kitty", "12.  Scuba Doggie", "13. Scuba Gear", "14. Scuba C-Card", "15.  Shark", "16.  Scuba Tent", "22.  ScubaParrot", "22a- Scuba Parrot", "23.  Mayn Scuba Dude", "24. Divers Weights Belt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        btnSocialIcon .setBackgroundImage(UIImage(named:"Messages"), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showSharePopVC"){
            let popOverVC = segue.destination as! SocialPopupVC;
            popOverVC.popoverPresentationController?.delegate = self;
            popOverVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
            popOverVC.popoverPresentationController?.backgroundColor = UIColor.white
            popOverVC.popoverPresentationController?.sourceRect = CGRect.init(x: 30, y: 40, width: 0, height: 0)
            popOverVC.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func socialPopupIconPressed(_ sender: Any) {
        self .performSegue(withIdentifier: "showSharePopVC", sender: sender)
    }
    
    func socialSelected(socialName: String) {
        btnSocialIcon .setBackgroundImage(UIImage(named:socialName), for: UIControlState.normal)
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
        
    }

}

