import SwiftUI

struct MainView: View {
    @State var current: Int = 0
    @State var selected: Gradient = Gradient(colors: [Color(red: 255 / 255, green: 146 / 255, blue: 140 / 255), Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)])
    @State var unselected: Gradient = Gradient(colors: [Color(red: 255 / 255, green: 196 / 255, blue: 190 / 255), Color(red: 50 / 255, green: 172 / 255, blue: 255 / 255)])
    @AppStorage("schoolName") private var name: String = ""
    @State var school: String
    @State var breakfast: [String]
    @State var lunch: [String]
    @State var dinner: [String]

    var body: some View {
        VStack {
            
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
                                        .edgesIgnoringSafeArea(.all)
                                        .frame(width: 260, height: 200)
                    .rotationEffect(Angle(degrees: current == 0 ? 0 : (current == 1 ? 90 : 0)))
                    .animation(.easeInOut, value: true)
            }
            .padding(EdgeInsets.init(top: -15, leading: 0, bottom: 5, trailing: 0))

            // Date
            
            
            // Meal Info
            List {
                if current == 0 {
                    if breakfast != [] {
                        ForEach(breakfast, id: \.self) { item in
                            LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask(
                                    Text("\(item.split(separator: " ").map({String($0)})[0])")
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                )
                        }
                    } else {
                        LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Text("오늘은 아침이 없는 것 같아요.")
                                    .font(.system(size: 20, weight: .bold))
                            )
                    }
                } else if current == 1 {
                    if (lunch != []) {
                        ForEach(lunch, id: \.self) { item in
                            LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask(
                                    Text("\(item.split(separator: " ").map({String($0)})[0])")
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                )
                        }
                    } else {
                        LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Text("오늘은 점심이 없는 것 같아요.")
                                    .font(.system(size: 20, weight: .bold))
                            )
                    }
                } else {
                    if (dinner != []) {
                        ForEach(dinner, id: \.self) { item in
                            LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask(
                                    Text("\(item.split(separator: " ").map({String($0)})[0])")
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                )
                        }
                    } else {
                        LinearGradient(gradient: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Text("오늘은 점심이 없는 것 같아요.")
                                    .font(.system(size: 20, weight: .bold))
                            )
                    }
                }
            }
            .cornerRadius(20)
            .frame(width: 300, height: 300)
            .listStyle(PlainListStyle())

            Spacer(minLength: 100)

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
//            .gesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                    .onEnded({ value in
//                        if value.translation.width > 20 {
//                            if current > 0 {
//                                withAnimation {
//                                    current -= 1
//                                }
//                            }
//                        }
//                        if value.translation.width < 20 {
//                            if current < 2 {
//                                withAnimation {
//                                    current += 1
//                                }
//                            }
//                        }
//                        if value.translation.height < 20 {
//                            print("DOWN!!")
//                        }
//                    })
//            )
            .onAppear {
                MealService.getSchool(schoolName: name) {(resp) in
                    MealService.getMeal(ATPT_OFCDC_SC_CODE: resp["ATPT_OFCDC_SC_CODE"].stringValue, SD_SCHUL_CODE: resp["SD_SCHUL_CODE"].stringValue) {(resp) in
                        school = resp[0]["SCHUL_NM"].stringValue
                        
                        var str: String = resp[0]["DDISH_NM"].stringValue
                        breakfast = str.split(separator: "<br/>").map({String($0)})
                        
                        str = resp[1]["DDISH_NM"].stringValue
                        lunch = str.split(separator: "<br/>").map({String($0)})
                        
                        str = resp[2]["DDISH_NM"].stringValue
                        dinner = str.split(separator: "<br/>").map({String($0)})
                        
                        print(breakfast.split(separator: "<br/>"))
                    }
                }
            }
            .navigationBarTitle(school)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(school: "", breakfast: [], lunch: [], dinner: [])
    }
}
