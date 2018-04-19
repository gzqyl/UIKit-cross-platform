//
//  UIScreen.swift
//  UIKit
//
//  Created by Chris on 08.08.17.
//  Copyright © 2017 flowkey. All rights reserved.
//

public class UIScreen {
    public let bounds: CGRect
    public let scale: CGFloat

    init(bounds: CGRect, scale: CGFloat) {
        self.bounds = bounds
        self.scale = scale
    }
}

public extension UIScreen {
    public static let main: UIScreen = {
        #if !DEBUG
        // Crash in production when accessing this without a glRenderer.
        if SDL.glRenderer == nil {
            preconditionFailure("Tried to get UIScreen.main dimensions, but no glRenderer exists")
        }
        #endif

        // Otherwise a fallback value e.g. in XCTests, so we don't need to initialize all of SDL:
        let size = SDL.glRenderer?.size ?? CGSize(width: 1024, height: 768)

        return UIScreen(
            bounds: CGRect(origin: .zero, size: size),
            scale: SDL.glRenderer?.scale ?? 2.0
        )
    }()
}
