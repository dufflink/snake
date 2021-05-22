//
//  SView.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

@IBDesignable class SView: UIControl {
    
    private var forceTouchIsHandled = false
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibIfAvailable()
        
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibIfAvailable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewDidLoad()
    }
    
    // MARK: - Builder Properties
    
    @IBInspectable var isResponsive: Bool = false {
        didSet {
            if !isResponsive {
                updateState(toHighlighted: false)
                forceTouchIsHandled = false
            }
        }
    }
    
    @IBInspectable var pressedAlpha: CGFloat = 0.25
    
    @IBInspectable var cornersRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let value = layer.shadowColor else {
                return nil
            }
            
            return UIColor(cgColor: value)
        } set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowAlpha: CGFloat {
        get {
            return CGFloat(layer.shadowOpacity)
        } set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let value = layer.borderColor else {
                return nil
            }
            
            return UIColor(cgColor: value)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderThickness: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    // MARK: - User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard isResponsive else {
            return
        }
        
        performStateSwitching(toHighlighted: true, withAnimation: false)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let firstTouch = touches.first, isResponsive else {
            return
        }
        
        let touchLocation = firstTouch.location(in: self)
        let isInternalTouch = bounds.contains(touchLocation)
        
        performStateSwitching(toHighlighted: isInternalTouch, withAnimation: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard isResponsive else {
            return
        }
        
        performStateSwitching(toHighlighted: false, withAnimation: true)
        forceTouchIsHandled = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard isResponsive else {
            return
        }
        
        performStateSwitching(toHighlighted: false, withAnimation: true)
        forceTouchIsHandled = false
    }
    
    // MARK: - Delegating Functions
    
    func getParentNib() -> UINib? {
        return nil
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        isExclusiveTouch = true
    }
    
    func updateState(toHighlighted: Bool) {
        alpha = toHighlighted ? pressedAlpha : 1
        transform = toHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
    }
    
    // MARK: - Private Functions
    
    private func loadNibIfAvailable() {
        guard let fillingView = getParentNib()?.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        fillingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fillingView)
        
        NSLayoutConstraint.activate([
            fillingView.topAnchor.constraint(equalTo: topAnchor),
            fillingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fillingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fillingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func performStateSwitching(toHighlighted: Bool, withAnimation: Bool) {
        let duration: TimeInterval = withAnimation ? 0.5 : 0
        
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction], animations: {
            self.updateState(toHighlighted: toHighlighted)
        })
    }
    
}

