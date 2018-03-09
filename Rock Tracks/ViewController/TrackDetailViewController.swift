//
//  TrackDetailViewController.swift
//  Rock Tracks
//
//  Created by shikha  on 09/03/18.
//  Copyright © 2018 shikha . All rights reserved.
//

import UIKit
import SafariServices


class TrackDetailViewController: UIViewController {
    var objTrackDetail : Track?
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    @IBOutlet weak var labelTrackPrice: UILabel!
    @IBOutlet weak var labelAristName: UILabel!
    @IBOutlet weak var labelTrackName: UILabel!
    @IBOutlet weak var selectedImge: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = objTrackDetail
        {
            let catPictureURL = URL(string: photo.artworkUrl100)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded picture with response code \(res.statusCode)")
                        if let imageData = data {
                            
                            let image = UIImage(data: imageData)
                            self.selectedImge.image = image
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }
            
            downloadPicTask.resume()
            labelTrackName.text = objTrackDetail?.trackName
            labelAristName.text = objTrackDetail?.artistName
            if let obj = objTrackDetail?.trackPrice
            {
                labelTrackPrice.text = String(describing: obj)
            }
            labelReleaseDate.text = objTrackDetail?.releaseDate
        }
        
       
        // Do any additional setup after loading the view.
    }

    @IBAction func btnMoreDetailAction(_ sender: Any) {

        let url = URL(string: (objTrackDetail?.trackViewUrl)!)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
        //UIApplication.shared.openURL(URL(string: (objTrackDetail?.trackViewUrl)!)!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
