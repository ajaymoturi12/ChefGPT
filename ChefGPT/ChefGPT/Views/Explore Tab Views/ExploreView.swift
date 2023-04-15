//
//  ExploreView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI
struct Item: Hashable {
    let name: String = "Placeholder"
    let category: String
}

struct ExploreView: View {
    @State private var showingfilterBar = false
    // content
        private let content: [Item] = [
            Item(category: "Food"),
            Item(category: "Vegan"),
            Item(category: "Chinese"),
            Item(category: "Cuisine"),
            Item(category: "Itallian"),
        ]
    
    // current filter
    @State private var filter: String = ""
    
    @EnvironmentObject var model: Model
    
    var body: some View {
          VStack(spacing: 0) {
              Button("Show Sheet") {
                  showingfilterBar.toggle()
              }
              .sheet(isPresented: $showingfilterBar) {
                  filterBar()
              }
              filters
              Divider()
                  .padding(.horizontal)
              filteredContent
          }
      }
      
      var filters: some View {
          ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                  Button(action: {
                      withAnimation {
                          self.filter = ""
                      }
                  }) {
                      Text("All")
                          .padding(7)
                          .padding(.horizontal)
                          .background(
                              Rectangle()
                                  .cornerRadius(5)
                                  .foregroundColor(self.filter.isEmpty ? nil : Color(uiColor: .placeholderText))
                                  .opacity(1/4)
                          )
                  }
                  ForEach(self.content.map({$0.category}).unique(), id: \.self) { category in
                      Button(action: {
                          withAnimation {
                              self.filter = category
                          }
                      }) {
                          Text(category)
                              .padding(7)
                              .padding(.horizontal)
                              .background(
                                  Rectangle()
                                      .cornerRadius(5)
                                      .foregroundColor(self.filter == category ? nil : Color(uiColor: .placeholderText))
                                      .opacity(1/4)
                              )
                      }
                  }
              }
              .padding()
          }
      }
      
      var filteredContent: some View {
          ScrollView {
              VStack {
                  ForEach(self.filter.isEmpty ? self.content : self.content.filter({$0.category == self.filter}), id: \.self) { item in
                      HStack {
                          Text(item.name)
                          Spacer()
                          Text(item.category)
                      }
                      .padding()
                      .transition(
                          .asymmetric(
                              insertion: .move(edge: .trailing).combined(with: .opacity),
                              removal: .move(edge: .leading).combined(with: .opacity)
                          )
                      )
                  }
              }
          }
      }
      
  }


struct filterBar: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}

  // converts array to uniques
  extension Sequence where Iterator.Element: Hashable {
      func unique() -> [Iterator.Element] {
          var seen: Set<Iterator.Element> = []
          return filter { seen.insert($0).inserted }
      }
  }


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
