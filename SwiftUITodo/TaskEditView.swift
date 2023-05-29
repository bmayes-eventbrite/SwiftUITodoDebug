import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var userData: UserData
    private let task: Task
    @Binding private var draftTitle: String

    init(task: Task, draftTitle: Binding<String>) {
        self.task = task
        self._draftTitle = draftTitle
    }

    var body: some View {
        let inset = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        return VStack(alignment: .leading, spacing: 0) {
            TextField("", text: self.$draftTitle, onEditingChanged: { isEditing in
                self.updateTask()
            }, onCommit: {})
            .textFieldStyle(RoundedBorderTextFieldStyle()) // Use textFieldStyle to set the placeholder style
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 1 / UIScreen.main.scale)
                    )
                    .padding(inset)
            )
            .padding(EdgeInsets(
                top: 15 - inset.top,
                leading: 20 - inset.leading,
                bottom: 15 - inset.bottom,
                trailing: 20 - inset.trailing
            ))

            Spacer()
        }
        .navigationBarTitle(Text("Edit Task 📝"))
    }

    private func updateTask() {
        guard let index = self.userData.tasks.firstIndex(of: self.task) else { return }
        self.userData.tasks[index].title = self.draftTitle
    }
}
