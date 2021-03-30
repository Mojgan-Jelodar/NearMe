//
//  DetailVC.swift
//  Balad
//
//  Created by mozhgan on 3/28/21.
//

import UIKit

protocol P2VDetailProtocol: class {
    func show(photos: [Photo])
    func show(tips: [Comment])
    func show(item: Venue)
    func show(error: Error)
}

final class DetailVC: UIViewController {

    private(set) var item: Venue!
    private let photosReuseIdentifier = "\(PhotoViewCell.self)"
    private let tipsReuseIdentifier = "\(TipCell.self)"
    private let sectionInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    var presenter: V2PDetailProtocol?

    @IBOutlet weak var galleryCollectionView: UICollectionView! {
        didSet {
            galleryCollectionView.register(UINib(nibName: photosReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: photosReuseIdentifier)
            galleryCollectionView.alwaysBounceHorizontal = true
            galleryCollectionView.isPagingEnabled = true
            galleryCollectionView.dataSource = self
            galleryCollectionView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.hidesForSinglePage = true
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblChechInCount: UILabel!
    @IBOutlet weak var lblTipCount: UILabel!
    @IBOutlet weak var lblUserCount: UILabel!
    @IBOutlet weak var tipsTableView: UITableView! {
        didSet {
            tipsTableView.register(UINib(nibName: tipsReuseIdentifier, bundle: nil), forCellReuseIdentifier: tipsReuseIdentifier)
            tipsTableView.dataSource = self
        }
    }
    deinit {
        print("Deinit was called :\(DetailVC.self)")
    }

    required init(item: Venue) {
        super.init(nibName: "\(DetailVC.self)", bundle: nil)
        self.item = item
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension DetailVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.show(item: item)
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.tips.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tipsReuseIdentifier, for: indexPath) as? TipCell
        cell?.configCell(tip: self.presenter!.tips[indexPath.row])
        return cell ?? UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: tipsReuseIdentifier)
    }
}

extension DetailVC: P2VDetailProtocol {
    func show(photos: [Photo]) {
        self.galleryCollectionView.reloadData()
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = photos.count
    }

    func show(tips: [Comment]) {
        self.tipsTableView.reloadData()
    }

    func show(item: Venue) {
        lblName.text = item.name
        lblRating.text = "\(item.rating)"
        lblAddress.text = item.location?.formattedAddress.joined(separator: ",")
        lblDistance.text = "\(item.location?.distance ?? 0)"
        lblPhone.text = "\(item.contact?.formattedPhone ?? "-")"
        lblHours.text = "\(item.hours?.isOpen ?? false ? "is open" : "is closed" )"
        lblTipCount.text = "\(item.stats?.tipCount ?? 0)"
        lblChechInCount.text = "\(item.stats?.checkinsCount ?? 0)"
        lblUserCount.text = "\(item.stats?.usersCount ?? 0)"
    }

    func show(error: Error) {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosReuseIdentifier, for: indexPath) as? PhotoViewCell
        cell?.configCell(photo: presenter!.photos[indexPath.row])
        return cell ?? PhotoViewCell()
    }

}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = sectionInsets.left + sectionInsets.right
        let itemWidth = collectionView.bounds.size.width - marginsAndInsets
        let itemHeight = collectionView.bounds.size.height - sectionInsets.top - sectionInsets.bottom
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
    }
}
