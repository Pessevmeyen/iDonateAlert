//
//  iDonateAlert.swift
//  iDonateAlert
//
//  Created by Rashid Ramazanov on 10.02.2023.
//

import Foundation
import UIKit

public final class iDonateAlert {
    // swiftlint:disable nesting
    public struct Button {
        var title: String
        var type: Button.ActionType
        var defaultTitleColor: UIColor?
        var action: AlertAction?
        var borderColor: UIColor?
        var backgroundColor: UIColor?

        public init(
            title: String,
            type: Button.ActionType,
            titleColor: UIColor? = .primary,
            borderColor: UIColor? = .clear,
            backgroundColor: UIColor? = .clear,
            action: AlertAction? = nil
        ) {
            self.title = title
            self.type = type
            defaultTitleColor = titleColor
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.action = action
        }

        public enum ActionType {
            case `default`, destructive, custom
        }

        public typealias AlertAction = (Button) -> Void
    }

    // swiftlint:enable nesting

    var icon: UIImage?
    var title: String
    var message: String
    var titleFont: UIFont?
    var buttons: [Button] = []
    var attributedMessage: NSAttributedString?
    var messageTapHandler: (() -> Void)?

    public init(
        icon: UIImage? = nil,
        title: String,
        message: String,
        titleFont: UIFont? = nil,
        attributedMessage: NSAttributedString? = nil,
        messageTapHandler: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.attributedMessage = attributedMessage
        self.messageTapHandler = messageTapHandler
    }

    public func addAction(_ button: Button) {
        buttons.append(button)
    }

    public func present(over viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let controller = UIStoryboard(name: "Alert", bundle: .module)
            .instantiateInitialViewController() as? AlertViewController else {
            fatalError("AlertViewController could not be initialized")
        }
        controller.alertIcon = icon
        controller.alertTitle = title
        controller.alertMessage = message
        controller.titleFont = titleFont
        controller.alertButtons = buttons
        controller.attributedMessage = attributedMessage
        controller.messageTapHandler = messageTapHandler
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        viewController.present(controller, animated: animated, completion: completion)
    }
}
