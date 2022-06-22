//
//  HomeTableViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView:UICollectionView!
    var homeViewModel : HomeViewModel?
    var onClickCell:((Int) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(nibWithCellClass: HomeCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
//extension HomeTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return homeViewModel?.arrTiles.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withClass: HomeCollectionViewCell.self, for: indexPath)
//        cell.tileTiles.text = homeViewModel?.homeTileTitles[indexPath.item]
//        cell.tileImage.image = UIImage(named :homeViewModel?.homeTileImages[indexPath.item] ?? "")
//        cell.tilebackground.backgroundColor = homeViewModel?.homeTileColors[indexPath.item]
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        onClickCell?(indexPath.item)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width:  (collectionView.bounds.width * 0.44), height: 184)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
//    }
//}
