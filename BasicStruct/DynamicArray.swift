import Foundation

protocol DynamicArrayProtocol {
    associatedtype T
    
    mutating func add(item: T, index: Int)
    mutating func remove(index: Int)
}

enum DynamicArray {
    
    case single
    case vector
    case factor
    case matrix
    
    func create<T>(size: Int, typeData: T.Type) -> any DynamicArrayProtocol {
        switch self {
        case .single:
            return SingleArray<T>(size: size)
        case .vector:
            return VectorArray<T>()
        case .factor:
            return FactorArray<T>()
        case .matrix:
            return MatrixArray<T>()
        }
    }
}

struct SingleArray<T>: DynamicArrayProtocol {
    
    let name: String = "Фиксированный массив"
    private var maxSize: Int
    private var currentIndex = 0
    private var storage: [T?]
    
    init(size: Int) {
        self.maxSize = size
        self.storage = Array(repeating: nil, count: size)
    }
    
    
    mutating func add(item: T, index: Int) {
        if currentIndex < maxSize {
            storage[index] = item
            currentIndex += 1
        } else {
            print("Массив заполнен! Невозможно добавить новый элемент")
        }
    }
    
    mutating func remove(index: Int) {
        guard index > 0 && index < maxSize else {
            print("Индекс выходит за пределы!")
            return
        }
        storage[index] = nil
        
        for i in index ..< maxSize - 1 {
            storage[i] = storage[i + 1]
        }
        
        storage[maxSize - 1] = nil
        currentIndex -= 1
    }
    
}

struct VectorArray<T>: DynamicArrayProtocol {
    
    let name: String = "Динамический массив + 1"
    private var storage: [T?]
    private var capacity: Int
    private(set) var count: Int
    
    init(initialCapacity: Int = 2) {
        self.capacity = max(1, initialCapacity)
        self.storage = Array(repeating: nil, count: capacity)
        self.count = 0
    }
    
    private mutating func resize() {
        capacity *= 2
        var newStorage = Array<T?>(repeating: nil, count: capacity)
        for i in 0..<count {
            newStorage[i] = storage[i]
        }
        storage = newStorage
    }
    
    mutating func add(item: T, index: Int = 0) {
        if count == capacity {
            resize()
        }
        storage[count] = item
        count += 1
    }
    
    mutating func remove(index: Int) {
        guard index >= 0 && index < count else {
            print("Индекс выходит за пределы массива")
            return
        }
        
        for i in index..<count - 1 {
            storage[i] = storage[i + 1]
        }
        storage[count - 1] = nil
        count -= 1
    }
}

struct FactorArray<T>: DynamicArrayProtocol {
    private var storage: [T?]
    private var capacity: Int
    private(set) var count: Int
    private let growthFactor: Double
    
    init(initialCapacity: Int = 2, growthFactor: Double = 1.5) {
        self.capacity = max(1, initialCapacity)
        self.storage = Array(repeating: nil, count: capacity)
        self.count = 0
        self.growthFactor = growthFactor
    }
    
    mutating func add(item: T, index: Int) {
        if count == capacity {
            resize()
        }
        storage[count] = item
        count += 1
    }
    
    private mutating func resize() {
        let newCapacity = Int(Double(capacity) * growthFactor)
        capacity = max(newCapacity, capacity + 1)
        var newStorage = Array<T?>(repeating: nil, count: capacity)
        for i in 0..<count {
            newStorage[i] = storage[i]
        }
        storage = newStorage
    }
    
    mutating func remove(index: Int) {
        guard index >= 0 && index < count else {
            print("Индекс выходит за пределы массива")
            return
        }
        
        for i in index..<count - 1 {
            storage[i] = storage[i + 1]
        }
        storage[count - 1] = nil
        count -= 1
    }
}

struct MatrixArray<T>: DynamicArrayProtocol {
    private var storage: [T] = []
    
    mutating func add(item: T, index: Int) {
        storage.append(item)
    }
    
    mutating func remove(index: Int) {
        guard index >= 0 && index < storage.count else {
            print("Индекс выходит за пределы массива")
            return
        }
        storage.remove(at: index)
    }
}

