//
//  CauroselHeaderView.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CarouselHeaderView: UICollectionReusableView {

    // MARK: - Properties
    var pageControl: LineCarouselControl = LineCarouselControl()
    var collectionView: UICollectionView!
    var collectionViewDataSource: CollectionViewDataSource<CarouselCollectionViewCell>?
    var resultsHandler: ResultsDataHandler?
    override var reuseIdentifier: String? {
        return "PersonHeaderCell"
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configure() {
        backgroundColor = .green
        setUpCollectionView()
        setUpView()
    }

    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: createFlowLayout())
        collectionView.backgroundColor = .yellow
        registerCells()
        setUpDataSource()
        guard let dataSource = collectionViewDataSource else {return}
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    private func setUpDataSource() {
        guard let handler = resultsHandler else {return}
        collectionViewDataSource = CollectionViewDataSource(resultsHandler: handler, reuseId: "CarouselCollectionViewCell")
    }

    private func registerCells() {
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
    }

    private func setUpView() {
        self.add(collectionView) {
            $0.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        }
        self.add(pageControl) {
            $0.delegate = self
            $0.numberOfPages = 4
            $0.anchor(top: collectionView.bottomAnchor, leading: collectionView.leadingAnchor, bottom: bottomAnchor, trailing: collectionView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: bounds.width, height: 20))
        }
    }

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

}

extension CarouselHeaderView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("*** selected \(indexPath.row)")
      }
}

extension CarouselHeaderView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: self.collectionView.bounds.width - 20, height: self.collectionView.bounds.height - 20)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
       }


}

extension CarouselHeaderView: LineCarouselControlProtocol {

    func didSelectLineAt(_ index: Int) {
        //move to the correct cell here
        print("selected \(index)")
        guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) else {return}
        print("got it")
    }

}



