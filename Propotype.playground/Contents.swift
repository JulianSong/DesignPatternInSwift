import Foundation

do{
    struct Config {
        let appKey = "a app key"
        let version = "1.0.0"
        var agent = "Jerry"
        static let propotype = Config()
    }
    
    var config = Config.propotype
    config.agent = "Marry"
    var model2Config = Config.propotype
    model2Config.agent = "Tom"
    print(config)
    print(model2Config)
}

protocol Copyable {
    init(instance: Self)
}

extension Copyable {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}

class Config:Copyable {
    let appKey = "a app key"
    let version = "1.0.0"
    var agent = "Jerry"
    static let propotype = Config()
    init() {}
    required init(instance: Config) {
        self.agent = instance.agent
    }
}

var config = Config.propotype.copy()
config.agent = "Marry"
var model2Config = Config.propotype.copy()
model2Config.agent = "Tom"
print(config)
print(model2Config.agent)

