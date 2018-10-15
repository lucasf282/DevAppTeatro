//
//  OnboardingPager.swift
//  AppTeatro
//
//  Created by Lucas Farias on 30/09/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit

class OnboardingPager: UIPageViewController {
    
    
    func getOnboard01() -> OnBoard01ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "OnBoard01ViewController") as! OnBoard01ViewController
    }
    func getOnboard02() -> OnBoard02ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "OnBoard02ViewController") as! OnBoard02ViewController
    }
    func getOnboard03() -> OnBoard03ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "OnBoard03ViewController") as! OnBoard03ViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        dataSource = self
        setViewControllers([getOnboard01()], direction: .forward, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

// MARK: - DataSource
extension OnboardingPager : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: OnBoard03ViewController.self) {
            return getOnboard02()
        } else if viewController.isKind(of: OnBoard02ViewController.self) {
            return getOnboard01()
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: OnBoard01ViewController.self) {
            return getOnboard02()
        } else if viewController.isKind(of: OnBoard02ViewController.self) {
            return getOnboard03()
        } else {
            return nil
        }
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 1
    }
}
