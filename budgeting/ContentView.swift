//
//  ContentView.swift
//  budgeting
//
//  Created by Sahtout, Omar on 2022-03-31.
//

import SwiftUI

struct ContentView: View
{
    enum TabItem { case taxCalc, budgeting }
    @State var selectedItem = TabItem.taxCalc
    
    
    var body: some View
    {
        
        TabView(selection: $selectedItem)
        {
            TaxCalcView()
                .tabItem
                {
                    Image(systemName: "1.circle.fill")
                    Text("Income tax")
                }
            
            PaycheckBudgetView()
                .tabItem
                {
                    Image(systemName: "2.circle.fill")
                    Text("Budget Paycheck")
                }
            CustomBudgeting()
                .tabItem
                {
                    Image(systemName: "3.circle.fill")
                    Text("Custom Budgeting")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(ColorScheme.dark)
    }
}
