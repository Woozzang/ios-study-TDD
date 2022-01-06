//
//  ViewControllers.swift
//  FitNessTests
//
//  Created by Woochan Park on 2022/01/06.
//  Copyright © 2022 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

/// `Helper function`
/// 실제 앱 상에서의 뷰 컨트롤러를 가져오는 코드
func loadRootViewController() -> RootViewController {
  
  let window = UIApplication.shared.windows[0]
  return window.rootViewController as! RootViewController
}
