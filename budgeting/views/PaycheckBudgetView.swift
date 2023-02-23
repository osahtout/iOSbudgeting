//
//  PaycheckBudgetView.swift
//  budgeting
//
//  Created by Sahtout, Omar on 2022-03-31.
//

import SwiftUI

struct PaycheckBudgetView: View
{
    
    @State var paycheck = ""
    @State var monthlyBills = ""
    @State var companyInvestment = ""
    @State var mortgage = ""
    @State var investment = ""
    @State var selfSpending = ""
    @State var total = ""
    
    
    var body: some View
    {
        VStack(alignment: .center)
        {
            Text("Budgeting paychecks")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            
            Section
            {
                titleForInput(title: "Enter Net Paycheck (will double assume monthly)")
                inputFields(input: $paycheck)
                
                titleForInput(title: "Enter Monthly bills to pay")
                inputFields(input: $monthlyBills)
                
                titleForInput(title: "Enter amount taken for stocks options")
                inputFields(input: $companyInvestment)
                    
                
                Button("Calculate")
                {
                    populateBudgeting()
                }.padding(.all)
                
            }
        
            List
            {
                calculatedRow(textInput: $monthlyBills, title: "Bills")
                calculatedRow(textInput: $mortgage, title: "Mortage Saving Amount")
                calculatedRow(textInput: $companyInvestment, title: "Company investment")
                calculatedRow(textInput: $investment, title: "Personal Investment")
                calculatedRow(textInput: $selfSpending, title: "Self Spending")
            }.listStyle(.plain)
        }
    }
    
    private func getTotalMonthlyBill() -> Float
    {
        // cc
        let phoneBill: Float = 65.0
        let internetBill: Float  = 72.0
        let microsoft: Float  = 10.0 + 14
        let apple: Float  = 11.5 + 1.5
        
        let totalCC: Float = phoneBill + internetBill + microsoft + apple
        
        // dd
        // gti
        let gtiInsur: Float  = 177.0
        let gtiLease: Float  = (250.25 * 26.0) / 12.0
        let gtiRegistration: Float  = 47.0 / 2.0
        
        let totalGti: Float  = gtiInsur + gtiLease + gtiRegistration
        
        // civic
        let civicInsur: Float  = 57.0
        let civicRegistration: Float  = gtiRegistration
        
        let totalCivic = civicInsur + civicRegistration
        
        
        // total
        return totalCC + totalGti + totalCivic;
        
        
    }
    
    
    private func populateBudgeting()
    {
        
        let paycheckFloat = Float(paycheck) ?? 0.0
        let billsFloat = (Float(monthlyBills) ?? getTotalMonthlyBill())
        let stockOptions = Float(companyInvestment) ?? 0.0
        
        let totalPay = (paycheckFloat + stockOptions) * 2
        
        monthlyBills = String(format: "%.2f" , billsFloat)
        mortgage = String(format: "%.2f" ,totalPay * 0.5 - billsFloat)
        investment = String(format: "%.2f", totalPay * 0.3 - stockOptions)
        selfSpending = String(format: "%.2f", totalPay * 0.2)
        
    }
}


struct calculatedRow: View
{
    
    let textInput: Binding<String>
    let title: String
    let placeholer: String = "0$"
    
    var body: some View
    {
        HStack()
        {
            Text(title)
                .fontWeight(.bold)
            
            TextField(placeholer, text: textInput)
                .multilineTextAlignment(.trailing)
                .disabled(true)
            
        }
    }
}

struct inputFields: View
{
    let input: Binding<String>
    let placeholder = "0$"

    var body: some View
    {
        HStack()
        {
            Spacer()
            TextField(placeholder, text: input)
                .padding(.all, 4.0)
                .border(Color(UIColor.separator))
                .padding(.leading)
                .padding(.trailing)
                .keyboardType(.numberPad)
            
        }
    }
}

struct titleForInput: View
{
    let title: String
    var body: some View
    {
        HStack()
        {
            Text(title)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.leading)
        .padding(.top)
        .padding(.bottom, -2)
    }
}


struct PaycheckBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        PaycheckBudgetView()
    }
}
