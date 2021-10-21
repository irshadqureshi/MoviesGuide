//
//  DashboardCell.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 17/10/2021.
//

import UIKit
import Kingfisher
import CollectionViewSlantedLayout

protocol DashboardCellProtocol {
    var movieImageURL: URL? {get set}
    var movieName: String {get set}
    var movieRating: String {get set}
}

class DashboardCell: CollectionViewSlantedCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var imageHeight: CGFloat {
        return (moviePoster?.image?.size.height) ?? 0.0
    }
    var imageWidth: CGFloat {
        return (moviePoster?.image?.size.width) ?? 0.0
    }
    func offset(_ offset: CGPoint) {
        moviePoster.frame = moviePoster.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
    var imageURL: URL? {
        didSet {
            self.moviePoster.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.ImageName.placeholder))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.allowsDefaultTighteningForTruncation = true
        titleLabel.textDropShadow()
        ratingLabel.textDropShadow()
    }
    
    func bind(cellViewModel: DashboardCellProtocol)  {
        self.titleLabel.text = cellViewModel.movieName
        self.ratingLabel.text = cellViewModel.movieRating
        self.imageURL = cellViewModel.movieImageURL
    }
    
    func alignLabelAngle(collectionView: UICollectionView) {
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            self.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
            self.titleLabel.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
            self.ratingLabel.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }
    }
}


struct DashboardCellViewModel: DashboardCellProtocol {
    var movieImageURL: URL?
    @Capitalized var movieName: String
    @Capitalized var movieRating: String
    
    init(moviesListModel: Movies?) {
        if let movieURL = moviesListModel?.posterPath {
            self.movieImageURL = URL(string: Constants.WebService.largeImage + movieURL)
        }
        self.movieName = moviesListModel?.title ?? ""
        self.movieRating = Constants.MovieRating.text + String(describing: moviesListModel?.voteAverage ?? 0)
    }
}
