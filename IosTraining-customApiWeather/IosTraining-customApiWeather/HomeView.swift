    //
    //  HomeView.swift
    //  IosTraining-customApiWeather
    //
    //  Created by 岡優志 on 2021/04/23.
    //
    
    import SwiftUI
    import YumemiWeather
    
    struct HomeView: View {
        
        @State var weatherImageName = "sunny"
        @State var maxtemp = 10
        @State var mintemp = -10
        @State var weatherDate = Date()
        @State var imageColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        @State var showAlert = false
        @State var errorMessage = ""
        
        let halfWidth:CGFloat = UIScreen.main.bounds.width * 0.5
        var body: some View {
            VStack(spacing: 0.0) {
                VStack(spacing: 0.0){
                   
                    //天気のイメージ写真
                    Image(weatherImageName)
                        .resizable()
                        .foregroundColor(Color(imageColor))
                        .frame(width:halfWidth, height:halfWidth)
                    //最高気温と最低気温の表示(未実装)
                    HStack(spacing: 0.0) {
                        Text("\(mintemp)")
                            .font(.custom("Antonio", size: 36))
                            .fontWeight(.thin)
                            .foregroundColor(.blue)
                            .frame(width: halfWidth * 0.5)
                        Text("\(maxtemp)")
                            .font(.custom("Antonio", size: 36))
                            .fontWeight(.thin)
                            .foregroundColor(Color.red)
                            .frame(width: halfWidth * 0.5)
                    }
                    .frame(width: halfWidth)
                }
                .padding(.bottom, 80)
                //リロード処理と遷移(未実装)のボタン
                HStack(spacing: 0.0){
                    Button(action: {}) {
                        Text("Close")
                    }
                    .frame(width: halfWidth * 0.5)
                    
                    Button(action: {
                        do {
                            let json = "{\"area\":\"tokyo\",\"date\":\"2020-04-01T12:00:00+09:00\"}"
                            let decoder: JSONDecoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let decoded: WeatherData = try decoder.decode(WeatherData.self, from: YumemiWeather.fetchWeather(json).data(using: .utf8)!)
                            weatherImageName = decoded.weather
                            maxtemp = decoded.max_temp
                            mintemp = decoded.min_temp
                            weatherDate = decoded.date
                            
                        } catch YumemiWeatherError.unknownError {
                            showAlert = true
                            errorMessage = "エラー(1)です。"
                        } catch YumemiWeatherError.invalidParameterError{
                            showAlert = true
                            errorMessage = "エラー(2)です。"
                        }catch {
                            showAlert = true
                            errorMessage = "エラー(3)です。"
                            print(error.localizedDescription)
                        }
                   
                        
                        switch weatherImageName {
                        case "sunny":
                            imageColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                        case "rainy":
                            imageColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
                        default:
                            imageColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                    }) {
                        Text("Reload")
                    }
                    .frame(width: halfWidth * 0.5)
                    //アラート処理
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("エラー"),
                              message: Text("\(errorMessage)"),
                              dismissButton: .default(Text("OK")))
                    }
                }
                .frame(width: halfWidth)
            }
            .offset(y: 40)
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
