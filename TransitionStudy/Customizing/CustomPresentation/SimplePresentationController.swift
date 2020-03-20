//
//  SimplePresentationController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/20.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SimplePresentationController: UIPresentationController {
    /*
        Custom Presentation
     1. 쿠팡의 그 안내 팝업 같은 Custom Presentation 구현
     --> 내용이 어렵고 많으니 강의를 한번 더 봐야함
     2. 구현을 완료했으면 segue에서 변경해줘야함
     --> CustomPresentationViewController에서 변경
     */
    
    // dimming view 추가
    let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // 닫기 버튼 및 상단에 추가하도록 제약 생성
    let closeButton = UIButton(type: .custom)
    var closeButtonTopConstraint : NSLayoutConstraint?
    
    // 버튼 애니메이션 비정상 현상 해결을 위한 dummy view 추가
    let workaroundView = UIView()
    
    // 지정 생성자 OVERRIDE
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        // 버튼 생성
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false       // 프로토타이핑 제약 제거
    }
    
    // 창 닫기 기능
    @objc func dismiss(){
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    // 프레임 설정
    override var frameOfPresentedViewInContainerView: CGRect{
        print(String(describing: type(of: self)), #function)
        
        guard var frame = containerView?.frame else {return .zero}
        
        frame.origin.y = frame.size.height / 2
        frame.size.height = frame.size.height / 2
        
        return frame
    }
    
    // 애니메이션에 필요한 속성 구현. 이부분이 제일 중요함.
    override func presentationTransitionWillBegin() {
        print(String(describing: type(of: self)), #function)
        
        // Container View 바인딩
        guard let containerView = containerView else{fatalError()}
        
        dimmingView.alpha = 0.0
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        // dummy view 추가 (버튼 애니메이션 비정상 해결용)
        workaroundView.frame = dimmingView.bounds
        workaroundView.isUserInteractionEnabled = false
        containerView.insertSubview(workaroundView, aboveSubview: dimmingView)
        
        // 닫기 버튼 추가 및 제약 생성
        containerView.addSubview(closeButton)
        closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -80)
        closeButtonTopConstraint?.isActive = true
        containerView.layoutIfNeeded()
        closeButtonTopConstraint?.constant = 60
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
            return
        }
        
        // 애니메이션 구현
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1.0
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
        }, completion: nil)
    }
    
    // presentation 완료 후 호출
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print(String(describing: type(of: self)), #function)
    }
    
    // dismissal 시작 시 호출. 여기도 중요함.
    override func dismissalTransitionWillBegin() {
        print(String(describing: type(of: self)), #function)
        
        closeButtonTopConstraint?.constant = -80
        
        guard let coordinator = presentedViewController.transitionCoordinator else{
            dimmingView.alpha = 0.0
            presentingViewController.view.transform = CGAffineTransform.identity
            containerView?.layoutIfNeeded()
            return
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0.0
            self.presentingViewController.view.transform = CGAffineTransform.identity
            self.containerView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print(String(describing: type(of: self)), #function)
    }
    
    override func containerViewWillLayoutSubviews() {
        print(String(describing: type(of: self)), #function)
        
        // frame update (화면 가로 전환 시 깨짐 현상 방지 방법 1)
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView!.bounds
    }
    
    override func containerViewDidLayoutSubviews() {
        print(String(describing: type(of: self)), #function)
    }
    
    // view will transition 을 활용한 깨짐 현상 방지 방법 2
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        presentingViewController.view.transform = CGAffineTransform.identity
        
        coordinator.animate(alongsideTransition: { (context) in
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
}
