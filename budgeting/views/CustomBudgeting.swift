//
//  CustomBudgeting.swift
//  budgeting
//
//  Created by Sahtout, Omar on 2022-04-01.
//

import SwiftUI

var textList: [String] = []

struct CustomBudgeting: View
{
    @State var title: String = ""
    @State var percentage: String = ""
    @State var dict: [String : String] = [:]
    @State var toBudget: String = ""
    
    
    @State var rest: Double = 100.00
    @State var isOver100: Bool = false
    @State var amountToBudget: String = ""
    @State var editAmount: Bool = true
    @State var budgetingArray: [BudgetData] = []
    
    var body: some View
    {
        
        
        VStack
        {
            if amountToBudget.isEmpty || editAmount
            {
                Text("Please enter the amount to budget")
                
                TextField("Amount to budget", text: $toBudget)
                    .padding()
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                
                Button("Set")
                {
                    amountToBudget = toBudget
                    editAmount = false
                }
                .padding()
            }
            else if isOver100
            {
                Text("Percentage is over 100")
                Button("reset")
                {
                    budgetingArray = []
                    rest = 0
                    editAmount = true
                    isOver100 = false
                }
            }
            else
            {
                HStack
                {
                    Text("Type")
                        .padding(.leading)
                    Spacer()
                    Text("Amount in %")
                        .padding(.trailing)
                    Spacer()
                }
                HStack
                {
                    TextField("ex: mortgage", text: $title)
                        .padding(.leading)
    
                    TextField("0%", text: $percentage)
                        .keyboardType(.numberPad)
                }
            
                Button("add")
                {
                    
                    let perc: Double = Double(percentage) ?? 0.0
                    rest = rest - perc
                    
                    if rest < 0
                    {
                        isOver100 = true
                    }
                    let calculatedResult: Double = calcBudget(precent: perc)
                    let aBudget = BudgetData(name: title, amountPercentage: perc, resultedBudget: calculatedResult)
                    budgetingArray.append(aBudget)
                    
                    title = ""
                    percentage = ""
                }
                List
                {
                    ForEach(budgetingArray, id: \.self)
                    {
                        budget in
                        showTheDictionary(key: budget.name, value: budget.amountPercentage, result: calcBudget(precent: budget.resultedBudget))
                    }
                    showTheDictionary(key: "REST", value: rest, result: calcRestBudgeting())
                    
                }
            }
        }
        
        
        
        
        
        
//        VStack
//        {
//            HStack
//            {
//                Text("Type")
//                    .padding(.leading)
//                Spacer()
//                Text("Amount in %")
//                    .padding(.trailing)
//                Spacer()
//            }
//            HStack
//            {
//                TextField("ex: mortgage", text: $title)
//                    .padding(.leading)
//
//                TextField("0%", text: $percentage)
//                    .keyboardType(.numberPad)
//            }
//
//            Button("add")
//            {
//                dict[title] = percentage
//                setRestOfPercent(addedPerc: percentage)
//                title = ""
//                percentage = ""
//            }
//            .padding(.top)
//
//            Text("Given:")
//                .padding(.top)
//
//            List
//            {
//                ForEach(dict.sorted(by: >), id: \.key, content: {key, value in
//                    Group
//                    {
//                        if(rest > 0)
//                        {
//                            HStack
//                            {
//                                showTheDictionary(key: key, value: value, result: calcBudget(precentage: value))
//                            }
//                            Spacer()
//                            HStack
//                            {
//                                showTheDictionary(key: "rest", value: String(rest), result: calcRestBudgeting())
//                            }
//                        }
//                        else
//                        {
//                            Text("Error, adds to over 100%")
//                        }
//
//                    }
//                })
//            }.listStyle(.plain)
//
//            HStack
//            {
//                TextField("Amount to budget", text: $toBudget)
//                    .padding()
//                    .keyboardType(.numberPad)
//                Button("Set")
//                {}
//                .padding()
//            }
//
//        }
    }
    
    private func calcBudget(precent: Double) -> Double
    {
        let amountInDouble: Double = Double(amountToBudget) ?? 0.0
        let answer: Double = amountInDouble * (precent/100)
        return answer
    }

    private func calcRestBudgeting() -> Double
    {
        return (Double(amountToBudget) ?? 0.0) * (rest/100)
    }
//
//    private func setRestOfPercent(addedPerc: String) -> Void
//    {
//        rest = rest - (Float(addedPerc) ?? 0.0)
//    }
    
}

struct showTheDictionary: View
{
    let key: String
    let value: Double
    let result: Double
    
    var body: some View
    {
        HStack
        {
            Text(key)
            Spacer()
            Text(String(value) + "%")
            Spacer()
            Text(String(result))
            Spacer()
        }
    }
}

struct CustomBudgeting_Previews: PreviewProvider {
    static var previews: some View {
        CustomBudgeting()
    }
}
