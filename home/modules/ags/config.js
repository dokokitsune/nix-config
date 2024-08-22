const audio = await Service.import("audio")
const battery = await Service.import("battery")
const hyprland = await Service.import("hyprland")
const network = await Service.import("network")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
	poll: [1000, `date "+%a %b %d %I:%M %p"`]
})

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

function Workspaces() {
	const activeId = hyprland.active.workspace.bind("id")
	const workspaces = hyprland.bind("workspaces")
		.as(ws => ws.sort((a, b) => a.id - b.id).map(({ id }) => Widget.Button({
			on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
			child: Widget.Label(`${id}`),
			class_name: activeId.as(i => `${i === id ? "focused" : "workspace"}`),
		})))

	return Widget.Box({
		class_name: "workspaces",
		children: workspaces,
	})
}

const SysTrayItem = item => Widget.Button({
	child: Widget.Icon().bind('icon', item, 'icon'),
	tooltipMarkup: item.bind('tooltip_markup'),
	onPrimaryClick: (_, event) => item.activate(event),
	onSecondaryClick: (_, event) => item.openMenu(event),
})

const SysTray = Widget.Box({
	children: systemtray.bind('items').as(i => i.map(SysTrayItem))
})

function BatteryLabel() {
	const charging = battery.charging
	const icon = battery.bind("percent").as(p => {
		if (charging) {
			return `battery-level-${Math.floor(p / 10) * 10}-charging-symbolic`
		}
		else {

			return `battery-level-${Math.floor(p / 10) * 10}-symbolic`
		}

	})

	return Widget.Box({
		class_name: "battery",
		visible: battery.bind("available"),
		children: [
			Widget.Icon({
				icon,
				class_name: "battery",
			}),

		],
	})
}



function Clock() {
	return Widget.Label({
		class_name: "clock",
		label: date.bind(),
	})
}

function ClientTitle() {
	const title = hyprland.active.client.bind("title");

	return Widget.Label({
		class_name: "client-title",
		label: title.transform((t) => {
			if (t.length > 30) {
				return t.slice(0, 27) + "...";
			}
			return t;
		}),
	});
}


const WifiIndicator = () => Widget.Box({
	children: [
		Widget.Icon({
			icon: network.wifi.bind('icon_name'),
		}),
	],
})

const WiredIndicator = () => Widget.Icon({
	icon: network.wired.bind('icon_name'),
})

const NetworkIndicator = () => Widget.Stack({
	children: {
		wifi: WifiIndicator(),
		wired: WiredIndicator(),
	},
	shown: network.bind('primary').as(p => p || 'wifi'),
})


function Volume() {
	const icons = {
		101: "overamplified",
		67: "high",
		34: "medium",
		1: "low",
		0: "muted",
	}

	function getIcon() {
		const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
			threshold => threshold <= audio.speaker.volume * 100)

		return `audio-volume-${icons[icon]}-symbolic`
	}

	const icon = Widget.Icon({
		icon: Utils.watch(getIcon(), audio.speaker, getIcon),
	})

	return Widget.Box({
		class_name: "volume",
		children: [icon],
	})
}

function Left() {
	return Widget.Box({
		class_name: "leftBox",
		spacing: 8,
		children: [
			Workspaces(),
		]
	})
}

function Center() {
	return Widget.Box({
		class_name: "centerBox",
		spacing: 8,
		children: [
			ClientTitle()
		]
	})
}

function Right() {
	return Widget.Box({
		class_name: "rightBox",
		spacing: 8,
		hpack: "end",
		children: [
			SysTray,
			NetworkIndicator(),
			Volume(),
			BatteryLabel(),
			Clock()

		]
	})
}

function Bar(monitor = 0) {
	return Widget.Window({
		name: `bar-${monitor}`,
		class_name: "bar",
		monitor,
		anchor: ["top", "left", "right"],
		exclusivity: "exclusive",
		child: Widget.CenterBox({
			start_widget: Left(),
			center_widget: Center(),
			end_widget: Right()
		})

	})
}



App.config({
	style: './style.scss',
	windows: [
		Bar(),

	]
})
