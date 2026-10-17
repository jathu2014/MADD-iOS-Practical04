
import SwiftUI

struct ContentView: View {

    @State private var studentName = ""
    @State private var studentMark = ""
    @State private var students: [Student] = []
    @State private var showAlert = false
    @State private var alertMessage = ""

    var passedCount: Int {
        students.filter { $0.isPassed }.count
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                Text("SE4041 Marks")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Student Marks Management")
                    .foregroundColor(.secondary)

                VStack(spacing: 12) {
                    TextField("Student Name", text: $studentName)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.words)

                    TextField("Student Mark (0-100)", text: $studentMark)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)

                    Button(action: addStudent) {
                        Text("Add Student")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Students")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("\(students.count)")
                            .font(.title2)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("Passed Students")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("\(passedCount)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                HStack {
                    Text("Student List")
                        .font(.headline)

                    Spacer()
                }

                List(students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(student.name)
                                    .font(.headline)

                                Text("Mark: \(student.mark)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Text(student.result)
                                .fontWeight(.semibold)
                                .foregroundColor(
                                    student.isPassed ? .green : .red
                                )
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)

                Spacer(minLength: 0)
            }
            .padding()
            .navigationTitle("Marks")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Validation Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    func addStudent() {
        let name = studentName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !name.isEmpty else {
            alertMessage = "Please enter a student name."
            showAlert = true
            return
        }

        guard let mark = Int(studentMark),
              mark >= 0,
              mark <= 100 else {
            alertMessage = "Please enter a valid mark between 0 and 100."
            showAlert = true
            return
        }

        let newStudent = Student(name: name, mark: mark)
        students.append(newStudent)

        studentName = ""
        studentMark = ""
    }
}
