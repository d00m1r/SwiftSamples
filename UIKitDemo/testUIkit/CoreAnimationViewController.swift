//
//  ViewController.swift
//  Animations
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CoreAnimationViewController: VCLLoggingViewController {
    
    @IBOutlet weak var animatableView: UIView!
    private var animator: UIViewPropertyAnimator!
    var dynamicAnimator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 10
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(recognizer:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @IBAction func tapHandler() {
//        performImplicitAnimation()
//        performMoveAnimation()
//        performColorAnimation()
//        performPathAnimation()
//        performTransitionAnimation()
        performGroupAnimation()
//    performUIKitAnimation()
//        performViewAnimatorAnimation()
//        performUIKitDynamicsAnimation()
    }
    
    // MARK: - Private
    // 1
    private func performImplicitAnimation() {
        animatableView.layer.opacity = 0.2
    }
    
    // 2
    private func performMoveAnimation() {
        let value = view.center
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 2.0
        animation.fromValue = animatableView.center
        animation.toValue = value
        animatableView.layer.add(animation, forKey: "move")
        animatableView.layer.position = value
    }
    
    // 3
    private func performColorAnimation() {
        let finalColor = UIColor.magenta
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.backgroundColor))
        animation.values = [UIColor.green.cgColor, UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.cyan.cgColor, finalColor.cgColor]
        animation.keyTimes = [0, 0.3, 0.5, 0.6, 0.8, 1]
        animation.duration = 10.0
        animatableView.layer.add(animation, forKey: "color")
        animatableView.backgroundColor = finalColor
    }
    
    // 4
    private func performPathAnimation() {
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        let rect = CGRect(origin: animatableView.frame.origin, size: animatableView.bounds.size)
        animation.path = CGPath(ellipseIn: rect, transform: nil)
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.calculationMode = CAAnimationCalculationMode.paced
        animatableView.layer.add(animation, forKey: "rotation")
    }
    
    // 5
    private func performTransitionAnimation() {
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = CATransitionType.push
        animatableView.layer.add(transition, forKey: "transition")
        animatableView.layer.backgroundColor = UIColor.cyan.cgColor
    }
    
    // 6
    private func performGroupAnimation() {
        let scaleValue: CGFloat = 2.0
        let positionValue = view.center
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = scaleValue
        
        let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        positionAnimation.fromValue = animatableView.center
        positionAnimation.toValue = positionValue
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, positionAnimation]
        groupAnimation.duration = 2.0
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animatableView.layer.add(groupAnimation, forKey: "groupAnimation")
        animatableView.layer.transform = CATransform3DMakeScale(scaleValue, scaleValue, 1.0)
        animatableView.layer.position = positionValue
    }
    
    // 7
    private func performUIKitAnimation() {
        UIView.animate(withDuration: 3.0, delay: 1.0, options: [.curveEaseInOut], animations: {
            self.animatableView.center = self.view.center
            self.animatableView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { _ in
            self.animatableView.backgroundColor = .green
        }
    }
    
    // 8
    private func performViewAnimatorAnimation() {
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            self.animatableView.center = self.view.center
            self.animatableView.transform = CGAffineTransform(rotationAngle: .pi / 4)
        }
        animator.addCompletion { _ in
            self.animatableView.backgroundColor = .red
        }
        animator.startAnimation()
    }
    
    // 9
    @objc
    private func panGestureHandler(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animatableView.backgroundColor = .orange
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
                self.animatableView.center.x += 250.0
                self.animatableView.transform = CGAffineTransform(rotationAngle: 3 * .pi / 4)
            })
            animator.addCompletion { _ in
                self.animatableView.backgroundColor = .red
            }
            animator.pauseAnimation()
        case .changed:
            animator.fractionComplete = recognizer.translation(in: view).x / view.bounds.size.width
        case .ended:
            animator.isReversed = true
            animator.startAnimation()
        default:
            ()
        }
    }
    //10
    private func performUIKitDynamicsAnimation() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        let gravity = UIGravityBehavior(items: [animatableView])
        let collision = UICollisionBehavior(items: [animatableView])
        collision.translatesReferenceBoundsIntoBoundary = true
        let itemBehaviour = UIDynamicItemBehavior(items: [animatableView])
        itemBehaviour.elasticity = 0.5
        dynamicAnimator.addBehavior(itemBehaviour)
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
    }
}
