//
//  MoviesTableViewCell.swift
//  TheMovieApp
//
//  Created by Nitz on 25/06/20.
//  Copyright © 2020 TM. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var bottomLineLabel: UILabel!
    
    let moviesVM = MoviesViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(movie: Results) {
        
        let readmoreFont = UIFont.systemFont(ofSize: 15.0)
        let readmoreFontColor = UIColor.blue
        DispatchQueue.main.async {
            self.overviewLabel.addTrailing(with: "... ", moreText: "Read more  ", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
        }
        
        baseView.layer.cornerRadius = 10.0
        posterImageView.layer.cornerRadius = 10.0
        votesLabel.layer.cornerRadius = 5.0
        votesLabel.layer.masksToBounds = true
        self.posterImageView.layer.masksToBounds = true
        bottomLineLabel.layer.cornerRadius = 5.0
        bottomLineLabel.layer.masksToBounds = true
        popularityLabel.layer.cornerRadius = 5.0
        popularityLabel.layer.masksToBounds = true
        
        overviewLabel.text = movie.overview ?? ""
        titleLabel.text = movie.title ?? ""
        let locale = NSLocale.autoupdatingCurrent
        let code = movie.original_language ?? ""
        let language = locale.localizedString(forLanguageCode: code)!
        languageLabel.text = language
        releaseDateLabel.text = movie.release_date?.toDate(withFormat: "yyyy-MM-dd")
        popularityLabel.text = String(format:"%.1f", movie.popularity ?? 0)
        votesLabel.text = moviesVM.formatNumber(movie.vote_count ?? 0) + " Votes"
        
        if let posterUrl = movie.poster_path {
            let strUrl = NetworkingConstants.baseUrlImage+posterUrl
            let url = URL(string: strUrl)
            posterImageView.kf.setImage(with: url)
        }
    }
}

extension UILabel {
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}
