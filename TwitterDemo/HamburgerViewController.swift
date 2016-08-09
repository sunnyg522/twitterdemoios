//
//  HamburgerViewController.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 8/8/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leftMarginConstrain: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var menuViewController: UIViewController! {
        didSet{
            view.layoutIfNeeded()
            menuViewController.willMoveToParentViewController(self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMoveToParentViewController(self)
        }
    }
    var contentViewController: UIViewController! {
        didSet (oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            
            contentViewController.willMoveToParentViewController(self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.leftMarginConstrain.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            originalLeftMargin = leftMarginConstrain.constant
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            leftMarginConstrain.constant = originalLeftMargin + translation.x
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            UIView.animateWithDuration(0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstrain.constant = self.view.frame.size.width - 50
                } else {
                    self.leftMarginConstrain.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
            
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
