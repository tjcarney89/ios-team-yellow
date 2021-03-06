///
/// NotificationModal.swift
///

import UIKit

class NotificationModal: UIView {
    
    let notification: Notification
    
    let acceptButton = UIButton()
    let denyButton = UIButton()
    let label = UILabel()
    
    var views: [UIView] {
        return [acceptButton, denyButton, label]
    }
    
    init(notification: Notification) {
        self.notification = notification
        super.init(frame: .zero)
        
        views.forEach(self.addSubview)
        views.forEach { $0.freeConstraints() }
        
        _ = label.then {
            $0.text = notification.displayText
            $0.textAlignment = .center
            // Anchors
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
            $0.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            $0.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
        
        _ = acceptButton.then {
            $0.setTitle("ACCEPT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .blue
            // Accept Invitation
            $0.addTarget(self, action: #selector(self.acceptInvitation(_:)), for: UIControlEvents.touchUpInside)
            // Anchors
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
            $0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        }
        
        _ = denyButton.then {
            $0.setTitle("DENY", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .blue
            // Deny Invitation
            $0.addTarget(self, action: #selector(self.denyInvitation(_:)), for: UIControlEvents.touchUpInside)
            // Anchors
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        }
    }
    
    func acceptInvitation(_ sender: UIButton!) {
        FirebaseManager.shared.respondToInvitation(id: notification.id, accept: true)
        dismissNotification()
    }
    
    func denyInvitation(_ sender: UIButton!) {
        FirebaseManager.shared.respondToInvitation(id: notification.id, accept: false)
        dismissNotification()
    }
    
    func dismissNotification() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
