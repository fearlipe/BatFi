//
//  BatteryInfoView.swift
//  BatFi
//
//  Created by Adam on 20/04/2023.
//

import SwiftUI

public struct BatteryInfoView: View {
    @StateObject private var model = Model()

    public init() { }

    public var body: some View {
        if let powerState = model.state {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    BatteryMainInfo(
                        label: "Battery",
                        info: "\(powerState.batteryLevel)%",
                        primaryForegroundColor: true
                    )
                    if let description = model.time?.description {
                        BatteryMainInfo(
                            label: description.label,
                            info: description.description,
                            primaryForegroundColor: model.time?.hasKnownTime == true
                        )
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    BatteryAdditionalInfo(
                        label: "Power Source",
                        info: powerState.powerSource
                    )
                    BatteryAdditionalInfo(
                        label: "Cycle Count",
                        info: "\(powerState.batteryCycleCount)"
                    )
                    if let temperature = model.temperatureDescription() {
                        BatteryAdditionalInfo(
                            label: "Temperature",
                            info: temperature
                        )
                    }
                    BatteryAdditionalInfo(
                        label: "Battery Health",
                        info: powerState.batteryHealth
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 220)
            .padding(.horizontal)
            .padding(.vertical, 8)
        } else {
            Label(
                "Info is missing",
                systemImage: "bolt.trianglebadge.exclamationmark.fill"
            )
            .padding()
        }
    }
}

struct BatteryMainInfo: View {
    private let itemsSpace: CGFloat  = 30

    let label: String
    let info: String
    let primaryForegroundColor: Bool

    var body: some View {
        HStack {
            Text(label)
            Spacer(minLength: itemsSpace)
            Text(info)
                .foregroundColor(primaryForegroundColor ? .primary : .secondary)
                .fontWeight(primaryForegroundColor ? .semibold : .regular)
                .font(.body)
        }
    }
}

struct BatteryAdditionalInfo: View {
    private let itemsSpace: CGFloat  = 30

    let label: String
    let info: String

    var body: some View {
        HStack {
            Group {
                Text(label)
                Spacer(minLength: itemsSpace)
                Text(info)
            }
            .foregroundColor(.secondary)
            .font(.callout)
        }
    }
}

struct BatteryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryInfoView()
    }
}
