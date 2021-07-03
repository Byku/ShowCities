//
//  ObservedViewController.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import UIKit
import Combine

enum LifecycleEvent: String {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
}

class ObservedViewController: UIViewController {
    
    public let lifecycleEvent = PassthroughSubject<LifecycleEvent, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lifecycleEvent.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleEvent.send(.viewWillAppear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycleEvent.send(.viewDidAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycleEvent.send(.viewWillDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycleEvent.send(.viewDidDisappear)
    }
}
