
import Foundation

struct Student: Identifiable {
    let id = UUID()
    let name: String
    let mark: Int

    var isPassed: Bool {
        mark >= 50
    }

    var result: String {
        isPassed ? "Pass" : "Fail"
    }
}
