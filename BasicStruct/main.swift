import Foundation

// Функция для замера времени выполнения
func measureTime(_ block: () -> Void) -> TimeInterval {
    let startTime = CFAbsoluteTimeGetCurrent()
    block()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return timeElapsed
}

// Функция для тестирования производительности
func testPerformance<T: DynamicArrayProtocol>(arrayInstance: inout T) where T.T == Int {
    print("Тест производительности для типа: \(T.self)")
    
    let timeElapsed = measureTime {
        for i in 0..<1_000_000 {
            arrayInstance.add(item: i, index: i)
        }
    }
    print("N = 1_000_000, Время выполнения: \(timeElapsed) секунд")
}

// Примеры использования для каждого типа массива
var singleArrayInstance = SingleArray<Int>(size: 1_000_000)
testPerformance(arrayInstance: &singleArrayInstance)
 var vectorArrayInstance = VectorArray<Int>()
 testPerformance(arrayInstance: &vectorArrayInstance)
 var factorArrayInstance = FactorArray<Int>()
 testPerformance(arrayInstance: &factorArrayInstance)
 var matrixArrayInstance = MatrixArray<Int>()
 testPerformance(arrayInstance: &matrixArrayInstance)
