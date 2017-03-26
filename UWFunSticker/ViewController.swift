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
    
    @IBOutlet weak var btnSendSave: UIButton!
    
    @IBOutlet weak var ivPreview: UIImageView!
    
    var selectSocial:String!
    
    let reuseIdentifier = "stickerIdentifier" // also enter this string as the cell identifier in the storyboard
    var items = ["1.  DiverDown", "2.  Nitrox", "3.  ScubaBuddy", "4.  U:W Camera", "5.  Buddy Calendar", "6.  rib boat diving", "7. Charter Boat Diving", "8.  Wreck Diving", "9.  Reef Diving", "10.  lobster Diving 2", "11. Scuba Kitty", "12.  Scuba Doggie", "13. Scuba Gear", "14. Scuba C-Card", "15.  Shark", "16.  Scuba Tent", "22.  ScubaParrot", "22a- Scuba Parrot", "23.  Mayn Scuba Dude", "24. Divers Weights Belt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        btnSocialIcon .setBackgroundImage(UIImage(named:"Messages"), for: UIControlState.normal)
        btnSendSave.layer.cornerRadius = 15
        selectSocial = "Messages"
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
        selectSocial = socialName
        if socialName == "Photos"{
            btnSendSave.setTitle("Save", for: UIControlState.normal)
        }
        else{
            btnSendSave.setTitle("Send", for: UIControlState.normal)
        }
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
        ivPreview.image = UIImage(named: self.items[indexPath.item])
    }

    @IBAction func sendSaveSticker(_ sender: Any) {
        if ivPreview.image == nil{
            return
        }
        switch self.selectSocial {
            case "Messages":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 0)
                break;
            case "WhatsAPP":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 1)
                break;
            case "Twitter":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 2)
                break;
            case "Instagram":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 3)
                break;
            case "Facebook":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 4)
                break;
            case "Photos":
                self.shareSaveSticker(image: ivPreview.image!, socialType: 5)
                break;
            default:
                self.shareSaveSticker(image: ivPreview.image!, socialType: 0)
                break;
        }
    }
    
    func shareSaveSticker(image:UIImage, socialType:Int){
        switch socialType{
        case 0://iMessage
            ShareService.sharedManager.sendToIMessage(image: image, parentVC:self)
            break;
        case 1://Whatsapp
            ShareService.sharedManager.postImageToSocialWithCaption(imageInstagram: image, instagramCaption: "UW Sticker", view: self.view, type: 1)
            break;
        case 2://Twitter
            ShareService.sharedManager.shareToTwitter(image: image, parentVC:self)
            break;
            
        case 3://Instagram
            ShareService.sharedManager.postImageToSocialWithCaption(imageInstagram: image, instagramCaption: "UW Sticker", view: self.view, type: 3)
            break;
        case 4:
            ShareService.sharedManager.shareToFacebook(image: image, parentVC:self)
            break;
        case 5:
            ShareService.sharedManager.saveToLibrary(image: image)
            self.showAlert(title: "", message: "Image was saved", buttonName: "OK")
            break;
        default:
            break;
        }
    }
    
    func showAlert(title:String, message:String, buttonName:String){
        // Create the alert controller
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: buttonName, style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            //self.dismiss(animated: true, completion: nil);
        }
        // Add the actions
        alertController.addAction(okAction)
        //alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

