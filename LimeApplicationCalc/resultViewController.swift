import UIKit

class resultViewController: UIViewController {

    //+++初期設定+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var resultValue : Double = 0.0 //計算結果の値受け取り変数
    var changeResult : Double = 0.0 //単位変換用の変数
    var unitStatus :Int = 1 //単位の状態　1：10a , 2:坪 , 3:㎡
    @IBOutlet weak var resultLabel: UILabel! //計算結果の表示用ラベル
    @IBOutlet weak var unitLabel: UILabel! //単位表示用（面積）ラベル
    @IBOutlet weak var weightUnitLabel: UILabel! //単位表示用（重量）ラベル
    @IBOutlet weak var stringLabel: UILabel!
    
    @IBOutlet weak var changeBtn: UIButton!  //
    @IBOutlet weak var resultView: UIView!
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

//+++入力画面の切り替え（メインに戻る）アクション++++++++++++++++++++++++++++++++++
    @IBAction func backMain(_ sender: UIButton) {
        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
        self.present(mainView,animated: true, completion: nil)
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
//+++単位の変換アクション+++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func changeUnit(_ sender: UIButton) {
        unitStatus += 1
        
        switch unitStatus {
        case 1:
            resultLabel.text = String(Int(resultValue))
            unitLabel.text = "10a"
            weightUnitLabel.text = "kg"
        case 2:
            changeResult = resultValue / 300 * 1000
            resultLabel.text = String(Int(changeResult))
            unitLabel.text = "坪"
            weightUnitLabel.text = "g"
        case 3:
            changeResult = resultValue
            resultLabel.text = String(Int(changeResult))
            unitLabel.text = "㎡"
            weightUnitLabel.text = "g"
        default:
            unitStatus = 1
            resultLabel.text = String(Int(resultValue))
            unitLabel.text = "10a"
            weightUnitLabel.text = "kg"
        }
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
//+++画面の読み込み時処理+++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //計算結果を表示（Doubule->Int->Stringへ型キャスト）
        resultLabel.text = String(Int(resultValue))
        
        //ボタン・ビューの装飾
        changeBtn.layer.cornerRadius = 7.0
        resultView.layer.cornerRadius = 10.0
        
        //ラベル枠の大きさに合わせてフォントサイズを調整
        resultLabel.adjustsFontSizeToFitWidth = true
        weightUnitLabel.adjustsFontSizeToFitWidth = true
        stringLabel.adjustsFontSizeToFitWidth = true
        
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

}
