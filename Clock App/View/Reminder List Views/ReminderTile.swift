//
//  ReminderTile.swift
//  Clock
//
//  Created by Lalit Vinde on 31/07/23.
//

import SwiftUI

struct ReminderTile: View{
    static let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }()

    @ObservedObject private var model: Reminder
    @State private var xOffset:CGFloat=0
    private let commands:[Command]=[
        .M(x:0.0,y:0.04153354632587859),
        .C(x1:0.0,y1:0.01859520766773163,x2:0.01859520766773163,y2:0.0,x:0.04153354632587859,y:0.0),
        .L(x:0.9584664536741214,y:0.0),
        .C(x1:0.981405750798722,y1:0.0,x2:1.0,y2:0.01859520766773163,x:1.0,y:0.04153354632587859),
        .L(x:1.0,y:0.17252396166134185),
        .C(x1:1.0,y1:0.1954623003194888,x2:0.981405750798722,y2:0.21405750798722045,x:0.9584664536741214,y:0.21405750798722045),
        .L(x:0.04153354632587859,y:0.21405750798722045),
        .C(x1:0.01859517571884984,y1:0.21405750798722045,x2:0.0,y2:0.1954623003194888,x:0.0,y:0.17252396166134185),
        .L(x:0.0,y:0.04153354632587859),
        .Z,
    ]
    
    private let size:CGSize=CGSize(width: 313.w, height: 67.w)
    private let shape:FigmaShape
    private static let days=["M","T","W","T","F","S","S"]
    
    init(model: Reminder){
        
        shape=FigmaShape(commands: commands)
        self.model=model
    }
    
    //MARK: View
    var body: some View {
        ZStack(alignment: .trailing){
            
            Image(systemName: "trash")
                .scaledToFill()
                .foregroundColor(.red)
                .padding(.trailing, 16.w)
                .frame(width:  -xOffset<=60.w ? -xOffset : 60.w, height: -xOffset<=60.w ? -xOffset : 60.w)
                .animation(.spring(), value: xOffset)
                .onTapGesture {
                    deleteReminder()
                }
            
            
            tile
                .overlay{
                    HStack{
                        Text(Self.dateFormatter.string(from: model.date))
                            .font(.custom("CascadiaCodePL-Regular", size: 15.w))
                            .bold()
                            .foregroundColor(
                                Color(hex: 0x677185, alpha: model.toggle ? 1 : 0.4)
                            )
                        Spacer()
                        HStack{
                            ForEach(0..<7, id: \.self) { idx in
                                Text(Self.days[idx])
                                    .font(.custom("AtypDisplay-Bold", size: 14.w))
                                    .foregroundColor(
                                        model.days & (1<<idx) != 0 //check is N'th bit is set
                                        ? Color(hex: 0xFD1E4E,alpha: model.toggle ? 1 : 0.4)
                                        : Color(hex: 0x646E82, alpha: model.toggle ? 1 : 0.4)
                                        
                                    )
                                    .onTapGesture {
                                        model.days ^= 1<<idx //toggle N'th bit
                                    }
                            }.disabled(!model.toggle)
                            
                            ToggleButton(
                                toggle: $model.toggle
                            )
                            .padding(.leading, 3.w)
                        }
                    }
                    .padding(.horizontal, 16.w)
                }
                .offset(x:xOffset)
                .animation(.spring(), value: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged(onChanged)
                        .onEnded(onEnded)
                )
        }
        .onDisappear{
            
            PersistenceController.save()

        }
    }
    
    //MARK: Functions
    
    private func onChanged(value:DragGesture.Value){
        //swip <- left
        if value.translation.width < 0 {
            //traslate with x-axis drag
            xOffset = value.translation.width
        }
        //swip -> right
        else{
            //do nothing
            xOffset = 0
        }
    }
    
    private func onEnded(value:DragGesture.Value){
        if value.translation.width < 0{
            if -xOffset > UIScreen.main.bounds.width/1.8{
                deleteReminder()
            }
            else if -xOffset > 60.w{
                xOffset = -60.w
            }
            else{
                xOffset = 0

            }
        }
        
    }
    
    private func deleteReminder(){
        Task{
            await AlarmManager.shared.deleteAlarm(date: model.date)

        }
        PersistenceController.shared.viewContext.delete(model)
        xOffset = -UIScreen.main.bounds.width

    }
    
    //MARK: Tile Background View
    var tile :some View{
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    Color(
                        red: 0.9333333373069763,
                        green: 0.9411764740943909,
                        blue: 0.9607843160629272
                    )
                )
            }.overlay{
                shape.innerShadow(
                    color: Color(
                        red: 0.6509804129600525,
                        green: 0.7058823704719543,
                        blue: 0.7843137383460999,
                        opacity: 0.3
                    ),
                    radius: 5.w,
                    x: 3.w,
                    y: 3.w
                )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.9750000238418579,
                            green: 0.9750000238418579,
                            blue: 0.9750000238418579
                        ),
                        radius: 5.w,
                        x: 2.w,
                        y: 2.w
                    )
            }
            .frame(width: size.width, height: size.height)
        
    }
}


struct ReminderTile_Previews: PreviewProvider {
    struct Container : View{
        @Environment(\.managedObjectContext) var viewContext
        var body: some View{
            ReminderTile(model: .init(context: viewContext))
        }
    }
    static var previews: some View {
        Container().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
