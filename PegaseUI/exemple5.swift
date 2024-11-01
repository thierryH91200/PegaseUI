import SwiftUI




    // Définir des attributs pour les règles de filtrage
    enum FilterAttribute: String, CaseIterable {
        case name = "Name"
        case age = "Age"
        case city = "City"
    }

    // Définir des comparateurs
    enum FilterComparison: String, CaseIterable {
        case equals = "Equals"
        case contains = "Contains"
        case greaterThan = "Greater Than"
        case lessThan = "Less Than"
    }

    // Modèle de règle de filtre
    struct FilterRule: Identifiable {
        let id = UUID()
        var attribute: FilterAttribute = .name
        var comparison: FilterComparison = .equals
        var value: String = ""
    }


class PredicateEditorModel: ObservableObject {
    @Published var rules: [FilterRule] = [FilterRule()]
    
    // Génère un NSPredicate en fonction des règles
    func buildPredicate() -> NSPredicate {
        let subpredicates = rules.map { rule -> NSPredicate in
            let format: String
            let argument: Any
            
            switch rule.comparison {
            case .equals:
                format = "\(rule.attribute.rawValue) == %@"
                argument = rule.value
            case .contains:
                format = "\(rule.attribute.rawValue) CONTAINS[cd] %@"
                argument = rule.value
            case .greaterThan:
                format = "\(rule.attribute.rawValue) > %@"
                argument = rule.value
            case .lessThan:
                format = "\(rule.attribute.rawValue) < %@"
                argument = rule.value
            }
            
            return NSPredicate(format: format, argumentArray: [argument])
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: subpredicates)
    }
    
    func addRule() {
        rules.append(FilterRule())
    }
    
    func removeRule(_ rule: FilterRule) {
        rules.removeAll { $0.id == rule.id }
    }
}


struct PredicateEditorView: View {
    @ObservedObject var model = PredicateEditorModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Predicate Editor")
                .font(.headline)
            
            ForEach($model.rules) { $rule in
                HStack {
                    Picker("Attribute", selection: $rule.attribute) {
                        ForEach(FilterAttribute.allCases, id: \.self) { attribute in
                            Text(attribute.rawValue).tag(attribute)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Comparison", selection: $rule.comparison) {
                        ForEach(FilterComparison.allCases, id: \.self) { comparison in
                            Text(comparison.rawValue).tag(comparison)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Value", text: $rule.value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                    
                    Button(action: {
                        model.removeRule(rule)
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.vertical, 5)
            }
            
            HStack {
                Button(action: {
                    model.addRule()
                }) {
                    Label("Add Rule", systemImage: "plus.circle")
                }
                
                Spacer()
                
                Button(action: {
                    let predicate = model.buildPredicate()
                    print("Generated Predicate: \(predicate)")
                }) {
                    Text("Build Predicate")
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(width: 400)
    }
}

struct ContentView2000: View {
    var body: some View {
        PredicateEditorView()
    }
}
