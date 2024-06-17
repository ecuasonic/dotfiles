display_ports=$(./detect_monitor.sh)

if [[ -z "${display_ports// /}" ]]; then
    echo This works!
fi
echo nothing
