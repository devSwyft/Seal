import SwiftUI

struct MainView: View {
    @State var current: Int = 0
    @State var selected: Gradient = Gradient(colors: [Color(red: 255 / 255, green: 146 / 255, blue: 140 / 255), Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)])
    @State var unselected: Gradient = Gradient(colors: [Color(red: 255 / 255, green: 196 / 255, blue: 190 / 255), Color(red: 50 / 255, green: 172 / 255, blue: 255 / 255)])
    @AppStorage("schoolName") private var name: String = ""
    @State var school: String

    var body: some View {
        VStack {
            NavigationView {
                Text(school)
            }

            // Top Icon
            ZStack {
                VStack {
                    LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask(Image(systemName: current == 0 ? "sun.and.horizon.circle.fill" : (current == 1 ? "sun.max.circle.fill" : "moon.circle.fill"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                        )
                }
                    //                    .edgesIgnoringSafeArea(.all)
                    .frame(width: 260)
                    .rotationEffect(Angle(degrees: current == 0 ? 0 : (current == 1 ? 90 : 0)))
                    .animation(.easeInOut, value: true)
            }

            // Meal Info
            VStack(alignment: .leading) {
                LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask(Text("- 밥").font(.system(size: 26, weight: .bold)))
//                if (data != nil) {
//                    Text("DATA!")
//                } else {
//                    Text("Loading...")
//                }
            }
                .frame(width: 300)

            Spacer(minLength: 300)

            // Bottom Menu
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            current = 0
                        }
                    } label: {
                        LinearGradient(gradient: current == 0 ? selected : unselected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(Image(systemName: "sun.and.horizon.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: current == 0 ? 50 : 40)
                            )
                    }
                        .frame(height: 50)

                    Button {
                        withAnimation {
                            current = 1
                        }
                    } label: {
                        LinearGradient(gradient: current == 1 ? selected : unselected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(Image(systemName: "sun.max.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: current == 1 ? 50 : 40)
                            )
                    }
                        .frame(height: 50)

                    Button {
                        withAnimation {
                            current = 2
                        }
                    } label: {
                        LinearGradient(gradient: current == 2 ? selected : unselected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(Image(systemName: "moon.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: current == 2 ? 50 : 40)
                            )
                    }
                        .frame(height: 50)
                }
            }
        }
            .padding()
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width > 20 {
                            if current > 0 {
                                withAnimation {
                                    current -= 1
                                }
                            }
                        }
                        if value.translation.width < 20 {
                            if current < 2 {
                                withAnimation {
                                    current += 1
                                }
                            }
                        }
                        if value.translation.height < 20 {
                            print("DOWN!!")
                        }
                    })
            )
            .onAppear {
                MealAPI.getSchool(schoolName: name) {(resp) in
                    print(resp)
                    school = resp["SCHUL_NM"].stringValue
                }
            }
            .navigationBarTitle(name)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(school: "")
    }
}
