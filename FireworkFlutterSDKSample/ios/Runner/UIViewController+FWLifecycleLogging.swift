//
//  UIViewController+FWLifecycleLogging.swift
//
//  Logs lifecycle events for FireworkVideo view controllers via method swizzling.
//

import Foundation
import UIKit
import FireworkVideo

extension UIViewController {
    /// The FireworkVideo view controllers whose lifecycle events we want to log.
    private static let loggedViewControllerClasses: [UIViewController.Type] = [
        StoryBlockViewController.self,
        VideoFeedViewController.self,
        PlayerDeckFeedViewController.self,
        CircleStoryViewController.self,
    ]

    /// `true` when this view controller is (or subclasses) one of the
    /// FireworkVideo view controllers in `loggedViewControllerClasses`.
    private var shouldLogLifecycle: Bool {
        UIViewController.loggedViewControllerClasses.contains { self.isKind(of: $0) }
    }

    static func swizzleFireworkLifecycleLogging() {
        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.viewDidLoad),
            customSelector: #selector(UIViewController.fwlog_viewDidLoad)
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.viewWillAppear(_:)),
            customSelector: #selector(UIViewController.fwlog_viewWillAppear(_:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.viewDidAppear(_:)),
            customSelector: #selector(UIViewController.fwlog_viewDidAppear(_:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.viewWillDisappear(_:)),
            customSelector: #selector(UIViewController.fwlog_viewWillDisappear(_:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.viewDidDisappear(_:)),
            customSelector: #selector(UIViewController.fwlog_viewDidDisappear(_:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.beginAppearanceTransition(_:animated:)),
            customSelector: #selector(UIViewController.fwlog_beginAppearanceTransition(_:animated:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.willMove(toParent:)),
            customSelector: #selector(UIViewController.fwlog_willMove(toParent:))
        )

        FWSSwizzle.swizzleSelector(
            cls: self,
            originalSelector: #selector(UIViewController.didMove(toParent:)),
            customSelector: #selector(UIViewController.fwlog_didMove(toParent:))
        )
    }

    @objc func fwlog_viewDidLoad() {
        fwlog_viewDidLoad()
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] viewDidLoad: \(type(of: self))")
        }
    }

    @objc func fwlog_viewWillAppear(_ animated: Bool) {
        fwlog_viewWillAppear(animated)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] viewWillAppear: \(type(of: self))")
        }
    }

    @objc func fwlog_viewDidAppear(_ animated: Bool) {
        fwlog_viewDidAppear(animated)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] viewDidAppear: \(type(of: self))")
        }
    }

    @objc func fwlog_viewWillDisappear(_ animated: Bool) {
        fwlog_viewWillDisappear(animated)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] viewWillDisappear: \(type(of: self))")
        }
    }

    @objc func fwlog_viewDidDisappear(_ animated: Bool) {
        fwlog_viewDidDisappear(animated)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] viewDidDisappear: \(type(of: self))")
        }
    }

    @objc func fwlog_beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        fwlog_beginAppearanceTransition(isAppearing, animated: animated)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] beginAppearanceTransition(isAppearing: \(isAppearing)): \(type(of: self))")
        }
    }

    @objc func fwlog_willMove(toParent parent: UIViewController?) {
        fwlog_willMove(toParent: parent)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] willMove(toParent: \(parent == nil ? "nil" : "set")): \(type(of: self))")
        }
    }

    @objc func fwlog_didMove(toParent parent: UIViewController?) {
        fwlog_didMove(toParent: parent)
        if shouldLogLifecycle {
            debugPrint("[FWLifecycle][FireworkVideo][VC Lifecycle] didMove(toParent: \(parent == nil ? "nil" : "set")): \(type(of: self))")
        }
    }
}
