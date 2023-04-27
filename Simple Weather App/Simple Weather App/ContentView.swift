//
//  ContentView.swift
//  Simple Weather App
//
//  Created by Jude Sztraicher on 1/5/23.
//

import SwiftUI
struct Weather: Codable{
    var temperature:String
    var description:String
}

struct ContentView: View {
    @State var weather:Weather = Weather(temperature:"", description:"")
    @State var weatherIcon = "globe"
    var body: some View{
        VStack{
            Image(systemName: weatherIcon)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button ("Get LA Weather!"){
                print("Fetching Weather!")
                loadURL()
            }
            Divider()
            Text(weather.temperature)
            Text(weather.description)
        }
        
        .padding()
        
    }
    
    func loadURL(){
        let url = URL(string: "https://goweather.herokuApp.com/weather/LosAngeles")!
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with:request)
        {data, response, error in
            if let data = data {
//                let weatherString = String(data:data, encoding: .utf8)!
//                print(weatherString)
                weather = try! JSONDecoder().decode(Weather.self, from: data)
                if weather.description.contains("drizzle"){
                    weatherIcon = "cloud.rain"
                }
                else if weather.description.contains("sun"){
                    weatherIcon = "sun.max"
                }
                
            }
            else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }
        task.resume()
    }
}

struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
