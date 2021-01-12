import Foundation

enum ShapType {
    case triangle(String)
    case circular(String)
    case rectangle(String)
}


//工厂模式
class Shap {
    func draw() {
        
    }
}

enum CircularType :String {
    case oval
    case ellipsoid
}

class Circular:Shap {
    init(name:String) {
        print(name)
    }
}

enum TriangleType :String {
    case equilateral
    case normal
    case isosceles
}

class Triangle:Shap {
    init(name:String) {
        print(name)
    }
}

enum RectangleType :String {
    case equilateral
    case normal
}

class Rectangle:Shap {
    init(name:String) {
        print(name)
    }
}

// Factory method pattern
do {
    class ShapFactory {
        func createShap(type:ShapType) ->Shap {
            switch type {
            case .triangle(_):
                return TrangleShapFactory().createShap(type: type)
            case .circular(_):
                return CircularShapFactory().createShap(type: type)
            case .rectangle(_):
                return RectangleShapFactory().createShap(type: type)
            }
        }
    }

    class TrangleShapFactory: ShapFactory {
        override func createShap(type:ShapType) -> Shap {
            guard case let ShapType.triangle(_triangleType) = type,let triangleType = TriangleType(rawValue: _triangleType) else {
                fatalError("\(self)类型错误\(type)")
            }
            
            switch triangleType {
            case .equilateral: return Triangle(name: triangleType.rawValue)
            case .normal: return Triangle(name: triangleType.rawValue)
            case .isosceles: return Triangle(name: triangleType.rawValue)
            }
        }
    }

    class CircularShapFactory: ShapFactory {
        override func createShap(type:ShapType) -> Shap {
            guard case let ShapType.circular(_triangleType) = type,let triangleType = CircularType(rawValue: _triangleType) else {
                fatalError("\(self)类型错误\(type)")
            }
            
            switch triangleType {
            case .oval: return Circular(name: triangleType.rawValue)
            case .ellipsoid: return Circular(name: triangleType.rawValue)
            }
        }
    }
    
    class RectangleShapFactory: ShapFactory {
        override func createShap(type:ShapType) -> Shap {
            guard case let ShapType.rectangle(_triangleType) = type,let triangleType = RectangleType(rawValue: _triangleType) else {
                fatalError("\(self)类型错误\(type)")
            }
             
            switch triangleType {
            case .equilateral: return Rectangle(name: triangleType.rawValue)
            case .normal: return Rectangle(name: triangleType.rawValue)
            }
        }
    }
    
    let factory = ShapFactory()
    factory.createShap(type: .triangle(TriangleType.equilateral.rawValue))
    factory.createShap(type: .circular(CircularType.oval.rawValue)).draw()
    factory.createShap(type: .rectangle(RectangleType.equilateral.rawValue))
}

// Abstract factory pattern
protocol AbstractShapFactory {
    func createShap(type:ShapType) ->Shap
}

class TrangleShapFactory: AbstractShapFactory {
    func createShap(type:ShapType) -> Shap {
        guard case let ShapType.triangle(_triangleType) = type,let triangleType = TriangleType(rawValue: _triangleType) else {
            fatalError("\(self)类型错误\(type)")
        }
        
        switch triangleType {
        case .equilateral: return Triangle(name: triangleType.rawValue)
        case .normal: return Triangle(name: triangleType.rawValue)
        case .isosceles: return Triangle(name: triangleType.rawValue)
        }
    }
}

class CircularShapFactory: AbstractShapFactory {
    func createShap(type:ShapType) -> Shap {
        guard case let ShapType.circular(_triangleType) = type,let triangleType = CircularType(rawValue: _triangleType) else {
            fatalError("\(self)类型错误\(type)")
        }
        
        switch triangleType {
        case .oval: return Circular(name: triangleType.rawValue)
        case .ellipsoid: return Circular(name: triangleType.rawValue)
        }
    }
}

class RectangleShapFactory: AbstractShapFactory {
    func createShap(type:ShapType) -> Shap {
        guard case let ShapType.rectangle(_triangleType) = type,let triangleType = RectangleType(rawValue: _triangleType) else {
            fatalError("\(self)类型错误\(type)")
        }
         
        switch triangleType {
        case .equilateral: return Rectangle(name: triangleType.rawValue)
        case .normal: return Rectangle(name: triangleType.rawValue)
        }
    }
}


class DrawTools {
    let shapFactory:AbstractShapFactory
    init(shapFactory:AbstractShapFactory) {
        self.shapFactory = shapFactory
    }
    func draw(shap:ShapType){
        print("抽象工厂--")
        let shap = self.shapFactory.createShap(type: shap)
        shap.draw()
    }
}

let tools = DrawTools(shapFactory:RectangleShapFactory())
tools.draw(shap: .rectangle(RectangleType.equilateral.rawValue))

