//
//  CourtCatalogView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

// CourtCatalogView.swift
import SwiftUI

public struct CourtCatalogView: View {
    @Bindable var store: AppStorageStore
    @State private var selectedCourt: Court? = nil
    
    public var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.graphiteBlack.ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(store.localization.localized("court_catalog"))
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.top, 10)
                        
                        ForEach(Court.sampleCourts) { court in
                            CourtCardView(store: store, court: court) {
                                selectedCourt = court
                            }
                        }
                    }
                    .padding(20)
                    .padding(.bottom, 90)
                }
            }
            .sheet(item: $selectedCourt) { court in
                CourtDetailView(store: store, court: court)
            }
        }
    }
}
