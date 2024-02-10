## Hello folks!

I invite you to familiarize yourself with the CityWeather project. It is a mobile application for iOS devices that was written reactively using RxSwift and SwiftUI. Due to the technology used and its simplicity, I used the controversial MV pattern, i.e. the Model-View pattern.

The main data source is the WeatherModel, which is responsible for providing data for the entire application. For iPhone devices there are two views, main and detailed. A separate main view has been written for iPads. It should be mentioned that both of them use common components