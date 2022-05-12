//
//  HostingController.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

// Source: - https://stackoverflow.com/questions/57063142/swiftui-status-bar-color

import SwiftUI

public final class HostingController: UIHostingController<AnyView> {

    var statusBarStyle = UIStatusBarStyle.default

    //UIKit seems to observe changes on this, perhaps with KVO?
    //In any case, I found changing `statusBarStyle` was sufficient
    //and no other method calls were needed to force the status bar to update
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }

    public init<T: View>(wrappedView: T) {
        // This observer is necessary to break a dependency cycle - without it
        // onPreferenceChange would need to use self but self can't be used until
        // super.init is called, which can't be done until after onPreferenceChange is set up etc.
        let observer = Observer()

        let observedView = AnyView(wrappedView.onPreferenceChange(StatusBarStyleKey.self) { style in
            observer.value?.statusBarStyle = style
        })

        super.init(rootView: observedView)
        observer.value = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        // We aren't using storyboards, so this is unnecessary
        assertionFailure("Unavailable")
        return nil
    }
}

extension HostingController {

    private class Observer {
        weak var value: HostingController?
        init() {}
    }
}
