//
//  AddProfile.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 26/07/23.
//

import SwiftUI

struct EditProfile: View {
	@AppStorage("profilesString") var profiles = [Profile]()
	
	@State var addingProfile = false {
		didSet {
			newProfile = Profile()
		}
	}
	
	@State var newProfile: Profile = Profile()
	
	@State var index: Int = 0
	
	var body: some View {
		VStack{
			Grid(alignment: .center, verticalSpacing: 32) {
				GridRow{
					Text("")
					Text("")
					Text("Record")
					Text("Total")
				}
				
				ForEach(0..<profiles.count, id: \.self){ index in
					createProfileGridRow(index)
					Divider()
				}
			}
			.scaledToFit()
			.fixedSize(horizontal: false, vertical: true)
			.padding(16)
			.alert(
				"Set the name",
				isPresented: $addingProfile,
				actions: {
					TextField("Name", text: $newProfile.title)
					//TODO add ColorPicker in adding
					//						ColorPicker("Color", selection: $color)
					
					Button("Save") {
						profiles.append(newProfile)
						profiles.removeDuplicates()
					}.disabled(newProfile.title.isEmpty)
					
					Button("Cancel", role: .cancel) { }
				},
				message: { }
			)
			
			Button("Add"){ addingProfile = true }
				.padding(.bottom, 24)
		}
		.frame(minWidth: 480)
		.scaledToFit()
	}
	
	@ViewBuilder func createProfileGridRow(_ index: Int) -> some View {
		let p: Profile = profiles[index]
		GridRow {
			Circle()
				.fill(p.color) // fill to actual color
				.frame(width: 32, height: 32, alignment: .center)
				.padding(4) // gives the background a padding
				.background(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .pink]), center: .center).cornerRadius(32))
				.overlay(
					ColorPicker("",
								selection: $profiles[index].color,
								supportsOpacity: false
							   )
					.labelsHidden()
					.opacity(0.08)
				)
				.shadow(radius: 0.5)
			
			TextField("Required",
					  text: $profiles[index].title
			)
			.textFieldStyle(RoundedBorderTextFieldStyle())
			
			Text(p.record.minuteSecond)
			
			Text(p.total.minuteSecond)
			
			if(profiles.count > 1){
				Button(
					action: { profiles.removeFirst(p) },
					label: {
						Image(systemName: "trash")
						Text("Delete")
					}
				)
			}
		}
	}
	
}
