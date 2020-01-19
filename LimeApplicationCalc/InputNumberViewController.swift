import UIKit

class InputNumberViewController: UIViewController {
    
//+++初期設定+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var numLabel :String = ""       //　入力数値の変数
    var inputNumber : Int = 0       //　数値入力回数カウント変数
    var receivedValue :String = ""  //　入力状態の識別変数
    
    @IBOutlet weak var guidanceLabel: UILabel! // 入力指示ガイダンスの表示用ラベル
    @IBOutlet weak var subGuidanceLabel: UILabel! // 入力指示ガイダンスを補足するラベル
    @IBOutlet weak var NumberLabel: UILabel! //　入力数値の表示用ラベル
    @IBOutlet weak var buttonP: UIButton! //　小数点入力ボタンの入力状態制御
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var inputNumView: UIView!
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

//+++数値入力+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func inputNum(_ sender: UIButton) {
        let currentText  = sender.currentTitle!
        
        switch receivedValue {
            //現在pH、改善pHの入力(0-14.0)
            case "presentPh", "improvedPh" :
                if currentText == "." {
                    switch inputNumber {
                    case 0:
                        numLabel = "0."
                        buttonP.isEnabled = false
                        inputNumber = 3
                    case 1:
                        numLabel += currentText
                        buttonP.isEnabled = false
                        inputNumber = 3
                    case 2:
                        numLabel += currentText
                        buttonP.isEnabled = false
                        inputNumber = 3
                    case 3:
                        inputNumber = 4
                    default: break
                    }
                } else if currentText == "0" {
                    switch inputNumber {
                    case 0:
                        numLabel += currentText
                        inputNumber = 2
                    case 1:
                        numLabel += currentText
                        inputNumber = 2
                    case 2: break
                    case 3:
                        numLabel += currentText
                        inputNumber = 4
                    default: break
                    }
                } else if currentText == "1" {
                    switch inputNumber {
                    case 0:
                        numLabel += currentText
                        inputNumber = 1
                    case 1:
                        numLabel += currentText
                        inputNumber = 2
                    case 2: break
                    case 3:
                        if numLabel == "14." {
                            break
                        } else {
                            numLabel += currentText
                        }
                        inputNumber = 4
                    default: break
                    }
                } else if currentText == "2" || currentText == "3" || currentText == "4"{
                    switch inputNumber {
                    case 0:
                        numLabel += currentText
                        inputNumber = 2
                    case 1:
                        numLabel += currentText
                        inputNumber = 2
                    case 2: break
                    case 3:
                        if numLabel == "14." {
                            break
                        } else {
                            numLabel += currentText
                        }
                        inputNumber = 4
                    default: break
                    }
                } else {
                    switch inputNumber {
                    case 0:
                        numLabel += currentText
                        inputNumber = 2
                    case 1:
                        inputNumber = 2
                    case 2: break
                    case 3:
                        if numLabel == "14." {
                            break
                        } else {
                            numLabel += currentText
                        }
                        inputNumber = 4
                    default: break
                    }
                }
                NumberLabel.text = numLabel
            //耕起深の入力(0-999)
            case "plowingDepth" :
                if inputNumber < 3 {
                    numLabel += currentText
                    inputNumber += 1
                }
                NumberLabel.text = numLabel + "cm"
            //仮比重の入力(0-1.99)
            case "bulkDensity":
                if inputNumber < 3 {
                    if currentText == "0" {
                        if inputNumber == 0 {
                            numLabel = "0."
                            inputNumber = 1
                        } else {
                            numLabel += currentText
                            inputNumber += 1
                        }
                    } else if currentText == "1" {
                        if inputNumber == 0 {
                            numLabel = "1."
                            inputNumber = 1
                        } else {
                            numLabel += currentText
                            inputNumber += 1
                        }
                    } else {
                        if inputNumber == 0 {
                        } else {
                            numLabel += currentText
                            inputNumber += 1
                        }
                    }
                }
                NumberLabel.text = numLabel
            //アルカリ分の入力(0-100)
            case "alkalineContent" :
                if inputNumber < 2 {
                    numLabel += currentText
                    inputNumber += 1
                } else {
                    numLabel = "100"
                }
                NumberLabel.text = numLabel + "%"
            default: break
        }
        
        //入力数値をUserDefaultsに保存
        if receivedValue == "presentPh" {
            UserDefaults.standard.set(numLabel,forKey: "presentPhKey")
        } else if receivedValue == "improvedPh" {
            UserDefaults.standard.set(numLabel,forKey: "improvedPhKey")
        } else if receivedValue == "plowingDepth" {
            UserDefaults.standard.set(numLabel,forKey: "plowingDepthKey")
        } else if receivedValue == "bulkDensity" {
            UserDefaults.standard.set(numLabel,forKey: "bulkDensityKey")
        } else if receivedValue == "alkalineContent" {
            UserDefaults.standard.set("その他資材",forKey: "productSelectKey")
            UserDefaults.standard.set(numLabel,forKey: "alkalineContentKey")
        }
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//+++数値クリア+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func clearNum(_ sender: UIButton) {
        numLabel = ""
        NumberLabel.text = numLabel
        inputNumber = 0

        if receivedValue == "plowingDepth" || receivedValue == "bulkDensity" || receivedValue == "alkalineContent"{
            buttonP.isEnabled = false
        } else {
            buttonP.isEnabled = true
        }

    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

//+++入力画面の切り替え++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //次に進む
    @IBAction func goNext(_ sender: UIButton) {
        switch receivedValue {
            case "presentPh":
                let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                inputNum.receivedValue = "improvedPh"
                self.present(inputNum,animated: true, completion: nil)
            case "improvedPh":
                let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                inputNum.receivedValue = "plowingDepth"
                self.present(inputNum,animated: true, completion: nil)
            case "plowingDepth":
                let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
                selection.receivedValue = "soilTexture"
                self.present(selection,animated: true, completion: nil)
            case "bulkDensity":
                let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
                selection.receivedValue = "productSelect"
                self.present(selection,animated: true, completion: nil)
            case "alkalineContent":
                let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                self.present(mainView,animated: true, completion: nil)
            default: break
        }
    }
    
    //一つ前に戻る
    @IBAction func backBefore(_sender: UIButton) {
        switch receivedValue {
            case "presentPh":
                let mainView = storyboard!.instantiateViewController(withIdentifier: "mainView") as! ViewController
                self.present(mainView,animated: true, completion: nil)
            case "improvedPh":
                let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                inputNum.receivedValue = "presentPh"
                self.present(inputNum,animated: true, completion: nil)
            case "plowingDepth":
                let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
                inputNum.receivedValue = "improvedPh"
                self.present(inputNum,animated: true, completion: nil)
            case "bulkDensity":
                let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
                selection.receivedValue = "humusContent"
                self.present(selection,animated: true, completion: nil)
            case "alkalineContent":
                let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
                selection.receivedValue = "productSelect"
                self.present(selection,animated: true, completion: nil)
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
        
        //入力初期化
        numLabel = ""
        NumberLabel.text = numLabel
        inputNumber = 0
        
      //入力状態の識別・入力指示ガイダンス表示・小数点ボタンの状態
        if receivedValue == "presentPh" {
            guidanceLabel.text = "現在pHを入力して下さい"
            subGuidanceLabel.text = ""
            buttonP.isEnabled = true
        } else if receivedValue == "improvedPh" {
            guidanceLabel.text = "改善pHを入力して下さい"
            subGuidanceLabel.text = ""
            buttonP.isEnabled = true
        } else if receivedValue == "plowingDepth" {
            guidanceLabel.text = "耕起深(cm)を選んで下さい"
            subGuidanceLabel.text = ""
            buttonP.isEnabled = false
        } else if receivedValue == "bulkDensity" {
            guidanceLabel.text = "仮比重を入力して下さい"
            subGuidanceLabel.text = "参考：低地土・台地土1.0、火山性土0.8"
            buttonP.isEnabled = false
        } else if receivedValue == "alkalineContent" {
            guidanceLabel.text = "アルカリ分(%)を入力して下さい"
            subGuidanceLabel.text = ""
            buttonP.isEnabled = false
        }
        
        //ボタンの装飾
        backBtn.layer.cornerRadius = 7.0
        nextBtn.layer.cornerRadius = 7.0
        inputNumView.layer.cornerRadius = 10.0
        
        //ラベル枠の大きさに合わせてフォントサイズを調整
        guidanceLabel.adjustsFontSizeToFitWidth = true
        
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

}

