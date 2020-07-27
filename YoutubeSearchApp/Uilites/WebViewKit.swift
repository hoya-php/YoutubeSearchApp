//
//  WebViewKit.swift
//  YoutubeSearchApp
//
//  Created by 伊藤和也 on 2020/07/21.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import WebKit

class WebViewKit: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        webView.frame = CGRect(x: 0,
                               y: 0,
                               width: view.frame.width,
                               height: view.frame.height - 50)
        
        view.addSubview(webView)
        
        
        //Https Reqest
        let urlString = UserDefaults.standard.object(forKey: "url")
        let url = URL(string: urlString as! String)
        let request = URLRequest(url: url!)
        
        webView.load(request)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("WebView Modal Dismiss")
        
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
