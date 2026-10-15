import SwiftUI

struct StudentDetailView: View {
    let student: Student

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)

            Text(student.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 12) {
                Text("Student Mark")
                    .font(.headline)

                Text("\(student.mark)/100")
                    .font(.system(size: 40, weight: .bold))

                Text(student.result)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(
                        student.isPassed ? .green : .red
                    )
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)

            Spacer()
        }
        .padding()
        .navigationTitle("Student Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
