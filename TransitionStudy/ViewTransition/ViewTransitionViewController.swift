//
//  ViewTransitionViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/16.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class ViewTransitionViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redView: UIView!
    
    /*
        View Transition
     1. Container 안의 뷰 이동을 Transition을 통해 애니메이션 효과를 줄 수 있음
     2. 뷰 계층에 추가하거나 삭제하는 방식으로 Transition 구현 가능
     --> weak로 약한 참조가 되어있으므로 option에 showHideTransitionViews를 꼭 넣어야함
     --> View를 삭제하거나 생성하고 싶으면 completion closure에 구현하면 됨
     --> 이 경우 View의 hidden 속성을 제거해야함
     */
    
    // transition 활용 (1)
    @IBAction func startTransition1(_ sender: Any) {
        UIView.transition(with: containerView, duration: 1, options: [.transitionCurlUp], animations: {
            self.redView.isHidden = !self.redView.isHidden
            self.blueView.isHidden = !self.blueView.isHidden
        }, completion: nil)
    }
    
    // 또 다른 방법의 transition 활용 (2)
    @IBAction func startTransition2(_ sender: Any) {
        UIView.transition(from: redView, to: blueView, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews]) { (finished) in
            UIView.transition(from: self.blueView, to: self.redView, duration: 1, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // hidden 속성 제거 (2)
        blueView.isHidden = false
    }
}
