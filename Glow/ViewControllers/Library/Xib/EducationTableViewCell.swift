//
//  EducationTableViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var lessonsSection: EducationLessonList? {
        didSet {
            setupUI()
        }
    }
    
    var onClickBookmarks:(() -> ())?
    var onClickFavourite:((EducationLesson?) -> ())?
    var onClickLesson:((EducationLesson) -> ())?
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorateUI()
        collectionView.register(nibWithCellClass: EducationCollectionViewCell.self)
    }
    
    private func decorateUI() {
        headingLabel.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        subtitleLabel.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        seeAllButton.setUp(title: "See all".localized(), font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.themeColor, bgColor: .clear)
    }
    
    func setupUI() {
        headingLabel.text = lessonsSection?.name
        subtitleLabel.text = lessonsSection?.description
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension EducationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lessonsSection?.educationLessons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: EducationCollectionViewCell.self, for: indexPath)
        let object = self.lessonsSection?.educationLessons?[indexPath.item]
        cell.lesson = object
        cell.onClickBookmarks = {
            self.onClickBookmarks?()
        }
        cell.onClickFavourite = {
            self.onClickFavourite?(object)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  (collectionView.bounds.width * 0.9), height: Constant.educationCollectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.educationCollectionCellLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onClickLesson?(self.lessonsSection?.educationLessons?[indexPath.item] ?? EducationLesson())
    }
}
