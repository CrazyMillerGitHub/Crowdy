//
//  NetworkView.swift
//  
//
//  Created by Mikhail Borisov on 22.03.2022.
//

import SwiftUI

struct NetworkView: View {

    var hosts: [String] = [
        "crowdy.com",
        "localhost",
        "test.crowdy.com"
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(hosts, id: \.self) { host in
                    Text(host)
                        .padding()
                        .onTapGesture {
                            debugPrint("\(host) tapped")
                        }
                }
            }
            .navigationTitle("Хост приложения")
        }
    }
}

struct NetworkView_Preview: PreviewProvider {

    static var previews: some View {
        NetworkView()
    }
}
