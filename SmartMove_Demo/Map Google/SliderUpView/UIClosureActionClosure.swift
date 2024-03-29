//
//  UIClosureActionClosure.swift
//  SmartMove_Demo
//
//  Created by Валерий Мельников on 11.10.2019.
//  Copyright © 2019 Valerii Melnykov. All rights reserved.
//

import UIKit

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIButton {
    func onTap(_ closure: @escaping ()->()) {
        self.addAction(for: .touchUpInside, closure)
    }
}
