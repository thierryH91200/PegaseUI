//
//  CategorieBar1View.swift
//  PegaseUI
//
//  Created by Thierry hentic on 31/10/2024.
//

import SwiftUI

struct CategorieBar1View: View {
    
    @Binding var isVisible: Bool
    
    var body: some View {
        Text("CategorieBar1View")
            .font(.title)
            .padding()
            .task {
                await performFalseTask()
            }
    }
    
    private func performFalseTask() async {
        // Exécuter une tâche asynchrone (par exemple, un délai)
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 seconde de délai
        isVisible = false
    }

}
