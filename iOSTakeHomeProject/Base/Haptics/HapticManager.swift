//
//  HapticManager.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 22/09/2022.
//

import Foundation
import UIKit

fileprivate final class HapticsManger {
    
    static let shared = HapticsManger()
    private let feedback = UINotificationFeedbackGenerator()
    private init() { }
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        // FeedbacType:
        // 0 - success
        // 1 - warning
        // 2 - error
        
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaulKeys.hapticsEnabled) {
        HapticsManger.shared.trigger(notification)
    }
}
