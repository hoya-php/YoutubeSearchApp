//
//  Page1TableViewController.swift
//  YoutubeSearchApp
//
//  Created by 伊藤和也 on 2020/07/21.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage
import Keys

class Page1TableViewController: UITableViewController, SegementSlideContentScrollViewDelegate, XMLParserDelegate {

    var titleSearchString: String?
    
    var youtubeData = YouTubeData()
    
    var videoIdArray =  [String]()
    var publishedAtArray =  [String]()
    var titleArray =  [String]()
    var imageURLArray =  [String]()
    var youtubeURLArray =  [String]()
    var channelTitleArray =  [String]()
    
    //データをリフレッシュ
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データをリフレッシュするコントローラー
        tableView.refreshControl = refresh
        refresh.addTarget(self,
                          action: #selector(updata),
                          for: .valueChanged)
        
        getData()
        tableView.reloadData()
        
    }
    
    //データをリフレッシュする関数
    @objc func updata() {
        
        getData()
        tableView.reloadData()
        refresh.endRefreshing()
        
    }
    
    
    // MARK: SegementSlideContentScrollView
    
    @objc var scrollView: UIScrollView {
        
        return tableView
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indexRow: Int = indexPath.row
        let cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: "Cell")
        
        cell.selectionStyle = .none
        
        let profileImageURL = URL(string: self.imageURLArray[indexRow] as String)!
        
        //cell.imageView?.sd_setImage(with: profileImageURL, completed: nil)
        cell.imageView?.sd_setImage(with: profileImageURL,
                                    completed: {
                                        (image, error, _, _) in
                                        
                                        if error != nil {
                                            cell.setNeedsLayout()
                                        }
                                        
        })
        
        cell.textLabel!.text = self.titleArray[indexRow]
        cell.detailTextLabel!.text = self.publishedAtArray[indexRow]
        
        //Cell内に文字を詰めて表示するオプション。
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        cell.textLabel?.numberOfLines = 5
        cell.detailTextLabel?.numberOfLines = 5
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let indexRow: Int = indexPath.row
        let webViewKit = WebViewKit()
        
        let url = youtubeURLArray[indexRow]
        UserDefaults.standard.set(url, forKey: "url")
        
        present(webViewKit,
                animated: true,
                completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }
    
    
    
    //MARK: - fetch Data
    func getData() {
        
        let instance = YoutubeSearchAppKeys()
        let APIKey: String = instance.youtubeDataAPIKey
        
        let reqestsURLString = "https://www.googleapis.com/youtube/v3/search?key=\(APIKey)&q=\(titleSearchString!)&part=snippet&maxResults=40&order=date"
        
        
        let url = reqestsURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        //API Reqests
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            (response) in
         
            //JSON解析
            print(response)
            switch response.result {
            case.success:
                    
                for i in 0...39 {
                    
                    let json: JSON = JSON(response.data as Any)
                    
                    let kindString = json["items"][i]["id"]["kind"].string
                    if  kindString! != "youtube#playlist" {
                        
                        let videoIdString = json["items"][i]["id"]["videoId"].string
                        let publishedAt = json["items"][i]["snippet"]["publishedAt"].string
                        let titleString = json["items"][i]["snippet"]["title"].string
                        
                        //thumbnails photo
                        let imgURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
                        
                        //youtube URL
                        let youtubeURL = "https://www.youtube.com/watch?v=\(videoIdString!)"
                        let channelTitle = json["items"][i]["snippet"]["channelTitle"].string
                        
                        self.videoIdArray.append(videoIdString!)
                        self.publishedAtArray.append(publishedAt!)
                        self.titleArray.append(titleString!)
                        self.imageURLArray.append(imgURLString!)
                        self.youtubeURLArray.append(youtubeURL)
                        self.channelTitleArray.append(channelTitle!)
                        
                    }
                }
                
                
            case.failure(let error):
                
                print(error)
                break
                
            }
            
            self.tableView.reloadData()
            
        }
                   
                   
                   
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
