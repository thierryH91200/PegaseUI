import AppKit

// Document controller for customization of the open panel.
final class TulsiDocumentController: NSDocumentController {

    override func runModalOpenPanel(_ openPanel: NSOpenPanel, forTypes types: [String]?) -> Int {
//        openPanel.message = Localizations.Document.OpenProjectPanelMessage
        openPanel.message = "Ouvre le Projet"
        return super.runModalOpenPanel(openPanel, forTypes: types)
    }
}
