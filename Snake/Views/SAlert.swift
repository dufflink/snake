//
//  SAlert.swift
//  Snake
//
//  Created by Maxim Skorynin on 24.05.2021.
//

import UIKit

final class SAlert: SView {
    
    @IBOutlet private weak var popupView: SView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var acceptButton: MenuButton!
    @IBOutlet private weak var cancelButton: MenuButton!
    
    @IBOutlet private weak var equalWidth: NSLayoutConstraint!
    
    private let animationDuration: TimeInterval = 0.25
    private var acceptAction: (() -> Void)?
    
    // MARK: - Life Cycle
    
    init(title: String, acceptAction: (() -> Void)? = nil) {
        super.init(frame: .null)
        titleLabel.text = title
        self.acceptAction = acceptAction
        
        if acceptAction == nil {
            equalWidth.isActive = false
            acceptButton.removeFromSuperview()
            
            cancelButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -8).isActive = true
            cancelButton.textLabel = "OK"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getParentNib() -> UINib? {
        return UINib(nibName: "SAlert", bundle: nil)
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func cancelButtonDidPress(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func acceptButtonDidPress(_ sender: Any) {
        acceptAction?()
        dismiss()
    }
    
    // MARK: - Functions
    
    func present() {
        guard superview == nil, let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        currentWindow.addSubviewWithConstraints(self)
        updateState(toObserved: false)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut) {
            self.updateState(toObserved: true)
        }
    }
    
    func dismiss(completion: @escaping () -> Void = { }) {
        guard superview != nil else {
            return
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.removeFromSuperview()
            completion()
        })
    }
    
    private func updateState(toObserved: Bool) {
        alpha = toObserved ? 1 : 0
        popupView.transform = toObserved ? .identity : .init(translationX: 0, y: 20)
    }
    
}
