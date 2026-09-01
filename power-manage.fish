#!/usr/bin/env fish
#!/usr/bin/env fish

function set_ac
  test -f /sys/firmware/acpi/platform_profile; and echo "performance" > /sys/firmware/acpi/platform_profile

	for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
		test -f "$f"; and echo "performance" > "$f"
	end
  for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
	  test -f "$f"; and echo 400000 > "$f"
	end
	for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
	  test -f "$f"; and echo 4830000 > "$f"
	end
  echo "set profile: AC"
end

function set_bat
	test -f /sys/firmware/acpi/platform_profile; and echo "low-power" > /sys/firmware/acpi/platform_profile
	for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
		test -f "$f"; and echo "balance_power" > "$f"
	end
	for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
		test -f "$f"; and echo 400000 > "$f"
	end
	for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
		test -f "$f"; and echo 2300000 > "$f"
  end
  echo "set profile: BAT"
end

switch "$argv[1]"
  case boot
    # Same detection the udev rule uses: any power_supply reporting online=1 means AC.
    if grep -qs 1 /sys/class/power_supply/*/online
      set_ac
    else
      set_bat
    end
  case ac
    set_ac
	case battery bat
    set_bat
  case '*'
  echo "Usage: "(path basename (status filename))" {boot|ac|battery}"

  return 1
end
