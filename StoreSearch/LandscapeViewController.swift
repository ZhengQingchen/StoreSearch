//
//  LandscapeViewController.swift
//  StoreSearch
//
//  Created by mac on 15/1/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class LandscapeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var search: Search!
    private var firstTime = true
    private var downloadTasks = [NSURLSessionDownloadTask]()
    
    
    @IBAction func pageChanged(sender: UIPageControl) {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.bounds.size.width * CGFloat(sender.currentPage), y: 0)
        }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.removeConstraints(view.constraints())
        view.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        pageControl.removeConstraints(pageControl.constraints())
        pageControl.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        scrollView.removeConstraints(scrollView.constraints())
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
        scrollView.contentSize = CGSize(width: 1000, height: 1000)
        
        pageControl.numberOfPages = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        pageControl.frame = CGRect(x: 0,
                                   y: view.frame.size.height - pageControl.frame.size.height,
                               width: view.frame.size.width,
                              height: pageControl.frame.size.height)
        
        if firstTime {
            firstTime = false
            switch search.state {
            case .NotSearchYet,.Loading,.NoResults:
                break
            case .Results(let list):
                tileButtons(list)
            }
        }
        
    }
    
    deinit {
        println("deinit \(self)")
        
        for task in downloadTasks {
            task.cancel()
        }
    }
    
    private func tileButtons(searchResults: [SearchResult]) {
        var columsPerPage = 5
        var rowsPerPage = 3
        
        var itemWidth:CGFloat = 96
        var itemHeight: CGFloat = 88
        var marginX: CGFloat = 0
        var marginY: CGFloat = 20
        
        let scrollViewWidth = scrollView.bounds.size.width
        
        switch scrollViewWidth {
        case 568:
            columsPerPage = 6
            itemWidth = 94
            marginX = 2
        case 667:
            columsPerPage = 7
            itemWidth = 95
            itemHeight = 98
            marginX = 1
            marginY = 29
        case 736:
            columsPerPage = 8
            rowsPerPage = 4
            itemWidth = 92
        default:
            break
        }
        
        let buttonWidth:CGFloat = 82
        let buttonHeight:CGFloat = 82
        let paddingHorz = (itemWidth - buttonWidth)/2
        let paddingVert = (itemHeight - buttonHeight)/2
        
        
        var row = 0
        var column = 0
        var x = marginX
        
        for (index,searchResult) in enumerate(searchResults) {
            let button = UIButton.buttonWithType(.Custom) as UIButton
            button.setBackgroundImage(UIImage(named: "LandscapeButton"), forState: .Normal)
            
            button.frame = CGRect(x: x + paddingHorz,
                                  y: marginY + CGFloat(row) * itemHeight + paddingVert,
                              width: buttonWidth, height: buttonHeight)
            downloadImageForSearchResult(searchResult, andPlaceOnButton: button)
            
            scrollView.addSubview(button)
            
            ++row
            if row == rowsPerPage {
                row = 0
                ++column
                x += itemWidth
                
                if column == columsPerPage {
                    column = 0
                    x += marginX * 2
                }
            }
        }
        
        let buttonsPerPage = columsPerPage * rowsPerPage
        let numPage = 1 + (searchResults.count - 1) / buttonsPerPage
        
        scrollView.contentSize = CGSize(width: CGFloat(numPage) * scrollViewWidth,
                                       height: scrollView.bounds.size.height)
        
        pageControl.numberOfPages = numPage
        pageControl.currentPage = 0
        
        println("Number of pages : \(numPage)")
        println("Number of count of result: \(searchResults.count)")
    }
    
    private func nothingFoundLable() {
        let lable:UILabel = UILabel()
        lable.text = "Nothing Found!"
        lable.textColor = UIColor.whiteColor()
        lable.sizeToFit()
        
        lable.frame = CGRect(x: scrollView.bounds.size.width/2 - lable.frame.size.width/2 ,
            y: scrollView.bounds.size.height/2 - lable.frame.height/2,
            width: 100, height: 44)
        lable.sizeToFit()
        
        scrollView.addSubview(lable)
    }
    
    private func downloadImageForSearchResult(searchResult:SearchResult,andPlaceOnButton button:UIButton) {
        if let url = NSURL(string: searchResult.artworkURL60) {
            let session = NSURLSession.sharedSession()
            let downTask = session.downloadTaskWithURL(url, completionHandler: {
                [weak button] url,response, error in
                if error == nil && url != nil {
                    if let data = NSData(contentsOfURL: url) {
                        if let image = UIImage(data: data) {
                            let resizeImage = image.resizedImageWithBounds(CGSize(width: 60, height: 60))
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                if let button = button {
                                    button.setImage(resizeImage,forState: .Normal)
                                }
                            })
                        }
                    }
                }
            })
            downTask.resume()
            downloadTasks.append(downTask)
        }
    }
}

extension LandscapeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let currentPage = Int((scrollView.contentOffset.x + width/2) / width)
        pageControl.currentPage = currentPage
    }
}
