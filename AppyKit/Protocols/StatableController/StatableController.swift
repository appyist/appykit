import UIKit

public typealias VoidCompletion = (() -> Swift.Void)
public enum StatableBehavior: String {
    case content
    case loading
    case error
    case empty
}

public protocol StatableController: BackingViewProvider, ErrorPlaceholderDelegate {
    
    // MARK: - Properties
    var viewManager: ViewManager { get }
    var currentBehavior: StatableBehavior { get }
    var lastBehavior: StatableBehavior { get }
    
    var emptyStateStrings: (title: String, message: String) { get }
    var errorStateStrings: (title: String, message: String) { get }
    
    // MARK: - Custom Views
    var loadingView: UIView { get  }
    var errorView: UIView { get  }
    var emptyView: UIView { get }
    
    // MARK: - Functions
    
    /** Should be called in viewDidLoad(). */
    func setUpInitialViewBehavior(_ completion: VoidCompletion?)
    
    /** Should be called just before starting any loading operation. */
    func startLoadingContent(animated: Bool, completion: VoidCompletion?)
    
    /** Should be called after any loading operation. */
    func endLoadingContent(animated: Bool, error: Error?, completion: VoidCompletion?)
    
    /** Transition between behavior changes. */
    func transitionViewBehaviors(loading: Bool, error: Error?, animated: Bool, completion: VoidCompletion?)
    
    /** Returns true if there is content available in your controller. */
    func hasContentToPresent() -> Bool
    
    /** Gets called if there is avaible content to be presented and an error occured at the same time. */
    func handleErrorWhenContentAvailable(_ error: Error)
}
