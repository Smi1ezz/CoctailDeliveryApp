//
//  UICollectionViewWithComlition.swift
//  CocktailDeliveryApp
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

final class UICollectionViewWithComletion: UICollectionView {
    private var reloadDataCompletionBlock: (() -> Void)?

    override func layoutSubviews() {
      super.layoutSubviews()

      reloadDataCompletionBlock?()
      reloadDataCompletionBlock = nil
    }

    func reloadDataWith(completion: @escaping () -> Void) {
        reloadDataCompletionBlock = completion
        self.reloadData()
    }
}
