//
//  ViewController.swift
//  BiteSized
//
//  Created by Prabhdeep Singh on 04/09/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var cardsView: KolodaView!
    @IBOutlet weak var cardsProgressBar: UIProgressView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var progress = Progress(totalUnitCount: 0)
    var cardDataViewModel = DataViewModel()
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsView.delegate = self
        cardsView.dataSource = self
        
        setupProgressView()
        
        cardDataViewModel.retrieveData()
        cardDataViewModel.dataArray.bind { [weak self] (dataComponents) in
            DispatchQueue.main.async {
                self?.cardsView.reloadData()
                self?.progress.totalUnitCount = Int64(dataComponents.count)
            }
        }
        
    }
    
    //MARK: View Setup
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func setupProgressView() {
        cardsProgressBar.progress = 0.0
        progress.completedUnitCount = 0
        cardsProgressBar.progress = 0.0
        cardsProgressBar.layer.cornerRadius = 10
        cardsProgressBar.clipsToBounds = true
        cardsProgressBar.layer.sublayers![1].cornerRadius = 10
        cardsProgressBar.subviews[1].clipsToBounds = true
    }
    
    //MARK: Actions
    @IBAction func refreshAction(_ sender: UIButton) {
        self.cardsView.resetCurrentCardIndex()
        resetProgress()
    }
    
    @IBAction func undoAction(_ sender: UIButton) {
        self.cardsView.revertAction()
        decreseProgress()
    }
    
    //MARK: Private Functions
    private func increaseProgress() {
        
        progress.completedUnitCount += 1
        cardsProgressBar.setProgress(Float(progress.fractionCompleted), animated: true)
        
        
        if progress.completedUnitCount == self.cardDataViewModel.dataArray.value.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.resetProgress()
            }
        }
        
    }
    
    private func resetProgress() {
        progress.completedUnitCount = 0
        cardsProgressBar.setProgress(Float(progress.fractionCompleted), animated: true)
    }
    
    private func decreseProgress() {
        guard progress.completedUnitCount > 0 else {return}
        progress.completedUnitCount -= 1
        cardsProgressBar.setProgress(Float(progress.fractionCompleted), animated: true)
    }
    
    
}

//MARK: Koloda Extension
extension ViewController: KolodaViewDataSource, KolodaViewDelegate {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return cardDataViewModel.dataArray.value.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = CardView()
        view.idLabel.text = "Card No: \(cardDataViewModel.dataArray.value[index].id)"
        view.descriptionLabel.text = cardDataViewModel.dataArray.value[index].text
        return view
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        //because reload Data does not work properly here
        koloda.resetCurrentCardIndex()
        //resetProgress()
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        increaseProgress()
    }
}

