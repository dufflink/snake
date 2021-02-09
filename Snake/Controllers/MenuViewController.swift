//
//  MenuViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 09.02.2021.
//

import UIKit

final class MenuViewController: UIViewController {
        
    @IBAction func startGameButtonDidPress(_ sender: Any) {
        guard let gameViewController = GameViewController.create(mode: .classic) else {
            return
        }
        
        gameViewController.modalPresentationStyle = .overFullScreen
        gameViewController.modalTransitionStyle = .crossDissolve
        
        present(gameViewController, animated: true)
    }
    
}
