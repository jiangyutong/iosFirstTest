//: Playground - noun: a place where people can play

import UIKit

/*

 1. 定一个协议(XXXShapeProtocol)(XXX 表示自己的姓名简写)，具体要求:
 a) 存储属性:date{get set}(对象创建时间)
 b) 计算属性:perimeter {get}(周长)
 */
//写一个时间函数，为后面的属性做准备
func getDate(date: Date, zone: Int = 0) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"  //指定格式化的格式
    formatter.locale = Locale(identifier:"zh_cn")  //设置当前位置，可以将对应的星期数和12小时制的上下午设置为中文
    if zone >= 0 {
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    } else {
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    
    let dateString = formatter.string(from:now)
    return dateString
}
let now = Date()



//定义协议
protocol JytShapeProtocol{
    var date:String{
        get set
    }//date现在为一个计算属性，题目中为存储属性疑惑
    var perimeter:Double{
        get
    }
}
/*
 
 2. 新建一个类 XXXShapeProtocol(实现协议 XXXShapeProtocol)，具体要求:
 a) 私有属性半径 radius;
 b) 重载计算属性 perimeter(利用圆的周长公式计算并返回当前圆的实际周长);
 c) 具有构造函数;  
 d) 实例可以直接用 print 输出(输出自己的形状、周长和创建时间);  
 */
class JytCircle:JytShapeProtocol,CustomStringConvertible,Codable
{
    private var radius:Double
    var date: String
    {
        get{
            return getDate(date: now, zone: +8)//北京处于东八区加8
        }
        set{
            
        }
    }
    var perimeter: Double
    {
        return 2*3.14*radius
        
    }
    init(radius:Double){
        self.radius = radius
    }
    var description:String{
        return "I am Circle，my length is \(perimeter)\n"
    }
}

/*
 3. 类的使用:
 a) 构造多个 XXXCircle 的对象，并将对象存入一个数组中;
 b) 用 filter 闭包选出 perimeter 在某个范围内的对象数组;
 c) 对筛选出的数组进行排序并输出排序后结果(按 perimeter 从小到大);
 */
var circleOne=JytCircle(radius: 2)
var circleTwo=JytCircle(radius: 3)
var circleThree=JytCircle(radius: 4)
var circleFour=JytCircle(radius: 5)
var circleFive=JytCircle(radius: 6)
var circleSix=JytCircle(radius: 7)
var circleSeven=JytCircle(radius: 8)
var arryJytCircle:[JytCircle]=[circleOne,circleTwo,circleThree,circleFour,circleFive,circleSix,circleSeven]
print(arryJytCircle)
var arryJytCircleFilter:[JytCircle]=arryJytCircle.filter({
    $0.perimeter>20
})//选出 perimeter大于20的圆形
print(arryJytCircleFilter)
var arrJytCircleSort:[JytCircle]=arryJytCircleFilter.sorted(by:
{
    $0.perimeter>$1.perimeter
})//用perimeter来排序
print(arrJytCircleSort)
/*
 
 4. 沙盒文件操作
 a) 将排序后的数组保存到沙盒 Document 文件夹下以自己姓名命名的一文件中;
 b) 从文件中恢复一个新的数组，并打印数组;
 */
let fileManager=FileManager.default
let encode=JSONEncoder()
let decode=JSONDecoder()
var arryJytCircleEncoder=try encode.encode(arrJytCircleSort)
if  var docPath=fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
{
     docPath.appendPathComponent("jyt.txt")
    try arryJytCircleEncoder.write(to: docPath)
     print(docPath.path)
    let arryJytCirclePrintOne=try Data(contentsOf: docPath)//从文件中读数据;
    print(String(data: arryJytCirclePrintOne, encoding: .utf8)!)
    let  arryJytCirclePrintTwo=try decode.decode(type(of: arrJytCircleSort), from: arryJytCirclePrintOne)
    for (key,value) in arryJytCirclePrintTwo.enumerated()//对取的数组进行遍历
    {
        print("\(key):\(value)")
    }
    print(arryJytCirclePrintTwo)//以print的方式输出数组对象
}
























