import Foundation


class Main {
    
    private init() {}
    
    // Функция для замера времени выполнения
    private static func measureTime(_ block: () -> Void) -> TimeInterval {
        let startTime = CFAbsoluteTimeGetCurrent()
        block()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return timeElapsed
    }

    // Функция для тестирования производительности
   private static func testPerformance<T: DynamicArrayProtocol>(arrayInstance: inout T, size: Int) where T.T == Int {
        let timeElapsed = measureTime {
            for i in 0..<size {
                arrayInstance.add(item: i, index: i)
            }
        }
        print("Для типа: \(T.self) Время выполнения: \(timeElapsed) секунд")
    }


    static func testArray() {
        let sizeTest = [100, 100_000, 1_000_000, 500_000]

        // тесты на добавление разного количества элементов
        for size in sizeTest {
            print("Тестирование на добавление N = \(size) элементов")
            
            var singleArrayInstance = SingleArray<Int>(size: 1_000_000)
            testPerformance(arrayInstance: &singleArrayInstance, size: size)
            var vectorArrayInstance = VectorArray<Int>()
            testPerformance(arrayInstance: &vectorArrayInstance, size: size)
            var factorArrayInstance = FactorArray<Int>()
            testPerformance(arrayInstance: &factorArrayInstance, size: size)
            var matrixArrayInstance = MatrixArray<Int>()
            testPerformance(arrayInstance: &matrixArrayInstance, size: size)
        }
    }

    static func testPriorityQueue() {
        var priorityQueue = PriorityQueue<String>()
        priorityQueue.enqueue(priority: .low, item: "Low priority")
        priorityQueue.enqueue(priority: .high, item: "High priority")
        priorityQueue.enqueue(priority: .medium, item: "Medium priority")

        print(priorityQueue.dequeue() ?? "Queue is empty") // "High priority"
        print(priorityQueue.dequeue() ?? "Queue is empty") // "Medium priority"
        print(priorityQueue.dequeue() ?? "Queue is empty") // "Low priority"
        print(priorityQueue.dequeue() ?? "Queue is empty") // "Queue is empty"
    }

}


Main.testPriorityQueue()
