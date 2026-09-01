#!/usr/bin/env fish


for dev in /sys/class/power_supply/*
    test -d "$dev"; or continue
    set -l name (basename "$dev")
    set -l type (test -f "$dev/type"; and cat "$dev/type"; or echo "Unknown")

    printf "========================================\n"
    printf "Device: %s (Type: %s)\n" "$name" "$type"
    printf "========================================\n"

    if test "$type" = "Mains" -o "$type" = "USB"
        set -l online (test -f "$dev/online"; and cat "$dev/online"; or echo "0")
        if test "$online" = "1"
            echo "  Online:        yes"
        else
            echo "  Online:        no"
        end
        printf "\n"
        continue
    end

    set -l vendor (test -f "$dev/manufacturer"; and cat "$dev/manufacturer"; or echo "Unknown")
    set -l model (test -f "$dev/model_name"; and cat "$dev/model_name"; or echo "Unknown")
    set -l tech (test -f "$dev/technology"; and cat "$dev/technology"; or echo "Unknown")
    set -l status (test -f "$dev/status"; and cat "$dev/status"; or echo "Unknown")
    set -l capacity (test -f "$dev/capacity"; and cat "$dev/capacity"; or echo "Unknown")
    set -l cycles (test -f "$dev/cycle_count"; and cat "$dev/cycle_count"; or echo "")

    printf "  Vendor:        %s\n" "$vendor"
    printf "  Model:         %s\n" "$model"
    printf "  Technology:    %s\n" "$tech"
    printf "  State:         %s\n" "$status"
    printf "  Percentage:    %s%%\n" "$capacity"
    test -n "$cycles"; and printf "  Cycle Count:   %s\n" "$cycles"

    set -l e_now 0
    for f in "$dev/energy_now" "$dev/charge_now"
        if test -f "$f"
            set e_now (cat "$f")
            break
        end
    end

    set -l e_full 0
    for f in "$dev/energy_full" "$dev/charge_full"
        if test -f "$f"
            set e_full (cat "$f")
            break
        end
    end

    set -l e_design 0
    for f in "$dev/energy_full_design" "$dev/charge_full_design"
        if test -f "$f"
            set e_design (cat "$f")
            break
        end
    end

    set -l p_now 0
    for f in "$dev/power_now" "$dev/current_now"
        if test -f "$f"
            set p_now (cat "$f")
            break
        end
    end

    set -l v_now 0
    test -f "$dev/voltage_now"; and set v_now (cat "$dev/voltage_now")

    awk -v enow="$e_now" -v efull="$e_full" -v edesign="$e_design" \
        -v pnow="$p_now" -v vnow="$v_now" -v status="$status" 'BEGIN {
        if (vnow > 0) printf "  Voltage:       %.3f V\n", vnow / 1000000;
        if (pnow > 0) printf "  Energy Rate:   %.3f W\n", pnow / 1000000;
        if (enow > 0) printf "  Energy Now:    %.3f Wh\n", enow / 1000000;
        if (efull > 0) printf "  Energy Full:   %.3f Wh\n", efull / 1000000;
        if (edesign > 0) {
            printf "  Design Full:   %.3f Wh\n", edesign / 1000000;
            printf "  Capacity Health: %.2f%%\n", (efull / edesign) * 100;
        }
        if (pnow > 0 && enow > 0) {
            if (status == "Discharging") {
                hours = enow / pnow;
                h = int(hours);
                m = int((hours - h) * 60);
                printf "  Time to Empty: %d hours, %d minutes\n", h, m;
            } else if (status == "Charging" && efull > enow) {
                hours = (efull - enow) / pnow;
                h = int(hours);
                m = int((hours - h) * 60);
                printf "  Time to Full:  %d hours, %d minutes\n", h, m;
            }
        }
    }'
    printf "\n"
end
