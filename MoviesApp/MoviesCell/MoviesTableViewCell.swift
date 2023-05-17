//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by MacBook 28 on 22/03/23.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    // set the outlets for the customized cell
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var isRestrictedLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //pass the information of the movie in order to setup the final cell
    func setup(withMovie movie: MovieEntity){
        titleLabel.numberOfLines = 0
        titleLabel.text = movie.name
        directorLabel.text = movie.director
        isRestrictedLabel.text = (movie.isRestricted == true) ? "R" : "G"
        colorView.backgroundColor = (movie.isRestricted == true) ? UIColor.red : UIColor.blue
        directorLabel.text = String(movie.duration)
        yearLabel.text = String(movie.year)
    
    }
    
    //setup the UI
    private func setUpUI(){
        colorView.layer.cornerRadius = colorView.bounds.height / 2
    }
    
}
