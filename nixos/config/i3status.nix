{ pkgs, writeText, xdg_utils, i3status, ... }:

let
  self = pkgs.writeText "i3status-config" ''
# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
        colors = true
        interval = 5
}

# order += "ipv6"
order += "disk /"
# order += "run_watch DHCP"
# order += "run_watch VPN"
order += "wireless _first_"
order += "ethernet _first_"
order += "battery 0"
# order += "load"
order += "tztime local"

wireless _first_ {
        format_up = "W: (%quality at %essid) %ip"
        format_down = ""
}

ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = ""
}

battery 0 {
        format = "%status %percentage %remaining"
        path = "/sys/class/power_supply/BAT1/uevent"
}

run_watch DHCP {
        pidfile = "/var/run/dhclient*.pid"
}

run_watch VPN {
        pidfile = "/var/run/vpnc/pid"
}

tztime local {
        format = "%Y-%m-%d %H:%M"
}

load {
        format = "%1min"
}

disk "/" {
        format = "%avail"
}
    '';
in {
  environment.etc =
    [
      { source = self;
        target = "i3status.conf";
      }
    ];
}
