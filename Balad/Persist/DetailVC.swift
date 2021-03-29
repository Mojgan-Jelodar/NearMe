//
//  DetailVC.swift
//  Balad
//
//  Created by mozhgan on 3/28/21.
//

import UIKit

protocol P2VDetailProtocol: class {
    func show(photos: Photos)
    func show(items: Items)
    func show(error: Error)
}

final class DetailVC: UIViewController {

    private(set) var item: Items!
    private(set) var photos: Photos?
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

    required init(item: Items) {
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
        presenter?.show(items: item)
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.tips.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tipsReuseIdentifier, for: indexPath) as! TipCell
        cell.configCell(tip: item.tips[indexPath.row])
        return cell
    }
}

extension DetailVC: P2VDetailProtocol {
    func show(photos: Photos) {
        self.photos = photos
        self.galleryCollectionView.reloadData()
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = photos.count ?? 0
    }

    func show(items: Items) {
        lblName.text = item.venue?.name
        lblRating.text = "\(item.venue?.rating ?? 0.0)"
        lblAddress.text = item.venue?.location?.formattedAddress.joined(separator: ",")
        lblDistance.text = "\(item.venue?.location?.distance ?? 0)"
        lblPhone.text = "\(items.venue?.contact?.formattedPhone ?? "-")"
        lblHours.text = "\(items.venue?.hours?.status ?? "-")"
        lblTipCount.text = "\(items.venue?.stats?.tipCount ?? 0)"
        lblChechInCount.text = "\(items.venue?.stats?.checkinsCount ?? 0)"
        lblUserCount.text = "\(items.venue?.stats?.usersCount ?? 0)"
    }

    func show(error: Error) {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosReuseIdentifier, for: indexPath) as! PhotoViewCell
        cell.configCell(photo: photos!.items[indexPath.row])
        return cell
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
