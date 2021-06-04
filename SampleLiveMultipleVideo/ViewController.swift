//
//  ViewController.swift
//  SampleLiveMultipleVideo
//
//  Created by NotSmall on 4/6/2564 BE.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = MainViewModel()
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width = self.view.frame.width / 2
        let row = Double(viewModel.liveVideoChannels.count) / 2
        let collectionHeight = Double(width) * row.rounded(.up)
        collectionViewHeightConstraint.constant = CGFloat(collectionHeight)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.liveVideoChannels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let liveUrl = viewModel.liveVideoChannels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveVideoCollectionViewCell.identifier, for: indexPath) as! LiveVideoCollectionViewCell
        cell.configure(url: liveUrl)
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let cellWidth = (width / 2) - 8
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
}

