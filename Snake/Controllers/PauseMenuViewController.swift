//
//  PauseMenuViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 10.05.2021.
//

import UIKit

protocol PauseMenuViewControllerDelegate: AnyObject {
    
    func restartButtonDidPress(onPause: Bool)
    
    func exitButtonDidPress(onPause: Bool)
    
    func resumeButtonDidPress()
    
}

final class PauseMenuViewController: UIViewController {
    
    @IBOutlet private weak var resumeButton: MenuButton!
    @IBOutlet private weak var scoreLabel: SLabel!
    
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    weak var delegate: PauseMenuViewControllerDelegate?
    
    private var score = 0
    private var onPause = false
    
    private let gameCenterHelper = GameCenterHelper.shared
    
    // MARK: - Life Cycle

    static func instance(score: Int, onPause: Bool) -> PauseMenuViewController? {
        let storyboard = UIStoryboard(name: "PauseMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PauseMenuViewController") as? PauseMenuViewController
        
        controller?.score = score
        controller?.onPause = onPause
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func restartButtonDidPress(_ sender: Any) {
        delegate?.restartButtonDidPress(onPause: onPause)
    }
    
    @IBAction func exitButtonDidPress(_ sender: Any) {
        delegate?.exitButtonDidPress(onPause: onPause)
    }
    
    @IBAction func resumeButtonDidPress(_ sender: Any) {
        delegate?.resumeButtonDidPress()
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Functions
    
    private func configure() {
        resumeButton.isHidden = !onPause
        scoreLabel.text = String(score)
        
        if !onPause {
            sendScore()
        }
    }
    
    func sendScore() {
        scoreLabel.alpha = 0
        loadingView.startAnimating()
        
        gameCenterHelper.addScore(score, mode: Options.gameMode) { [weak self] error in
            self?.loadingView.stopAnimating()
            
            UIView.animate(withDuration: 0.25) {
                self?.scoreLabel.alpha = 1
            }
            
            if error == nil {
                SAlert(title: "Sorry we couldn't record your score. Want you resend it?") {
                    self?.sendScore()
                }.present()
            }
        }
    }
    
}
