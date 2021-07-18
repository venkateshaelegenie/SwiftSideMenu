//
//  FAPanel+Animations.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit


extension FAPanelController {
    
    
    
    //  Swap Center Panel
    
    internal func swapCenter(animated:Bool, FromVC fromVC: UIViewController?, withVC nextVC: UIViewController?){
        
        if fromVC != nextVC {
            
            if nextVC != nil {
                
                if !animated {
                    swap(fromVC, withVC: nextVC)
                }
                else {
                    swap(fromVC, withVC: nextVC)
                }
                
            }
        }
    }
    
    
    
    private func swap( _ fromVC: UIViewController?, withVC toVC: UIViewController?) {
        
        fromVC?.willMove(toParent: nil)
        fromVC?.view.removeFromSuperview()
        fromVC?.removeFromParent()
        loadCenterPanel()
        addChild(toVC!)
        centerPanelContainer.addSubview(toVC!.view)
        if tapView != nil {
            centerPanelContainer.bringSubviewToFront(tapView!)
        }
        toVC!.didMove(toParent: self)
    }
    
    
    
    private func performNativeTransition() {
        
        let transitionOption = configs.centerPanelTransitionType.transitionOption() as! UIView.AnimationOptions
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: transitionOption, animations: nil, completion: nil)
    }
    

    
    //  Loading of panels
    
    internal func loadCenterPanel() {
        
        centerPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        centerPanelVC!.view.frame = centerPanelContainer.bounds
        applyStyle(onView: centerPanelVC!.view)
    }
    
    
    
    internal func loadLeftPanel() {
        
        
        if leftPanelContainer.isHidden && leftPanelVC != nil {
            
            if leftPanelVC!.view.superview == nil {
                
                layoutSidePanelVCs()
                leftPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                applyStyle(onView: leftPanelVC!.view)
                leftPanelContainer.addSubview(leftPanelVC!.view)
            }
            leftPanelContainer.isHidden = false
        }
        else{
            print("left panel is empty")
        }
        
        if isLeftPanelOnFront {
            view.bringSubviewToFront(leftPanelContainer)
        }
        else {
            view.sendSubviewToBack(leftPanelContainer)
        }
    }
    
    
    
    
    internal func openLeft(animated: Bool, shouldBounce bounce:Bool) {
        
        if leftPanelVC != nil {
            centerPanelVC?.view.endEditing(true)
            
            state = .left
            loadLeftPanel()
            
            if isLeftPanelOnFront {
                slideLeftPanelIn(animated: animated)
            }
            else {
                slideCenterPanel(animated: animated, bounce: bounce)
                handleScrollsToTopForContainers(centerEnabled: false, leftEnabled: true, rightEnabled: false)
            }
        }
    }
    
    

    
    
    internal func openCenter(animated: Bool, shouldBounce bounce: Bool, afterThat completion: (() -> Void)?) {
        
        state = .center
        _ = updateCenterPanelSlidingFrame()
        if animated {
            animateCenterPanel(shouldBounce: bounce, completion: { (finished) in
                self.leftPanelContainer.isHidden = true
                completion?()
            })
        }
        else {
            updateCenterPanelContainer()
            leftPanelContainer.isHidden = true
            rightPanelContainer.isHidden = true
            completion?()
        }
        
        tapView?.alpha = 0.0

        handleScrollsToTopForContainers(centerEnabled: true, leftEnabled: false, rightEnabled: false)
    }
    
    
    
    private func slideCenterPanel(animated: Bool, bounce:Bool) {
        
        _ = updateCenterPanelSlidingFrame()
        if animated {
            animateCenterPanel(shouldBounce: bounce, completion: { (finished) in
            })
        }
        else {
            updateCenterPanelContainer()
        }
        handleTapViewOpacity()
    }

    
    internal func slideLeftPanelIn(animated: Bool) {

        if animated {

            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.leftPanelContainer.frame
                frame.origin.x = 0.0
                self.leftPanelContainer.frame = frame
                
            }, completion:{ (finished) in
                
            })
        }
        else {
            
            var frame = self.leftPanelContainer.frame
            frame.origin.x = 0.0
            self.leftPanelContainer.frame = frame
        }
        
        handleTapViewOpacity()
    }

    
    internal func slideLeftPanelOut(animated: Bool, afterThat completion: (() -> Void)?) {
        
        if animated {
            
            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.leftPanelContainer.frame
                frame.origin.x = -self.widthForLeftPanelVC
                self.leftPanelContainer.frame = frame
            
            }, completion:{ (finished) in
                self.state = .center
                completion?()
            })
        }
        else {
            
            var frame = leftPanelContainer.frame
            frame.origin.x = -widthForLeftPanelVC
            leftPanelContainer.frame = frame
            view.sendSubviewToBack(leftPanelContainer)
            state = .center
            completion?()
        }
        
        tapView?.alpha = 0.0

        handleScrollsToTopForContainers(centerEnabled: true, leftEnabled: false, rightEnabled: false)
    }

    
    
    private func updateCenterPanelContainer() {

        centerPanelContainer.frame = centeralPanelSlidingFrame
        if configs.pusheSidePanels {
            layoutSideContainers(withDuration: 0.0, animated: false)
        }
    }
    
    
    //  Hiding panels
    
    internal func hideCenterPanel() {
        centerPanelContainer.isHidden = true
        if centerPanelVC!.isViewLoaded {
            centerPanelVC!.view.removeFromSuperview()
        }
    }
    
    internal func unhideCenterPanel() {
        
        centerPanelContainer.isHidden = false
        if centerPanelVC!.view.superview == nil {
            
            centerPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            centerPanelVC!.view.frame = centerPanelContainer.bounds
            applyStyle(onView: centerPanelVC!.view)
            centerPanelContainer.addSubview(centerPanelVC!.view)
        }
    }
    
    
    //  Layout Containers & Panels
    
    
    internal func layoutSideContainers( withDuration: TimeInterval, animated: Bool) {

        var leftFrame: CGRect  = leftPanelContainer.frame

        if !isLeftPanelOnFront { leftFrame = view.bounds }
        
        if (configs.pusheSidePanels && !centerPanelHidden) {
            leftFrame.origin.x = centerPanelContainer.frame.origin.x - widthForLeftPanelVC
        }
        
        leftPanelContainer.frame = leftFrame
    }
    
    
    internal func layoutSidePanelVCs() {
        
        
        if let leftPanelVC = self.leftPanelVC {
            
            if leftPanelVC.isViewLoaded {
                
                var frame: CGRect  = leftPanelContainer.bounds
                if configs.resizeLeftPanel {
                    frame.size.width = widthForLeftPanelVC
                }
                leftPanelVC.view.frame = frame
            }
        }
    }
    
    
    internal func updateCenterPanelSlidingFrame() -> CGRect{
        
        var frame: CGRect  = view.bounds
        
        switch state {
            
        case .center:
            frame.origin.x = 0.0
            break
            
        case .left:
            
            if leftPanelPosition == .front {
                frame.origin.x = 0
            }
            else {
                frame.origin.x = widthForLeftPanelVC
            }
            
            break
            
       
        }
        
        centeralPanelSlidingFrame = frame
        return centeralPanelSlidingFrame
    }
    
    
    //  Handle Scrolling
    
    internal func handleScrollsToTopForContainers(centerEnabled: Bool, leftEnabled:Bool, rightEnabled:Bool) {
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            _ = handleScrollsToTop(enabled: centerEnabled, forView: centerPanelContainer)
            _ = handleScrollsToTop(enabled: leftEnabled, forView: leftPanelContainer)
        }
    }
    
    
    internal func handleScrollsToTop(enabled: Bool, forView view: UIView) -> Bool {
        
        if view is UIScrollView {
            let scrollView: UIScrollView = view as! UIScrollView
            scrollView.scrollsToTop = enabled
            return true
        }
        else{
            for subView: UIView in view.subviews {
                if handleScrollsToTop(enabled: enabled, forView: subView) {
                    return true
                }
            }
        }
        return false
    }
    
    
    //  Panel Animations
    
    internal func animateCenterPanel(shouldBounce: Bool, completion: @escaping (_ finished: Bool) -> Void) {
        
        var bounceAllowed = shouldBounce
        let bounceDistance: CGFloat = (centeralPanelSlidingFrame.origin.x - centerPanelContainer.frame.origin.x) * configs.bouncePercentage
        if centeralPanelSlidingFrame.size.width > centerPanelContainer.frame.size.width {
            bounceAllowed = false
        }
        
        let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear, .layoutSubviews], animations: {
            self.centerPanelContainer.frame = self.centeralPanelSlidingFrame
            if self.configs.pusheSidePanels {
                self.layoutSideContainers(withDuration: 0.0, animated: false)
            }
        }, completion:{ (finished) in
            
            if (bounceAllowed) {
                
                if self.state == .center {
                    if bounceDistance > 0.0 {
                        self.loadLeftPanel()
                    }
                }
                
                UIView.animate(withDuration: TimeInterval(self.configs.bounceDuration), delay: 0.0, options: .curveEaseInOut, animations: {
                    var bounceFrame: CGRect = self.centeralPanelSlidingFrame
                    bounceFrame.origin.x += bounceDistance
                    self.centerPanelContainer.frame = bounceFrame
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: TimeInterval(self.configs.bounceDuration), delay: 0.0, options: .curveEaseIn, animations: {
                        self.centerPanelContainer.frame = self.centeralPanelSlidingFrame
                    }, completion: completion)
                })
            }
            else {
                completion(finished)
            }
        })
    }
    
    
    
    internal func xPositionFor( _ translationInX: CGFloat) -> CGFloat {
        
        let position: CGFloat = centeralPanelSlidingFrame.origin.x + translationInX
        
        if state == .center {

            if (position > 0.0 && self.leftPanelVC == nil) || (position < 0.0) {
                return 0.0
            }
            else if position > widthForLeftPanelVC {
                return widthForLeftPanelVC
            }

        }
       
        else if state == .left {
            
            if position > widthForLeftPanelVC {
                return 0.0
            }
            else if configs.pusheSidePanels && position < 0.0 {
                return -centeralPanelSlidingFrame.origin.x
            }
            else if position < leftPanelContainer.frame.origin.x {
                return leftPanelContainer.frame.origin.x - centeralPanelSlidingFrame.origin.x
            }
        }
        return translationInX
    }

    
    internal func xPositionForLeftPanel( _ translationInX: CGFloat) -> CGFloat {
        
        if state == .center {

            let newPosition = -widthForLeftPanelVC + translationInX
            if newPosition > 0.0 { return 0.0 }
            else if newPosition < -widthForLeftPanelVC { return -widthForLeftPanelVC }
            else { return newPosition }
        }
        else if state == .left {

            if translationInX > 0.0 { return 0.0 }
            else if translationInX < -widthForLeftPanelVC { return -widthForLeftPanelVC }
            else { return translationInX }
        }
        else { return 0.0 }
    }

    
    //  Handle Panning Decisions
    
    
    internal func shouldCompletePanFor(movement: CGFloat) -> Bool {
        
        let minimum: CGFloat = CGFloat(floorf(Float(view.bounds.size.width * configs.minMovePercentage)))
        
        switch state {
        case .left:
            return movement <= -minimum
            
        case .center:
            return fabsf(Float(movement)) >= Float(minimum)
            
      
        }
    }
}
