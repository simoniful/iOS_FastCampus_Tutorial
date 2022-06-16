//
//  Practice_2.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import Foundation

import UIKit

let navigationController = UINavigationController(rootViewController: SampleViewController())

final class SampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sample"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "house.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton))
    }
    
    @objc private func didTapRightBarButton() {
        print("RightBarButton Tapped!")
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

import SwiftUI

struct SampleView: View {
    var body: some View {
        Text("SampleView")
    }
}

struct SampleNavigationView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Push Button", destination: SampleView())
            }
                .navigationTitle("Sample")
                .navigationBarItems(
                    trailing: Button(
                        action: {
                            print("RightBarButton Tapped!")
                        },
                        label: {
                            Image(systemName: "house.fill")
                        }
                    )
                )
        }
    }
}

struct SampleNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SampleNavigationView()
    }
}



