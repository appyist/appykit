import UIKit

public enum ViewManagerBehavior: Equatable {
    case none
    case view(StatableBehavior)
}

public func ==(lhs: ViewManagerBehavior, rhs: ViewManagerBehavior) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none): return true
    case (.view(let lName), .view(let rName)): return lName == rName
    default: return false
    }
}

public class ViewManager {
    
    // MARK: - Variables
    var viewStore: [String : UIView]
    fileprivate let queue = DispatchQueue(label: "ist.clapper.viewManager.queue")
    
    private lazy var containerView: UIView = {
        let view = PassthroughView(frame: .zero)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        
        return view
    }()
    let view: UIView
    fileprivate(set) var currentBehavior: ViewManagerBehavior = .none
    fileprivate(set) var lastBehavior: ViewManagerBehavior = .none
    
    
    // MARK: - Initializers
    init(view: UIView, behaviors: [String : UIView]?) {
        self.view = view
        viewStore = behaviors ?? [String: UIView]()
    }
    
    convenience init(view: UIView) {
        self.init(view: view, behaviors: nil)
    }
    
    
    // MARK: - Functions
    func view(for behavior: StatableBehavior) -> UIView? {
        return viewStore[behavior.rawValue]
    }
    
    func add(view: UIView, for behavior: StatableBehavior) {
        viewStore[behavior.rawValue] = view
    }
    
    func removeView(for behavior: StatableBehavior) {
        viewStore[behavior.rawValue] = nil
    }
    
    func transition(to behavior: ViewManagerBehavior, animated: Bool = true, completion: VoidCompletion? = nil) {
        lastBehavior = behavior
        
        queue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if behavior == strongSelf.currentBehavior {
                return
            }
            
            strongSelf.queue.suspend()
            strongSelf.currentBehavior = behavior
            
            let innerCompletion: () -> () = {
                strongSelf.queue.resume()
                completion?()
            }
            
            DispatchQueue.main.sync {
                switch behavior {
                case .none:
                    strongSelf.hideAllViews(animated: animated, completion: innerCompletion)
                case .view(let keyOfView):
                    strongSelf.showView(for: keyOfView, animated: animated, completion: innerCompletion)
                }
            }
        }
    }
    
    fileprivate func showView(for behavior: StatableBehavior, animated: Bool, completion: VoidCompletion? = nil) {
        containerView.frame = view.bounds
        view.addSubview(containerView)
        
        let store = viewStore
        
        if let newView = store[behavior.rawValue] {
            newView.alpha = animated ? 0.0 : 1.0
            let insets = (newView as? StatefulPlaceholderView)?.placeholderViewInsets() ?? UIEdgeInsets()
            
            /// Add new view with Autolayout
            newView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(newView)
            
            let metrics = ["top": insets.top, "bottom": insets.bottom, "left": insets.left, "right": insets.right]
            let views = ["view": newView]
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-left-[view]-right-|", options: [], metrics: metrics, views: views)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|", options: [], metrics: metrics, views: views)
            containerView.addConstraints(hConstraints)
            containerView.addConstraints(vConstraints)
        }
        
        let animations: () -> () = {
            if let newView = store[behavior.rawValue] {
                newView.alpha = 1.0
            }
        }
        
        let animationCompletion: (Bool) -> () = { _ in
            for(key, view) in store {
                if !(key == behavior.rawValue) {
                    view.removeFromSuperview()
                }
            }
            completion?()
        }
        
        animateChanges(animated: animated, animations: animations, completion: animationCompletion)
    }
    
    fileprivate func hideAllViews(animated: Bool, completion: VoidCompletion? = nil) {
        let store = viewStore
        
        let animations: () -> () = {
            for(_, view) in store {
                view.alpha = 0.0
            }
        }
        
        let animationCompletion: (Bool) -> () = { [weak self] _ in
            for(_, view) in store {
                view.removeFromSuperview()
            }
            
            /// Remove the containnerView
            self?.containerView.removeFromSuperview()
            completion?()
        }
        
        animateChanges(animated: animated, animations: animations, completion: animationCompletion)
    }
    
    fileprivate func animateChanges(animated: Bool, animations: @escaping () -> (), completion: ((Bool) -> Void)?) {
        if animated {
            UIView.animate(withDuration: 0.15, animations: animations, completion: completion)
        }else {
            completion?(true)
        }
    }
    
    
    // MARK: - Subscripting
    subscript(behavior: StatableBehavior) -> UIView? {
        get {
            return view(for: behavior)
        }
        set(newValue) {
            if let view = newValue {
                add(view: view, for: behavior)
            }else {
                removeView(for: behavior)
            }
        }
    }
}

fileprivate class PassthroughView: UIView {
    fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if !view.isHidden && view.alpha > 0 && view.isUserInteractionEnabled && view.point(inside: convert(point, to: view), with:event) {
                return true
            }
        }
        return false
    }
}
