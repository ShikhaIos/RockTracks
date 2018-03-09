//
//  TrackCell.swift
//  Rock Tracks
//
//  Created by shikha  on 09/03/18.
//  Copyright © 2018 shikha . All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var imageArtist: UIImageView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTrackName: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
