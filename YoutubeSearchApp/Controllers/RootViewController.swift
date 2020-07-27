//
//  RootViewController.swift
//  YoutubeSearchApp
//
//  Created by 伊藤和也 on 2020/07/21.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import SegementSlide

class RootViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        defaultSelectedIndex = 0
        reloadData()
        
    }
    
    override func segementSlideHeaderView() -> UIView? {
        
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.image = UIImage(named: "header")
        headerView.contentMode = .scaleAspectFill
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top
        } else {
            headerHeight = view.bounds.height / 4 + topLayoutGuide.length
        }
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        return headerView
        
    }
    
    override var titlesInSwitcher: [String] {
        
        return ["東海オンエア",
                "ヒカキン",
                "水溜りボンド",
                "谷やん",
                "福岡県",
                "九州"]
        
        
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        let page1VC = Page1TableViewController()
        page1VC.titleSearchString = titlesInSwitcher[index]
        
        return page1VC
        
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
