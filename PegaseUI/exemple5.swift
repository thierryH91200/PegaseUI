import SwiftUI

struct Account: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let accountType: String
    let holderName: String
    let accountNumber: String
    let balance: String
}

struct ContentView1000: View {
    // Liste des comptes bancaires
    let accounts = [
        Account(iconName: "building.columns", accountType: "Compte courant", holderName: "John Doe", accountNumber: "00045700E", balance: "1622,66 €"),
        Account(iconName: "building.columns", accountType: "Compte courant", holderName: "Marie Martin", accountNumber: "00045701F", balance: "0,00 €"),
        Account(iconName: "creditcard", accountType: "Carte bancaire card", holderName: "Pierre Martin", accountNumber: "00045702G", balance: "0,00 €"),
        Account(iconName: "dog", accountType: "Epargne", holderName: "Jean Durand", accountNumber: "00045703H", balance: "0,00 €"),
        Account(iconName: "building.columns", accountType: "Compte courant", holderName: "Jean Durand", accountNumber: "00045704J", balance: "0,00 €"),
        Account(iconName: "creditcard", accountType: "Carte bancaire card", holderName: "Jean Durand", accountNumber: "00045705K", balance: "0,00 €")
    ]
    
    @State private var selectedAccount: Account? // Variable pour suivre l'élément sélectionné

    var body: some View {
        NavigationSplitView {
            SidebarView(accounts: accounts, selectedAccount: $selectedAccount)
        } detail: {
            if let account = selectedAccount {
                AccountDetailView(account: account)
            } else {
                Text("Sélectionnez un compte pour voir les détails")
                    .font(.title)
//                    .foregroundColor(.gray)
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

struct SidebarView: View {
    let accounts: [Account]
    @Binding var selectedAccount: Account?

    var body: some View {
        List(selection: $selectedAccount) {
            // Première section
            
            Section(header: SectionHeaderView(title: "Compte bancaire", count: "4 comptes", balance: "1622,66 €")) {
                ForEach(accounts.prefix(4)) { account in
                    AccountRowView(account: account)
                        .tag(account) // Permet la sélection de l'élément
                }
            }
            
            // Deuxième section
            Section(header: SectionHeaderView(title: "Compte bancaire", count: "2 comptes", balance: "0,00 €")) {
                ForEach(accounts.suffix(2)) { account in
                    AccountRowView(account: account)
                        .tag(account)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color(.systemGray))
    }
}

// Vue pour l'en-tête de section
struct SectionHeaderView: View {
    let title: String
    let count: String
    let balance: String
    
    var body: some View {
        HStack {
            Image(systemName: "folder.fill")
                .foregroundColor(.orange)
            Text(title)
                .font(.headline)
            Text(count)
                .foregroundColor(.gray)
            Spacer()
            Text(balance)
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding(.bottom, 5)
    }
}

// Vue pour chaque ligne de compte
struct AccountRowView: View {
    let account: Account
    
    var body: some View {
        HStack {
            Image(systemName: account.iconName)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(account.accountType)
                    .font(.body)
                    .foregroundColor(.black)
                Text(account.holderName)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(account.accountNumber)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(account.balance)
                .font(.caption)
                .foregroundColor(.green)
        }
    }
}

// Vue de détail pour un compte sélectionné
struct AccountDetailView: View {
    let account: Account
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Détails du Compte")
                .font(.title)
                .padding(.bottom, 10)
            
            HStack {
                Image(systemName: account.iconName)
                    .foregroundColor(.blue)
                    .font(.system(size: 40))
                VStack(alignment: .leading) {
                    Text(account.accountType)
                        .font(.headline)
                    Text(account.holderName)
                        .foregroundColor(.gray)
                    Text(account.accountNumber)
                        .foregroundColor(.gray)
                }
            }
            
            Text("Solde: \(account.balance)")
                .font(.title2)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
    }
}

