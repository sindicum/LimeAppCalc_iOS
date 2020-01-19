import UIKit

class selectViewController: UIViewController {

//+++初期設定+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var numLabel :String = ""       //　入力数値の変数
    var receivedValue :String = ""  //　入力状態の識別変数
    
    @IBOutlet weak var guidanceLabel: UILabel! // 入力指示ガイダンスの表示用ラベル
    
    @IBOutlet weak var buttonLab1: UIButton! //入力内容の選択ボタン1
    @IBOutlet weak var buttonLab2: UIButton! //入力内容の選択ボタン2
    @IBOutlet weak var buttonLab3: UIButton! //入力内容の選択ボタン3
    @IBOutlet weak var buttonLab4: UIButton! //入力内容の選択ボタン4
    @IBOutlet weak var buttonLab5: UIButton! //入力内容の選択ボタン5
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var selectView: UIView!
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
//+++入力内容の選択・UserDefaultsへの保存・画面遷移+++++++++++++++++++++++++++++
    @IBAction func selectLabelBtn(_ sender: UIButton) {
        let currentText  = sender.currentTitle!

        switch receivedValue {
            //土性の選択
            case "soilTexture":
                UserDefaults.standard.set(currentText,forKey: "soilTextureKey")
                let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
                selection.receivedValue = "humusContent"
                self.present(selection,animated: true, completion: nil)
            //腐植含量の選択
            case "humusContent":
                UserDefaults.standard.set(currentText,forKey: "humusContentKey")
                let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                inputNum.receivedValue = "bulkDensity"
                self.present(inputNum,animated: true, completion: nil)
            //使用資材の選択
            case "productSelect":
                switch currentText {
                    case "炭カル（粉）":
                        UserDefaults.standard.set(currentText,forKey: "productSelectKey")
                        UserDefaults.standard.set("53",forKey: "alkalineContentKey")
                        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                        self.present(mainView,animated: true, completion: nil)
                    case "炭カル（粒）":
                        UserDefaults.standard.set(currentText,forKey: "productSelectKey")
                        UserDefaults.standard.set("50",forKey: "alkalineContentKey")
                        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                        self.present(mainView,animated: true, completion: nil)
                    case "生石灰":
                        UserDefaults.standard.set(currentText,forKey: "productSelectKey")
                        UserDefaults.standard.set("80",forKey: "alkalineContentKey")
                        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                        self.present(mainView,animated: true, completion: nil)
                    case "苦土生石灰":
                        UserDefaults.standard.set(currentText,forKey: "productSelectKey")
                        UserDefaults.standard.set("100",forKey: "alkalineContentKey")
                        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                        self.present(mainView,animated: true, completion: nil)
                    default:
                        UserDefaults.standard.set(currentText,forKey: "productSelectKey")
                        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                        inputNum.receivedValue = "alkalineContent"
                        self.present(inputNum,animated: true, completion: nil)
                }
            default: break
        }
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

//+++入力画面の切り替え+++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //一つ前に戻る
    @IBAction func backBefore(_sender: UIButton) {
        switch receivedValue {
        case "soilTexture":
            let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
            inputNum.receivedValue = "plowingDepth"
            self.present(inputNum,animated: true, completion: nil)
        case "humusContent":
            let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
            selection.receivedValue = "soilTexture"
            self.present(selection,animated: true, completion: nil)
        case "productSelect":
            let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
            inputNum.receivedValue = "bulkDensity"
            self.present(inputNum,animated: true, completion: nil)
        default: break
        }
    }

    //メイン画面に戻る
    @IBAction func backMain(_ sender: UIButton) {
        let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
        self.present(mainView,animated: true, completion: nil)
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
//+++画面の読み込み時処理+++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //入力状態の識別と入力指示ガイダンス表示
        if receivedValue == "soilTexture" {
            guidanceLabel.text = "土性を選んで下さい"
            buttonLab1.setTitle("砂土(S)", for: .normal)
            buttonLab2.setTitle("砂壌土(SL)", for: .normal)
            buttonLab3.setTitle("壌土(L)", for: .normal)
            buttonLab4.setTitle("埴壌土(CL)", for: .normal)
            buttonLab5.setTitle("埴土(C)", for: .normal)
        } else if receivedValue == "humusContent" {
            guidanceLabel.text = "腐植含量を選んで下さい"
            buttonLab1.setTitle("あり・含む(5%未満)", for: .normal)
            buttonLab2.setTitle("富む(5〜10%)", for: .normal)
            buttonLab3.setTitle("すこぶる富む(10〜20%)", for: .normal)
            buttonLab4.setTitle("腐植土(20〜30%)", for: .normal)
            buttonLab5.setTitle("泥炭土(30%以上)", for: .normal)
        } else if receivedValue == "productSelect" {
            guidanceLabel.text = "使用資材を選んで下さい"
            buttonLab1.setTitle("炭カル（粉）", for: .normal)
            buttonLab2.setTitle("炭カル（粒）", for: .normal)
            buttonLab3.setTitle("生石灰", for: .normal)
            buttonLab4.setTitle("苦土生石灰", for: .normal)
            buttonLab5.setTitle("その他資材", for: .normal)
        }
        
        //ボタンの装飾
        backBtn.layer.cornerRadius = 7.0
        selectView.layer.cornerRadius = 10.0
        
        //ラベル枠の大きさに合わせてフォントサイズを調整
        guidanceLabel.adjustsFontSizeToFitWidth = true
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

}
