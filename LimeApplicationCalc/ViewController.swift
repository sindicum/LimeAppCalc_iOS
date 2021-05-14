import UIKit
import SnapKit

class ViewController: UIViewController {

//+++初期設定++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    var presentPhValue          : Double? = 0.0          //計算用変数：現在pH
    var improvedPhValue         : Double? = 0.0          //計算用変数：改善pH
    var plowingDepthValue       : Double? = 0.0          //計算用変数：耕起深
    var aleniusFactor           : Double? = 0.0          //計算用変数：アレーニウス係数
    var bulkDensityValue        : Double? = 0.0          //計算用変数：仮比重
    var alkalineContentValue    : Double? = 0.0          //計算用変数：アルカリ分
    var calcResult              : Double? = 0.0          //計算用変数：計算結果
    
    var presentPhStr :String?                           //入力値表示用変数：現在pH
    var improvedPhStr :String?                          //入力値表示用変数：改善pH
    var plowingDepthStr :String?                        //入力値表示用変数：耕起深
    var soilTextureStr :String?                         //入力値表示用変数：土性
    var humusContentStr :String?                        //入力値表示用変数：腐植含量
    var bulkDensityStr :String?                         //入力値表示用変数：仮比重
    var productSelectStr :String?                       //入力値表示用変数：使用資材
    var alkalineContentStr :String?                     //入力値表示用変数：アルカリ分
 
    @IBOutlet weak var presentPhBtn: UIButton!          //現在pHボタン
    @IBOutlet weak var improvedPhBtn: UIButton!         //改善pHボタン
    @IBOutlet weak var plowingDepthBtn: UIButton!       //耕起深ボタン
    @IBOutlet weak var soilTextureBtn: UIButton!        //土性ボタン
    @IBOutlet weak var humusContentBtn: UIButton!       //腐植含量ボタン
    @IBOutlet weak var bulkDensityBtn: UIButton!        //仮比重ボタン
    @IBOutlet weak var productSelectBtn: UIButton!      //使用資材ボタン
    @IBOutlet weak var alkalineContentBtn: UIButton!    //アルカリ分ボタン
    
    @IBOutlet weak var calcButton: UIButton!            //計算結果ボタン
    @IBOutlet weak var resetButton: UIButton!           //リセットボタン
    
    @IBOutlet weak var productSelectLabel: UILabel!     //使用資材ラベル（フォントサイズ調整）
    @IBOutlet weak var alkalineContentLabel: UILabel!   //アルカリ分ラベル（フォントサイズ調整）
    @IBOutlet weak var inputResultView: UIView!         //入力結果ビュー
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
//+++各入力項目への入力アクション用ボタン+++++++++++++++++++++++++++++++++++++++
    
    //inputNumViewへの遷移
    @IBAction func presentPhBtn(_ sender: UIButton) {
        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
        inputNum.receivedValue = "presentPh"
        self.present(inputNum,animated: true, completion: nil)
    }
    @IBAction func improvedPhBtn(_ sender: UIButton) {
        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
        inputNum.receivedValue = "improvedPh"
        self.present(inputNum,animated: true, completion: nil)
    }
    @IBAction func plowingDepthBtn(_ sender: UIButton){
        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
        inputNum.receivedValue = "plowingDepth"
        self.present(inputNum,animated: true, completion: nil)
    }
    @IBAction func bulkDensityBtn(_ sender: UIButton) {
        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
        inputNum.receivedValue = "bulkDensity"
        self.present(inputNum,animated: true, completion: nil)
    }
    @IBAction func alkalineContentBtn(_ sender: UIButton) {
        let inputNum = storyboard!.instantiateViewController(withIdentifier: "inputNumView") as! InputNumberViewController
        inputNum.receivedValue = "alkalineContent"
        self.present(inputNum,animated: true, completion: nil)
    }
    
    //selectViewへの遷移
    @IBAction func soilTextureBtn(_ sender: UIButton) {
        let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
        selection.receivedValue = "soilTexture"
        self.present(selection,animated: true, completion: nil)
    }
    @IBAction func humusContentBtn(_ sender: UIButton) {
        let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
        selection.receivedValue = "humusContent"
        self.present(selection,animated: true, completion: nil)
    }
    @IBAction func productSelectBtn(_ sender: UIButton) {
        let selection = storyboard!.instantiateViewController(withIdentifier: "selectView") as! selectViewController
        selection.receivedValue = "productSelect"
        self.present(selection,animated: true, completion: nil)
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
//+++計算実行++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func calcBtn(_ sender: UIButton) {
        
        //アレーニウス係数の算出
        switch humusContentStr {
            case "あり・含む(5%未満)":
                switch soilTextureStr {
                    case "砂土(S)" :
                        aleniusFactor = 8
                    case "砂壌土(SL)" :
                        aleniusFactor = 17
                    case "壌土(L)" :
                        aleniusFactor = 25
                    case "埴壌土(CL)" :
                        aleniusFactor = 34
                    case "埴土(C)" :
                        aleniusFactor = 42
                    default:break
                }
            case "富む(5〜10%)":
                switch soilTextureStr {
                    case "砂土(S)" :
                        aleniusFactor = 13
                    case "砂壌土(SL)" :
                        aleniusFactor = 25
                    case "壌土(L)" :
                        aleniusFactor = 34
                    case "埴壌土(CL)" :
                        aleniusFactor = 42
                    case "埴土(C)" :
                        aleniusFactor = 51
                    default:break
                }
            case "すこぶる富む(10〜20%)":
                switch soilTextureStr {
                    case "砂土(S)" :
                        aleniusFactor = 20
                    case "砂壌土(SL)" :
                        aleniusFactor = 39
                    case "壌土(L)" :
                        aleniusFactor = 51
                    case "埴壌土(CL)" :
                        aleniusFactor = 62
                    case "埴土(C)" :
                        aleniusFactor = 73
                    default:break
                }
            case "腐植土(20〜30%)":
                        aleniusFactor = 83
            case "泥炭土(30%以上)" :
                        aleniusFactor = 99
            default:
                aleniusFactor = 0
        }
        
        //型変換(String -> Double)
        presentPhValue = Double(presentPhStr!)
        improvedPhValue = Double(improvedPhStr!)
        plowingDepthValue = Double(plowingDepthStr!)
        bulkDensityValue = Double(bulkDensityStr!)
        alkalineContentValue = Double(alkalineContentStr!)
        
        //pH矯正の石灰量算出式
        if alkalineContentValue != 0 {
            calcResult = (improvedPhValue! - presentPhValue!) * plowingDepthValue! * bulkDensityValue! * aleniusFactor! * 53 / alkalineContentValue!
        } else {
            calcResult = 0
        }
            
        //resultViewへの遷移
        let result = storyboard!.instantiateViewController(withIdentifier: "resultView") as! resultViewController
        result.resultValue = calcResult!
        self.present(result,animated: true, completion: nil)
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
//+++UserDefaults保存値のクリア++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func resetBtn(_ sender: UIButton) {
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        
        loadView()
        viewDidLoad()
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

//+++画面の読み込み時処理+++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.size.width          //画面の幅サイズ取得
        view.addSubview(inputResultView)
        if width >= 345 {
            inputResultView.snp.makeConstraints { make in
                make.width.equalTo(345)     // 幅を335ptに設定
                make.height.equalTo(600)    // 幅を650ptに設定
            }
        } else {
            inputResultView.snp.makeConstraints { make in
                make.width.equalTo(320)     // 幅を320ptに設定
                make.height.equalTo(520)    // 幅を520ptに設定
            }
        }

        calcButton.isEnabled = true
        
        //各ボタンへUserDefaults保存値をセット
        if let _ = UserDefaults.standard.string(forKey: "presentPhKey") {
            presentPhStr = UserDefaults.standard.string(forKey: "presentPhKey")!
            presentPhBtn.setTitle(presentPhStr, for: .normal)
        } else {
            presentPhStr = ""
            presentPhBtn.setTitle(presentPhStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "improvedPhKey") {
            improvedPhStr = UserDefaults.standard.string(forKey: "improvedPhKey")!
            improvedPhBtn.setTitle(improvedPhStr, for: .normal)
        } else {
            improvedPhStr = ""
            improvedPhBtn.setTitle(improvedPhStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "plowingDepthKey") {
            plowingDepthStr = UserDefaults.standard.string(forKey: "plowingDepthKey")!
            plowingDepthBtn.setTitle(plowingDepthStr! + "cm", for: .normal)
        } else {
            plowingDepthStr = ""
            plowingDepthBtn.setTitle(plowingDepthStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "soilTextureKey") {
            soilTextureStr = UserDefaults.standard.string(forKey: "soilTextureKey")!
            soilTextureBtn.setTitle(soilTextureStr, for: .normal)
        } else {
            soilTextureStr = ""
            soilTextureBtn.setTitle(soilTextureStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "humusContentKey") {
            humusContentStr = UserDefaults.standard.string(forKey: "humusContentKey")!
            humusContentBtn.setTitle(humusContentStr, for: .normal)
        } else {
            humusContentStr = ""
            humusContentBtn.setTitle(humusContentStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "bulkDensityKey") {
            bulkDensityStr = UserDefaults.standard.string(forKey: "bulkDensityKey")!
            bulkDensityBtn.setTitle(bulkDensityStr, for: .normal)
        } else {
            bulkDensityStr = ""
            bulkDensityBtn.setTitle(bulkDensityStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if let _ = UserDefaults.standard.string(forKey: "productSelectKey") {
            productSelectStr = UserDefaults.standard.string(forKey: "productSelectKey")!
            productSelectBtn.setTitle(productSelectStr, for: .normal)
        } else {
            productSelectStr = ""
            productSelectBtn.setTitle(productSelectStr, for: .normal)
            calcButton.isEnabled = false
        }

        if let _ = UserDefaults.standard.string(forKey: "alkalineContentKey") {
            alkalineContentStr = UserDefaults.standard.string(forKey: "alkalineContentKey")!
            alkalineContentBtn.setTitle(alkalineContentStr! + "%", for: .normal)
        } else {
            alkalineContentStr = ""
            alkalineContentBtn.setTitle(alkalineContentStr, for: .normal)
            calcButton.isEnabled = false
        }
        
        if presentPhStr == "" {
            presentPhBtn.setTitle("タップで入力", for: .normal)
        } else if improvedPhStr == "" {
            improvedPhBtn.setTitle("タップで入力", for: .normal)
        } else if plowingDepthStr == "" {
            plowingDepthBtn.setTitle("タップで入力", for: .normal)
        } else if soilTextureStr == "" {
            soilTextureBtn.setTitle("タップで入力", for: .normal)
        } else if humusContentStr == "" {
            humusContentBtn.setTitle("タップで入力", for: .normal)
        } else if bulkDensityStr == "" {
            bulkDensityBtn.setTitle("タップで入力", for: .normal)
        } else if productSelectStr == "" {
            productSelectBtn.setTitle("タップで入力", for: .normal)
        } else if alkalineContentStr == "" {
            alkalineContentBtn.setTitle("タップで入力", for: .normal)
        }

        
    
        //ボタン・ラベル・ビューの装飾
        presentPhBtn.layer.cornerRadius = 5.0
        improvedPhBtn.layer.cornerRadius = 5.0
        plowingDepthBtn.layer.cornerRadius = 5.0
        soilTextureBtn.layer.cornerRadius = 5.0
        humusContentBtn.layer.cornerRadius = 5.0
        bulkDensityBtn.layer.cornerRadius = 5.0
        productSelectBtn.layer.cornerRadius = 5.0
        alkalineContentBtn.layer.cornerRadius = 5.0
        
        calcButton.layer.cornerRadius = 7.0
        resetButton.layer.cornerRadius = 7.0

        inputResultView.layer.cornerRadius = 10.0
        
        //ラベル枠の大きさに合わせてフォントサイズを調整
        productSelectLabel.adjustsFontSizeToFitWidth = true
        alkalineContentLabel.adjustsFontSizeToFitWidth = true
        
        presentPhBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        improvedPhBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        plowingDepthBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        soilTextureBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        humusContentBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        bulkDensityBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        productSelectBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        alkalineContentBtn.titleLabel?.adjustsFontSizeToFitWidth = true

    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
}

