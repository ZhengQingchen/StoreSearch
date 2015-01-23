//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by mac on 15/1/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airtistNameLable: UILabel!
    @IBOutlet weak var kindLable: UILabel!
    @IBOutlet weak var genreLable: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    
    var searchResult:SearchResult!
    var downloadTask: NSURLSessionDownloadTask?
    
    enum AnimationStyle {
        case Slide
        case Fade
    }
    
    var dismissAnimationStyle = AnimationStyle.Fade
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
    }
    
    @IBAction func close() {
        dismissAnimationStyle = .Slide
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openInStore(sender: AnyObject) {
        if let url = NSURL(string: searchResult.storeURL){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        view.backgroundColor = UIColor.clearColor()
        
        popupView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("close"))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        if searchResult != nil{
            upgateUI()
        }
    }
    
    func upgateUI(){
        nameLabel.text = searchResult.name
        if searchResult.artistName.isEmpty {
            airtistNameLable.text = "Unknown"
        }else{
            airtistNameLable.text = searchResult.artistName
        }
        
        kindLable.text = searchResult.kindForDisplay()
        genreLable.text = searchResult.genre
            
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.currencyCode = searchResult.currency
        
        var priceText:String
        if searchResult.price == 0 {
            priceText = "Free"
        }else if let text = formatter.stringFromNumber(searchResult.price) {
            priceText = text
        }else{
            priceText = ""
        }
        
        priceButton.setTitle(priceText, forState: .Normal)
            
        if let url = NSURL(string: searchResult.artworkURL100) {
            downloadTask = artworkImageView.loadImageWithURL(url)
        }
    }
    
    deinit{
        println("deinit \(self)")
        downloadTask?.cancel()
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController:presented,
            presentingViewController:presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissAnimationStyle {
        case .Slide :
            return SlideOutAnimationController()
        case .Fade:
            return FadeOutAnimationController()
        }
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return (touch.view === view)
    }
}
