//
//  SceneDelegate.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/05.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var testVar = "SceneDelegate"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // 코인 시세 API 연동, 애널리틱스 연동
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        print("sceneWillEnterForeground")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // 이전에 관심코인을 지정하던 작업내역이 있다면 해당 작업을 계속할수 있도록 유도
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    // 해당 퍼널에서 사용자가 이탈한 것으로 애널리틱스에 체크
    func sceneWillResignActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "someeventname"), object: "some value")
        print("sceneWillResignActive")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }


    // 최종적으로 사용자가 이탈한 것으로 체크
    // 보고있던 화면이 MyCoinVC라면 편집하던 코인 종류를 가져옴
    func sceneDidEnterBackground(_ scene: UIScene) {
//        let myCoinVC = MyCoinViewController()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let MainwController = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
//        print("Log", testVar)
        print("sceneDidEnterBackground")
        
        // 이전에 작업하던 코인을 가져오는 코드
        if let myCoin = UserDefaults.standard.object(forKey: "myCoin") as? String
        {
            print("Log", myCoin)
        }
        
        // 해당 시점에 마지막으로 작업하던 VC 이름을 가져오는 코드
        let rootVC =   UIApplication.shared.keyWindow?.rootViewController
        let presentVC = rootVC?.presentedViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController

        if presentVC != nil {
            print("LLOG - ", String(describing: presentVC.self))
            print("LLOG2 - ", String(describing: MyCoinViewController.self))
        } else{
            print("LLOG - Main")
        }
    }

    // 옵저버 해제
    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

}
