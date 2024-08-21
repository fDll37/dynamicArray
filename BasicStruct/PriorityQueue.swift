import Foundation

//Варианты реализации - список списков, массив списков

//enqueue(int priority, T item) - поместить элемент в очередь
//T dequeue() - выбрать элемент из очереди

protocol PriorityQueueProtocol {
    associatedtype T
    
    func enqueue(priority: Priority, item: T)
    func dequeue() -> T?
}

enum Priority: Int {
    case low = 1
    case medium = 2
    case high = 3
}

class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}




class PriorityQueue<T>: PriorityQueueProtocol {
    
    private var valuesHead: Node<T>?
    private var prioritiesHead: Node<Priority>?
    private var count: Int = 0
    
    func enqueue(priority: Priority, item: T) {
        var newValueNode = Node(value: item)
        var newPrioritiesNode = Node(value: priority)
        
        count += 1
        if valuesHead == nil {
            valuesHead = newValueNode
            prioritiesHead = newPrioritiesNode
        } else {
            var currentValuesNode = valuesHead
            var currentPrioritiesNode = prioritiesHead
            
            var previousValuesNode: Node<T>? = nil
            var previousPrioritiesNode: Node<Priority>? = nil
            
            while currentValuesNode != nil && currentPrioritiesNode!.value.rawValue > priority.rawValue {
                previousValuesNode = currentValuesNode
                previousPrioritiesNode = currentPrioritiesNode
                
                currentValuesNode = currentValuesNode?.next
                currentPrioritiesNode = currentPrioritiesNode?.next
            }
            
            if previousValuesNode == nil {
                newValueNode.next = valuesHead
                newPrioritiesNode.next = prioritiesHead
                
                valuesHead = newValueNode
                prioritiesHead = newPrioritiesNode
            } else {
                newValueNode.next = currentValuesNode!
                newPrioritiesNode.next = currentPrioritiesNode!
                
                previousValuesNode?.next = newValueNode
                previousPrioritiesNode?.next = newPrioritiesNode
            }
        }
    }
    
    func dequeue() -> T? {
        guard let valueNode = valuesHead else {
            return nil
        }
        
        let value = valueNode.value
        valuesHead = valueNode.next
        prioritiesHead = prioritiesHead?.next
        
        return value
    }
    
}



