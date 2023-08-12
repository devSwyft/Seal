import SwiftUI

struct SelectView: View {
    @State var name: String = ""
    @State var status: Bool = false
    @Binding var isModal: Bool

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 136 / 255, blue: 130 / 255), Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask(
                        Text("학교명만 입력하면 끝이에요.")
                            .font(.system(size: 22, weight: .medium)
                            ))
                    .frame(height: 150)

                LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 136 / 255, blue: 130 / 255), Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask(
                        Text("학교명")
                            .font(.system(size: 20, weight: .medium)
                            ))
                    .frame(width: 60, height: 20)

                TextField("경북소프트웨어고등학교", text: $name)
                    .padding()
                    .background(Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255))
                    .cornerRadius(16)

                Text(status ? "학교명을 입력해주세요." : "")
                    .foregroundColor(Color.red)
                    .font(.system(size: 15))

                Spacer()
            }
                .frame(width: 250)

            LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 146 / 255, blue: 140 / 255), Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .overlay(
                    Button {
                        if name == "" {
                            UserDefaults.standard.set("", forKey: "schoolName")
                            UserDefaults.standard.synchronize()

                            status = true
                        } else {
                            UserDefaults.standard.set(name, forKey: "schoolName")
                            UserDefaults.standard.synchronize()

                            status = false
                            isModal = false
                        }
                    } label: {
                        Text("확인")
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(Color.white)
                            .frame(width: 400)
                    }
                )
                .frame(height: 80)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -35, trailing: 0))
        }
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView(isModal: Binding.constant(true))
    }
}
