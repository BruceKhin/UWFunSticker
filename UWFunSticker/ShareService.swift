//
//  ShareService.swift
//  UWFunSticker
//
//  Created by Bruce Khin on 25/03/2017.
//  Copyright © 2017 Bruce Khin. All rights reserved.
//

import UIKit
import MessageUI
import Social

class ShareService: NSObject, UIDocumentInteractionControllerDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    
    private let kAlertViewTitle = "Error"
    
    var documentInteractionController = UIDocumentInteractionController()
    
    // singleton manager
    class var sharedManager: ShareService {
        struct Singleton {
            static let instance = ShareService()
        }
        return Singleton.instance
    }
    
    func postImageToSocialWithCaption(imageInstagram: UIImage, instagramCaption: String, view: UIView, type:Int) {
        
        var kShareURL = "instagram://app"
        var kUTI = "com.instagram.exclusivegram"
        
        switch type {
        case 3:
            kShareURL = "instagram://app"
            kUTI = "com.instagram.exclusivegram"
            break;
        case 1:
            kShareURL = "whatsapp://app"
            kUTI = "net.whatsapp.image"
            break;
        default:
            break;
        }
        let instagramURL = NSURL(string: kShareURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            let jpgPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("share.jpg")
            do {
                try UIImageJPEGRepresentation(imageInstagram, 1.0)?.write(to: jpgPath, options: .atomic)
            } catch {
                UIAlertView(title: kAlertViewTitle, message: "Can not write image", delegate:nil, cancelButtonTitle:"Ok").show()
            }
            
            let rect = CGRect.init(x: 0, y: 0, width: 612, height: 612)
//            let fileURL = NSURL.fileURL(withPath: jpgPath)
            documentInteractionController.url = jpgPath
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI
            
            // adding caption for the image
            documentInteractionController.annotation = ["Caption": instagramCaption]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        } else {
            
            // alert displayed when the instagram application is not available in the device
            UIAlertView(title: "Error", message: "App is not installed.", delegate:nil, cancelButtonTitle:"Ok").show()
        }
    }
    
    func saveToLibrary(image:UIImage){
        
        if image == nil{
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func sendToIMessage(image:UIImage, parentVC:UIViewController){
        if image == nil{
            return
        }
        
        if MFMessageComposeViewController.canSendText()
        {
            let messageVC = MFMessageComposeViewController()
            messageVC.messageComposeDelegate = self
            messageVC.subject = "Photo from UW Sticker"
            messageVC.body = "UW Sticker"
            messageVC.addAttachmentData(UIImagePNGRepresentation(image)!, typeIdentifier: "image/png", filename: "UW_Sticker.png")
            parentVC.present(messageVC, animated: true, completion: nil)
        }
        else
        {
            UIAlertView(title: "Error", message: "Add Mail Account", delegate:nil, cancelButtonTitle:"Ok").show()
            
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: false, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: false, completion: nil)
    }
    
    func shareToFacebook(image:UIImage, parentVC:UIViewController){
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            vc.setInitialText("UW STicker!")
            vc.add(image)
            parentVC.present(vc, animated: true, completion: nil)
        }
    }
    
    func shareToTwitter(image:UIImage, parentVC:UIViewController){
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            vc.setInitialText("UW STicker!")
            vc.add(image)
            parentVC.present(vc, animated: true, completion: nil)
        }
    }
}
