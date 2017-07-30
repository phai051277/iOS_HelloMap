//
//  ViewController.swift
//  HelloMap
//
//  Created by 小池基文 on 2017/07/09.
//  Copyright © 2017年 小池基文. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
print("ViewController/viewDidLoad/インスタンス化された直後（初回に一度のみ）")
        super.viewDidLoad()
        
        locationManager = CLLocationManager() // インスタンスの生成
        locationManager.delegate = self // CLLocationManagerDelegateプロトコルを実装するクラスを指定する

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
print("ViewController/didReceiveMemoryWarning/メモリが足りないので開放される")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
print("ViewController(extension)/locationManager/いつ？")
        switch status {
        case .notDetermined:
            print("ユーザーはこのアプリケーションに関してまだ選択を行っていません")
            // アプリケーションに関してまだ選択されていない
            locationManager.requestWhenInUseAuthorization() // 起動中のみの取得許可を求める
            break
        case .denied:
            print("ローケーションサービスの設定が「無効」になっています (ユーザーによって、明示的に拒否されています）")
            //アラートコントローラー作成
            alert = UIAlertController(title: "確認", message: "設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                print("OKをタップした時の処理")
            }))
            self.present(alert, animated: true, completion: nil)
        case .restricted:
            print("このアプリケーションは位置情報サービスを使用できません(ユーザによって拒否されたわけではありません)")
            //アラートコントローラー作成
            alert = UIAlertController(title: "確認", message: "このアプリは、位置情報を取得できないために、正常に動作できません", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                print("OKをタップした時の処理")
            }))
            self.present(alert, animated: true, completion: nil)
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
            // 位置情報取得の開始処理
            break
        case .authorizedWhenInUse:
            print("起動時のみ、位置情報の取得が許可されています。")
            // 位置情報取得の開始処理
            break
        }
    }
}
