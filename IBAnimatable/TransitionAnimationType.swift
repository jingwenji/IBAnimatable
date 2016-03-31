//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case Fade             // ToView fades in and FromeView fades out
  case FadeIn           // ToView fades in
  case FadeOut          // FromView Fades out
  case SystemCube(direction: TransitionFromDirection)
  case SystemFlip(direction: TransitionFromDirection)
  case SystemPageCurl(direction: TransitionFromDirection)
  case SystemCameraIris(hollowState: TransitionHollowState)

  var stringValue: String {
    return String(self)
  }

  static func fromString(transitionType: String) -> TransitionAnimationType? {
    if transitionType.hasPrefix("Fade") {
      return fadeTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemCameraIris") {
        return cameraIrisTransitionAnimationType(transitionType)
    } else  {
      return fromStringWithDirection(transitionType)
    }
  }

}

// MARK: - TransitionAnimationType from string

private extension TransitionAnimationType {
  
  static func cleanTransitionType(transitionType: String) -> String {
    let range = transitionType.rangeOfString("(")
    let transitionType = transitionType.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? transitionType.endIndex)
    return transitionType
  }
  
  static func transitionDirection(forTransitionType transitionType: String) -> TransitionFromDirection? {
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("left") {
      return .Left
    } else if transitionType.containsString("right") {
      return .Right
    } else if transitionType.containsString("top") {
      return .Top
    } else if transitionType.containsString("bottom") {
      return .Bottom
    }
    return nil
  }
  
  
  static func fadeTransitionAnimationType(transitionType: String) -> TransitionAnimationType {
    if transitionType.hasSuffix("In") {
      return .FadeIn
    } else if transitionType.hasSuffix("Out") {
      return .FadeOut
    }
    return .Fade
  }
 
  static func cameraIrisTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("open") {
      return .SystemCameraIris(hollowState: .Open)
    } else if transitionType.containsString("close") {
      return .SystemCameraIris(hollowState: .Close)
    }
    return nil
  }
  
  static func fromStringWithDirection(transitionType: String) -> TransitionAnimationType? {
    guard let direction = transitionDirection(forTransitionType: transitionType) else {
      return nil
    }
    
    if transitionType.hasPrefix("SystemCube") {
      return .SystemCube(direction: direction)
    } else if transitionType.hasPrefix("SystemFlip") {
      return .SystemFlip(direction: direction)
    } else if transitionType.hasPrefix("SystemPageCurl") {
      return .SystemPageCurl(direction: direction)
    }
    return nil
  }
  
}