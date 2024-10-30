//
//  exemple4.swift
//  PegaseUI
//
//  Created by Thierry hentic on 27/10/2024.
//

import SwiftUI

struct ContentView100: View {
    @State private var selection1: String? = "John" // Sélection pour la première barre latérale
    @State private var selection2: String? = "Liste des transactions" // Sélection pour la deuxième barre latérale
    
    @State private var isVisible: Bool = true
    
    var body: some View {
        HStack
        {
            NavigationSplitView {
                SidebarContainer(selection1: $selection1, selection2: $selection2)
            }
            detail :
            {
                DetailContainer(selection2: $selection2)
            }
            if isVisible
            {
                Spacer(minLength: 10)
                OperationDialog()
                    .frame (
                        minWidth:100,
                        idealWidth: 150,
                        maxWidth: 200
                    )
                Spacer(minLength: 10)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button(action: {
                    print("Nouvel élément ajouté")
                }) {
                    Label("Ajouter", systemImage: "plus")
                }
                
                Button(action: {
                    print("Recherche effectuée")
                }) {
                    Label("Rechercher", systemImage: "magnifyingglass")
                }
                
                Spacer()
                
                Button(action: {
                    print("Paramètres ouverts")
                }) {
                    Label("Paramètres", systemImage: "gear")
                }
                Toggle(isOn: $isVisible) {
                    Image(systemName: "sidebar.trailing")
                }
                .toggleStyle(.button)
                .keyboardShortcut("r", modifiers: .command)
                
            }
        }
    }
}

struct SidebarContainer: View {
    @Binding var selection1: String?
    @Binding var selection2: String?
    
    var body: some View {
        VStack(spacing: 0) {
            Sidebar1A(selection1: $selection1)
            Divider()
            Sidebar2A(selection2: $selection2)
        }
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
    }
}

struct DetailContainer: View {
    @Binding var selection2: String?
    
    var body: some View {
        VStack {
            if let selected2 = selection2 {
                switch selected2 {
                case "Liste des transactions":
                    ContentView10()
                default:
                    Text("Content pour Sidebar 2 \(selected2)")
                }
            }
        }
    }
}

struct SidebarDialogView: View {
    var body: some View {
        Spacer(minLength: 10)
        OperationDialog()
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200)
        Spacer(minLength: 10)
    }
}

struct DetailView1: View {
    var selectedItem: String
    
    var body: some View {
        Text("Détails pour Sidebar 1 : \(selectedItem)")
            .frame(maxWidth: 200)
    }
}

struct DetailView2: View {
    var selectedItem: String
    
    var body: some View {
        Text("Détails pour Sidebar 2 : \(selectedItem)")
            .frame(maxWidth: 200)
    }
}

struct Sidebar1A: View {
    
    @Binding var selection1: String?
    
    var body: some View {
        
        let accounts = Bundle.main.decode([Accounts].self, from: "Account.plist" )
        
        List(selection: $selection1) {
            ForEach(accounts) { section in
                Section(localizeString(section.name)) {
                    ForEach(section.children) { child in
                        NavigationLink(value: child.name) {
                            Label(localizeString(child.name), systemImage: child.icon).tag(child.name)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .navigationTitle("Account")
        .listStyle(SidebarListStyle())
        .frame(maxHeight: 200) // Pour ajuster la hauteur de la première barre latérale
        
        Bouton()
    }
}

struct Sidebar2A: View {
    
    @Binding var selection2: String?
    
    var body: some View {
        
        let datas = Bundle.main.decode([Datas].self, from: "Feeds.plist" )
        
        List(selection: $selection2) {
            ForEach(datas) { section in
                Section(localizeString(section.name)) {
                    ForEach(section.children) { child in
                        Label(localizeString(child.name), systemImage: child.icon).tag(child.name)
                            .font(.title2)
                    }
                }
            }
        }
        .navigationTitle("Affichage")
        .listStyle(SidebarListStyle())
        .frame(maxHeight: .infinity) // Prend toute la place disponible
    }
}

struct Bouton: View {
    
    @State private var selectedOption = ""
    
    var body: some View {
        
        let UUID : UUID = UUID()
        
        HStack {
            // Bouton "Moins"
            Button(action: {
                print("Bouton moins appuyé")
            }) {
                Image(systemName: "minus.circle")
                    .font(.system(size: 16))
            }
            
            Spacer()
            
            // Pop-up bouton (Menu)
            Menu {
                Button("", action: { selectedOption = "" })
                Button("Add Group Account", action: { selectedOption = "Add Group Account" })
                Button("Add Account", action: { selectedOption = "Add Account" })
            } label: {
                Label(selectedOption, systemImage: "ellipsis.circle")
                    .font(.system(size: 16))
            }
            
            Spacer()
            
            // Bouton Cadenas
            Button(action: {
                print(UUID)
            }) {
                Image(systemName: "lock")
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

