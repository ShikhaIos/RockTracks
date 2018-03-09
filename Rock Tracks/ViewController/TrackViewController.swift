//
//  TrackViewController.swift
//  Rock Tracks
//
//  Created by shikha  on 09/03/18.
//  Copyright © 2018 shikha . All rights reserved.
//

import UIKit

class TrackViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var arrData = [Track]()
    var selectedData:Track?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrackRecords()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to get data from server

    func getTrackRecords ()
    {
        ServiceManager.getData( Constant.URL.appLogin, completion: { (response, error) in
            
            print(response ?? "")
            let patientList = response?["results"] as? Array<Any>
            for patient in patientList! {
                let obj = Track(patient as! Dictionary<String, Any>)
                self.arrData.append(obj)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
    //  TableViewDataSource and Delegate Method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TrackCell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        print(indexPath.section)
        let row  = arrData[indexPath.row]
        let catPictureURL = URL(string: row.artworkUrl100)!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        
                        let image = UIImage(data: imageData)
                        let deadlineTime = DispatchTime.now() + .seconds(0)
                        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                            cell.imageArtist.image = image
                            
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
        cell.labelTrackName.text = row.trackName
        cell.labelArtist.text = row.artistName
        if let number = row.trackPrice
        {
            cell.labelPrice.text = String(describing: number)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedData = self.arrData[indexPath.row]
        self.performSegue(withIdentifier: "trackDetail", sender: self)
    }
    // StoryBoard prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? TrackDetailViewController {
            dvc.objTrackDetail = selectedData
        }
    }
    
}


