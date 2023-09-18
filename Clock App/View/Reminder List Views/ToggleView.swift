//
//  ToggleView.swift
//  Clock
//
//  Created by Lalit Vinde on 28/07/23.
//

import SwiftUI

struct ToggleThumbView: View {
    let commands:[Command]=[
        .M(x:0.0,y:0.5),
        .C(x1:0.0,y1:0.22385761904761906,x2:0.22385761904761906,y2:0.0,x:0.5,y:0.0),
        .L(x:0.5,y:0.0),
        .C(x1:0.7761428571428571,y1:0.0,x2:1.0,y2:0.22385761904761906,x:1.0,y:0.5),
        .L(x:1.0,y:0.5),
        .C(x1:1.0,y1:0.7761428571428571,x2:0.7761428571428571,y2:1.0,x:0.5,y:1.0),
        .L(x:0.5,y:1.0),
        .C(x1:0.22385761904761906,y1:1.0,x2:0.0,y2:0.7761428571428571,x:0.0,y:0.5),
        .L(x:0.0,y:0.5),
        .Z,
    ]
    
    let size:CGSize=CGSize(width: 21.w, height: 21.w)
    let shape:FigmaShape
    let strokeStyle:StrokeStyle = StrokeStyle(
        lineWidth: 1.w,
        miterLimit: 4.w
    )
    init(){
        shape=FigmaShape(commands: commands)
    }
    
    var body: some View {
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9333333373069763,
                                    green: 0.9411764740943909,
                                    blue: 0.9607843160629272
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.9019607901573181,
                                    green: 0.9137254953384399,
                                    blue: 0.9372549057006836
                                ),
                                location: 1
                            ),
                            .init(
                                color: Color(
                                    red: 0.9019607901573181,
                                    green: 0.9137254953384399,
                                    blue: 0.9372549057006836
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 1.1732481708381926e-08, y:0.17968745307007178),
                        endPoint: UnitPoint(x: 0.8203125426189228, y:0.8828124696046857)
                    )
                )
            }.overlay{
                shape.stroke(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9803921580314636,
                                    green: 0.9843137264251709,
                                    blue: 0.9843137264251709
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.7568627595901489,
                                    green: 0.7921568751335144,
                                    blue: 0.843137264251709
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 0.15624999278224988, y:0.2968750190339051),
                        endPoint: UnitPoint(x: 0.8124999908031894, y:0.8906250261352399)
                    ),
                    style: strokeStyle
                )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 0.6509804129600525,
                            green: 0.7058823704719543,
                            blue: 0.7843137383460999,
                            opacity: 0.5
                        ),
                        radius: 6.w,
                        x: 3.w,
                        y: 3.w
                    )
            }.background{
                shape
                    .fill(.white)
                    .shadow(
                        color: Color(
                            red: 1,
                            green: 1,
                            blue: 1,
                            opacity: 0.5
                        ),
                        radius: 6.w,
                        x: -3.w,
                        y: -3.w
                    )
            }
            .frame(width: size.width, height: size.height)
    }
}

struct ToggleBarView: View {
    @Binding var toggle:Bool
    let commands:[Command]=[
        .M(x:0.0,y:0.21212121212121213),
        .C(x1:0.0,y1:0.09497,x2:0.09497,y2:0.0,x:0.21212121212121213,y:0.0),
        .L(x:0.7878787878787878,y:0.0),
        .C(x1:0.9050303030303031,y1:0.0,x2:1.0,y2:0.09497,x:1.0,y:0.21212121212121213),
        .L(x:1.0,y:0.21212121212121213),
        .C(x1:1.0,y1:0.3292727272727273,x2:0.9050303030303031,y2:0.42424242424242425,x:0.7878787878787878,y:0.42424242424242425),
        .L(x:0.21212121212121213,y:0.42424242424242425),
        .C(x1:0.09497,y1:0.42424242424242425,x2:0.0,y2:0.3292727272727273,x:0.0,y:0.21212121212121213),
        .L(x:0.0,y:0.21212121212121213),
        .Z,
    ]
    
    let size:CGSize=CGSize(width: 33.w, height: 14.w)
    let shape:FigmaShape
    let strokeStyle:StrokeStyle = StrokeStyle(
        lineWidth: 1.w,
        miterLimit: 4.w
    )
    init(toggle:Binding<Bool>){
        shape=FigmaShape(commands: commands)
        _toggle=toggle
    }
    
    var body: some View {
        shape
            .fill(.clear)
            .overlay{
                shape.fill(
                    toggle ? Color(hex: 0xFD251E) : Color(
                        red: 0.9137254953384399,
                        green: 0.929411768913269,
                        blue: 0.9411764740943909
                    )
                )
            }.overlay{
                shape.fill(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.6509804129600525,
                                    green: 0.7058823704719543,
                                    blue: 0.7843137383460999
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.6509804129600525,
                                    green: 0.7058823704719543,
                                    blue: 0.7843137383460999,
                                    opacity: 0
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 0.5, y:-3.0616171314629196e-17),
                        endPoint: UnitPoint(x: 0.5, y:0.9999999999999999)
                    )
                ).opacity(0.25).blendMode(.multiply)
            }.overlay{
                shape.innerShadow(
                    color: Color(
                        red: 0.3889062702655792,
                        green: 0.45352327823638916,
                        blue: 0.5458333492279053,
                        opacity: 0.20000000298023224
                    ),
                    radius: 1.9800000190734863.w,
                    x: 1.600000023841858.w,
                    y: 1.2999999523162842.w
                )
            }.overlay{
                shape.innerShadow(
                    color: Color(
                        red: 1,
                        green: 1,
                        blue: 1,
                        opacity: 0.4099999964237213
                    ),
                    radius: 3.w,
                    x: -1.600000023841858.w,
                    y: -1.600000023841858.w
                )
            }.overlay{
                shape.stroke(
                    LinearGradient(
                        stops:[
                            .init(
                                color: Color(
                                    red: 0.9921568632125854,
                                    green: 0.9921568632125854,
                                    blue: 0.9960784316062927
                                ),
                                location: 0
                            ),
                            .init(
                                color: Color(
                                    red: 0.729411780834198,
                                    green: 0.7647058963775635,
                                    blue: 0.8117647171020508
                                ),
                                location: 1
                            )
                        ],
                        startPoint: UnitPoint(x: 0.7424242264107904, y:1.10714273139487),
                        endPoint: UnitPoint(x: 0.33333334946205284, y:-0.392857150750501)
                    ),
                    style: strokeStyle
                )
            }
            .frame(width: size.width, height: size.height)
    }
}

struct ToggleButton: View{
    @Binding var toggle:Bool;
    var body: some View{
        ToggleBarView(toggle: $toggle)
            .overlay(alignment: toggle ? .trailing : .leading ){
                ToggleThumbView()
                    .alignmentGuide(.leading) { d in
                        d[HorizontalAlignment.leading]+6.w
                    }
                    .alignmentGuide(.trailing) { d in
                        d[HorizontalAlignment.trailing]-6.w
                    }
            }
            .onTapGesture {
                toggle.toggle()
            }
    }
}
struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ToggleButton(toggle: .constant(false))
                .padding()
                .background(Color(hex: 0xFFFFFF))
            ToggleButton(toggle: .constant(false))
                .padding()
                .background(Color(hex: 0xFFFFFF))
        }
        .previewLayout(.sizeThatFits)
        
        
    }
}
