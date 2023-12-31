//
//  ContentView.swift
//  Clock
//
//  Created by Lalit Vinde on 25/07/23.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondHandView()
    }
}

struct SecondHandView: View {
    let commands:[Command]=[
        .M(x:0.9896907216494846,y:0.020618659793814435),
        .L(x:0.34875567010309283,y:0.020618556701030927),
        .C(x1:0.34451030927835047,y1:0.008606268041237113,x2:0.33305360824742264,y2:0.0,x:0.31958762886597936,y:0.0),
        .C(x1:0.3061216494845361,y1:0.0,x2:0.29466494845360824,y2:0.008606268041237113,x:0.290419587628866,y:0.020618556701030927),
        .L(x:0.2137360824742268,y:0.020618556701030927),
        .C(x1:0.21017113402061857,y1:0.014455670103092783,x2:0.20350824742268042,y2:0.010309278350515464,x:0.1958762886597938,y:0.010309278350515464),
        .L(x:0.020618556701030927,y:0.010309278350515464),
        .C(x1:0.009231247422680413,y1:0.010309278350515464,x2:0.0,y2:0.019540515463917524,x:0.0,y:0.030927835051546393),
        .C(x1:0.0,y1:0.042315154639175255,x2:0.009231237113402062,y2:0.05154639175257732,x:0.020618556701030927,y:0.05154639175257732),
        .L(x:0.1958762886597938,y:0.05154639175257732),
        .C(x1:0.20350824742268042,y1:0.05154639175257732,x2:0.21017113402061857,y2:0.047400000000000005,x:0.2137360824742268,y:0.041237113402061855),
        .L(x:0.290419587628866,y:0.041237113402061855),
        .C(x1:0.29466494845360824,y1:0.053249381443298965,x2:0.3061216494845361,y2:0.061855670103092786,x:0.31958762886597936,y:0.061855670103092786),
        .C(x1:0.33305360824742264,y1:0.061855670103092786,x2:0.34451030927835047,y2:0.053249381443298965,x:0.34875567010309283,y:0.041237113402061855),
        .L(x:0.9896907216494846,y:0.04123721649484536),
        .C(x1:0.9953845360824742,y1:0.04123721649484536,x2:1.0,y2:0.03662154639175258,x:1.0,y:0.030927938144329897),
        .C(x1:1.0,y1:0.02523422680412371,x2:0.9953845360824742,y2:0.020618659793814435,x:0.9896907216494846,y:0.020618659793814435),
        .Z,
    ]
    
    let size:CGSize=CGSize(width: 97.w, height: 6.w)
    let shape:FigmaShape
    let path:Path
    let strokeStyle:StrokeStyle = StrokeStyle(
        lineWidth: 0.w,
        lineCap: .round,
        miterLimit: 4.w
    )
    init(){
        shape=FigmaShape(commands: commands, angle: Angle(degrees: 45))
        path=shape.path(in: CGRect(origin: .zero, size: CGSize(width: 97.w, height: 6.w)))
    }
    
    var body: some View {
        shape
            .fill(.clear)
            .overlay(
                shape.fill(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9921568632125854,
                                    green: 0.14509804546833038,
                                    blue: 0.11764705926179886
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.9952887892723083,
                                    green: 0.4488924741744995,
                                    blue: 0.3619353175163269
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: -0.18831169205142884, y:1.131502813223051e-06),
                        endPoint: UnitPoint(x: 1.0194805372442863, y:-6.12572284808266e-06)
                    )
                )
            )
            .background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }
            .background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }
            .background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }.background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }.background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }.background{
                shape.fill(.white).shadow(color: .red, radius: 0, x: 6, y: 4)
            }
            .frame(width: size.width, height: size.height)

    }
}
