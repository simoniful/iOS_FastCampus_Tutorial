//
//  TodayViewController.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit
import SnapKit

final class TodayViewController: UIViewController {

    let todayView = TodayView()
    
    override func loadView() {
        super.loadView()
        view = todayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayView.collectionView.delegate = self
        todayView.collectionView.dataSource = self
    }
}

extension TodayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayViewCell.identifier, for: indexPath) as? TodayViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayViewHeader.identifier, for: indexPath) as? TodayViewHeader else {
                    fatalError("Could not dequeue header")
                }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

extension TodayViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppDetailViewController()
        present(vc, animated: true, completion: nil)
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width - 32.0
        let height = 100.0
        return CGSize(width: width, height: height)
    }
}
