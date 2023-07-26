//
//  AddProfile.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 26/07/23.
//

import SwiftUI

struct EditProfile: View {
	@AppStorage("profilesString") var profiles = [Profile]()

	@State var willPresent = false
	@State var profile: Profile? {
		didSet {
			if let profile {
				title = profile.title
				color = profile.color
			}
			willPresent = true
		}
	}
	
	@State var title: String = ""
	@State var color: Color = .white
	
	var body: some View {
		VStack{
			Grid(alignment: .top, verticalSpacing: 16) {
				ForEach(profiles, id: \.self) { p in
					GridRow{
						// TODO add when implemented color
//						Circle()
//							.fill(p.color)
//							.frame(width: 16, height: 16)
						
						Text(p.title)
						
						Spacer()
						
						Text("Record: \(p.record.minuteSecond)")
						Spacer()
						
						Text("Total: \(p.total.minuteSecond)")
						Spacer()
						
						Button(
							action: { profile = p },
							label: {
								Image(systemName: "pencil")
								Text("Edit Profile")
							}
						)
					}
				}
			}
			.scaledToFit()
			.fixedSize(horizontal: false, vertical: true)
			.padding(16)
			
			Button("Add"){ profile = Profile() }
				.alert(
					"Set the name",
					isPresented: $willPresent,
					actions: {
						TextField("Name", text: $title)
						//TODO add ColorPicker in adding
//						ColorPicker("Color", selection: $color)
						Button("Save") {
							guard var profile else { return }
							profiles.removeFirst(profile)
							profile.color = color
							profile.title = title
							profiles.append(profile)
							profiles.removeDuplicates()
						}.disabled(title.isEmpty)
						Button("Cancel", role: .cancel) { }
					}, message: {
						
					}
				)
		}
		.frame(minWidth: 480)
		.scaledToFit()
	}
}
