#!/bin/bash

declare -A drones
drones[0]="4001 gz_x500_lidar_down 1 0 0"
drones[1]="4001 gz_x500_lidar_down 2 0 0"
# Agregar más drones según sea necesario




for id in "${!drones[@]}"; do
    IFS=' ' read -r sys_autostart sim_model x y z <<< "${drones[$id]}"
    if [ "$id" -eq 0 ]; then
        PX4_SYS_AUTOSTART=$sys_autostart PX4_SIM_MODEL=$sim_model PX4_GZ_MODEL_POSE="$x,$y,$z,0,0,0" MAV_SYS_ID=$((id + 1)) ./build/px4_sitl_default/bin/px4 -i $id
        sleep 5 # Espera después de lanzar el primer dron
    # else
    #     PX4_SYS_AUTOSTART=$sys_autostart PX4_SIM_MODEL=$sim_model PX4_GZ_MODEL_POSE="$x,$y,$z,0,0,0" MAV_SYS_ID=$((id + 1)) ./build/px4_sitl_default/bin/px4 -i $id &
    fi
done

wait
