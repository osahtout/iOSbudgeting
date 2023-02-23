//
//  TaxCalcView.swift
//  budgeting
//
//  Created by Sahtout, Omar on 2022-03-31.
//

import SwiftUI

struct TaxCalcView: View
{
    @State var income: String = ""
    @State var totalTax: String = ""
    @State var federalTaxPayed: String = ""
    @State var provincialTaxPayed: String = ""
    @State var netIncome: String = ""
    @State var taxPerPay: String = ""
    @State var netMonthlyIncome: String = ""
    @State var netPaycheck: String  = ""
    
    var body: some View
    {
        VStack()
        {
            Text("Quebec Tax Calculator")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.bottom)
            
            HStack()
            {
                Text("Enter income")
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.leading)

            TextField("total income in $", text: $income)
                .padding(.all)
                .border(Color(UIColor.separator))
                .padding(.leading)
                .padding(.trailing)
                .keyboardType(.numberPad)
            
            Button("submit")
            {
                populateEverything()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            List
            {
                calculatedRow(textInput: $netIncome, title: "Net Income")
                calculatedRow(textInput: $federalTaxPayed, title: "Federal Tax")
                calculatedRow(textInput: $provincialTaxPayed, title: "Provincial Tax")
                calculatedRow(textInput: $totalTax, title: "Total Tax")
                calculatedRow(textInput: $taxPerPay, title: "Tax Per Pay")
                calculatedRow(textInput: $netMonthlyIncome, title: "Net Monthly income")
                calculatedRow(textInput: $netPaycheck, title: "Net Paycheck")
                
            }.listStyle(.plain)
        }
    }
    
    private func populateEverything()
    {
        totalTax = getTotalTax() + "$"
        federalTaxPayed = getFederalTax() + "$"
        provincialTaxPayed = getProvincialTax() + "$"
        netIncome = getNetIncome() + "$"
        netMonthlyIncome = getMonthlyIncome() + "$"
        netPaycheck = getpaycheck() + "$"
        taxPerPay = getTaxPerPay() + "$"
        
    }
    
    private func getTaxPerPay() -> String
    {
        let payBeforeTax = (Float(income) ?? 0.0) / 24
        let pay: Float = Float(getpaycheck()) ?? 0.0
        
        return String(format: "%.2f", payBeforeTax - pay);
    }
    
    private func getpaycheck() -> String
    {
        let netFullIncome = Float(getNetIncome()) ?? 0.0
        return String(format: "%.2f", netFullIncome / 24)
    }
    
    private func getMonthlyIncome() -> String
    {
        let netIncomeFull = Float(getNetIncome()) ?? 0.0
        return String(format: "%.2f", (netIncomeFull / 12) )
    }
    
    
    private func getNetIncome() -> String
    {
        let totaltax = Float(getTotalTax()) ?? 0.0
        let inc = Float(income) ?? 0.0
        return String(format: "%.2f", (inc - totaltax))
    }
    
    
    private func getTotalTax() -> String
    {
        let fedTax = Float(getFederalTax()) ?? 0.0
        let provTax = Float(getProvincialTax()) ?? 0.0
        return String(format: "%.2f", (fedTax + provTax))
    }
    
    private let firstFedTaxBracket: Float = 0.15
    private let secondFedTaxBracket: Float  = 0.205
    private let thirdFedTaxBracket: Float  = 0.26
    private let fourthFedTaxBracket: Float  = 0.29
    private let lastFedTaxBracket: Float  = 0.33
    
    private let firstFedIncomeBracket: Float = 50197
    private let secondFedIncomeBracket: Float  = 100392
    private let thirdFedTIncomeBracket: Float  = 155625
    private let fourthFedIncomeBracket: Float  = 221708
    
    
    private func getFederalTax() -> String
    {
        let totalIncome = Float(income) ?? 0.0
        var totalFederalTax: Float = 0
        var incomeLeftToTax: Float = totalIncome
        
        if(totalIncome > 0.0)
        {
            if(incomeLeftToTax > fourthFedIncomeBracket)
            {
                incomeLeftToTax = incomeLeftToTax - fourthFedIncomeBracket
                totalFederalTax += incomeLeftToTax * lastFedTaxBracket
                incomeLeftToTax = fourthFedIncomeBracket
            }
            
            if(incomeLeftToTax > thirdFedTIncomeBracket)
            {
                let difference = incomeLeftToTax - thirdFedTIncomeBracket
                totalFederalTax = difference * fourthFedTaxBracket
                incomeLeftToTax = thirdFedTIncomeBracket
            }
            
            if(incomeLeftToTax > secondFedIncomeBracket)
            {
                let difference = incomeLeftToTax - secondFedIncomeBracket
                totalFederalTax = difference * thirdFedTaxBracket
                incomeLeftToTax = secondFedIncomeBracket
            }
            
            if(incomeLeftToTax > firstFedIncomeBracket)
            {
                let difference = incomeLeftToTax - firstFedIncomeBracket
                totalFederalTax = difference * secondFedTaxBracket
                incomeLeftToTax = firstFedIncomeBracket
                
            }
            
            totalFederalTax += incomeLeftToTax * firstFedTaxBracket
            
        }
        
        
        return String(format: "%.2f", totalFederalTax)
    }
    
    
    private let taxBracketQuebec1: Float = 0.15
    private let taxBracketQuebec2: Float  = 0.20
    private let taxBracketQuebec3: Float  = 0.24
    private let taxBracketQuebec4: Float  = 0.2575

    private let incomeQuebecBracket1: Float = 46295
    private let incomeQuebecBracket2: Float  = 92580
    private let incomeQuebecBracket3: Float  = 112655
    
    
    
    private func getProvincialTax() -> String
    {
        let totalIncome = Float(income) ?? 0.0
        var totalProvincialTax: Float = 0
        var incomeLeftToTax: Float = totalIncome
        
        if(totalIncome > 0.0)
        {
            if(incomeLeftToTax > incomeQuebecBracket3)
            {
                incomeLeftToTax = incomeLeftToTax - incomeQuebecBracket3
                totalProvincialTax += incomeLeftToTax * taxBracketQuebec4
                incomeLeftToTax = incomeQuebecBracket3
            }
            
            if(incomeLeftToTax > incomeQuebecBracket2)
            {
                let difference = incomeLeftToTax - incomeQuebecBracket2
                totalProvincialTax = difference * taxBracketQuebec3
                incomeLeftToTax = incomeQuebecBracket2
            }

            if(incomeLeftToTax > incomeQuebecBracket1)
            {
                let difference = incomeLeftToTax - incomeQuebecBracket1
                totalProvincialTax = difference * taxBracketQuebec2
                incomeLeftToTax = incomeQuebecBracket1
            }
            
            totalProvincialTax += incomeLeftToTax * taxBracketQuebec1
        }
        
        
        return String(format: "%.2f", totalProvincialTax)
        
    }
}

struct TaxCalcView_Previews: PreviewProvider {
    static var previews: some View {
        TaxCalcView()
            .previewInterfaceOrientation(.portrait)
    }
}


