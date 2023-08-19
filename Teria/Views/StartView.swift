import SwiftUI

struct StartView: View {
    @State var isModal: Bool = false
    @State private var isOnDismiss: Bool = false
    @AppStorage("schoolName") private var name: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                VStack(alignment: .center) {
                    Text("👋")
                        .font(.system(size: 100))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -10, trailing: 0))

                    LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 146 / 255, blue: 140 / 255), Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask(
                            VStack(alignment: .center) {
                                Text("iOS에서 쉽고 빠르게")
                                    .font(.system(size: 30.5, weight: .medium))
                                Text("급식을 확인하기")
                                    .font(.system(size: 40, weight: .bold))
                            }
                        )
                        .frame(height: 100)
                }
                
                Spacer(minLength: 200)

                LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 146 / 255, blue: 140 / 255), Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .overlay(
                        Button {
                            isModal = true
                        } label: {
                            Text("시작하기")
                                .font(.system(size: 22, weight: .black))
                                .frame(width: 100)
                                .foregroundColor(Color.white)
                        }
                    )
                    .frame(width: 360, height: 70)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
                .sheet(isPresented: $isModal, onDismiss: {
                    if name != "" {
                        isOnDismiss = true
                    }
                }) {
                    SelectView(isModal: self.$isModal)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.medium])
                }
                .background(
                    NavigationLink(destination: MainView(school: "", breakfast: [], lunch: [], dinner: [], dateAdd: 0), isActive: $isOnDismiss) {
                        EmptyView()
                    }
                )
                .onAppear {
                    UserDefaults.standard.set("", forKey: "schoolName")
                    UserDefaults.standard.synchronize()
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
