import SwiftUI

struct ProfileView: View {
    let cat: Cat 

    var body: some View {
        GeometryReader { geo in
            ZStack {
                   
                    Color("background")
                        .ignoresSafeArea()
                    
                    Image("catpaws")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                    
                    VStack(spacing: 10) {
                    
                        CachedAsyncImage(url: cat.url)
                            .frame(width: 250, height: 250)
                            .cornerRadius(10)
                            .padding(.top)
                            .shadow(radius: 5)
                        
                      
                        if let breed = cat.breeds?.first {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Breed: \(breed.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Temperament: \(breed.temperament)")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Origin: \(breed.origin)")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Country Code: \(breed.country_code)")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Life Span: \(breed.life_span) years")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Weight (Imperial): \(breed.weight.imperial) lbs")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                                Text("Weight (Metric): \(breed.weight.metric) kg")
                                    .font(.body)
                                    .foregroundColor(Color("selected"))
                                
                              
                                if let url = URL(string: breed.wikipedia_url) {
                                    Link("Learn more on Wikipedia", destination: url)
                                        .font(.body)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .padding(.horizontal)
                        } else {
                            Text("No breed information available.")
                                .font(.body)
                                .foregroundColor(Color("selected"))
                        }
                    }.background(Color("listbg"))
                    .cornerRadius(12)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

#Preview {
    ProfileView(cat: Cat(
        id: "1",
        width: 300,
        height: 400,
        url: "https://example.com/cat.jpg",
        breeds: [
            Breed(
                id: "abys",
                name: "Abyssinian",
                temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                origin: "Egypt",
                country_codes: "EG",
                country_code: "EG",
                life_span: "14 - 15",
                wikipedia_url: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
                weight: Weight(imperial: "7 - 10", metric: "3 - 5")
            )
        ]
    ))
}
