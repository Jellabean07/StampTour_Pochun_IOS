//
//  DetailViewController.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 19..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController{
    let TAG : String = "DetailViewController"
    var townVO : TownVO?
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var name: UINavigationItem!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageCtrl: UIPageControl!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var intro: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        scrollView.contentSize.height = 667
        
        dataRending()
        
        
    }
    @IBAction func pop(_ sender: Any) {
        CommonFunction.dismiss(self)
    }
    
    func dataRending(){
        if let data : TownVO = self.townVO{
            self.name.title = data.title
            self.subtitle.text = data.subtitle
            self.intro.text = data.intro
            if data.images.count > 0 {
                self.imgView.image = data.images[0]
            }
            setPageControl()
        }
        
    }
    
    func setPageControl(){
        self.pageCtrl.currentPageIndicatorTintColor = AppInfomation.themeColor!
        self.pageCtrl.numberOfPages = (self.townVO?.images.count)!
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        self.swipeGestureLeft.addTarget(self, action: #selector(DetailViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(DetailViewController.handleSwipeRight(_:)))
        
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        
    }
    
    func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if self.pageCtrl.currentPage + 1 >= (self.townVO?.images.count)! {
            print("\(TAG) : right next end ")
            self.pageCtrl.currentPage = 0
            self.setCurrentPageImage(self.pageCtrl.currentPage)
        }else if self.pageCtrl.currentPage < (self.townVO?.images.count)! {
            print("\(TAG) : right next ")
            self.pageCtrl.currentPage += 1
            
            self.setCurrentPageImage(self.pageCtrl.currentPage)
        }
        
    }
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if self.pageCtrl.currentPage != 0 {
            print("\(TAG) : left next")
            self.pageCtrl.currentPage -= 1
            self.setCurrentPageImage(self.pageCtrl.currentPage)
        }else if self.pageCtrl.currentPage == 0{
            print("\(TAG) : left next end ")
            self.pageCtrl.currentPage = (self.townVO?.images.count)!
            self.setCurrentPageImage(self.pageCtrl.currentPage)
        }
    }
    
    fileprivate func setCurrentPageImage(_ index : Int){
        if((self.townVO?.images.count)! > 0){
            self.imgView.image = self.townVO?.images[index]
        }
    }
    
}

