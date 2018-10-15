//
//  PageViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 07/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class PageViewController: UIViewController , UIPageViewControllerDataSource {
    
    
    var pageImages:NSArray!
    var pageViewController:UIPageViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        pageImages = NSArray(objects:"screen1","screen2","screen3")
        
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let initialContenViewController = self.pageTutorialAtIndex(0) as ContentPageViewController
        
        self.pageViewController.setViewControllers([initialContenViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height-100)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func pageTutorialAtIndex(_ index: Int) ->ContentPageViewController
    {
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentPageViewController") as! ContentPageViewController
        
        pageContentViewController.imageFileName = pageImages[index] as! String
        pageContentViewController.pageIndex = index
        
        
        return pageContentViewController
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ContentPageViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        return self.pageTutorialAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ContentPageViewController
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index += 1
        
        if(index == pageImages.count)
        {
            return nil
        }
        
        return self.pageTutorialAtIndex(index)
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return pageImages.count
    }
    
    
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    @IBAction func skipButtonTapped(_ sender: AnyObject) {
        
        //Remember user's choice, so we can skip tutorial when user starts the app again
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "skipTutorialPages")
        defaults.synchronize()
        
        
        let nextView: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.window!.rootViewController = nextView
        appdelegate.window?.makeKeyAndVisible()

    }
    
    
}

