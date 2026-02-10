import psutil
import time
from pathlib import Path

while True:
    BAT_PATH = Path("/sys/class/power_supply/BAT0")
    status = (BAT_PATH / "status").read_text().strip()
    battery = psutil.sensors_battery()
    state = battery.power_plugged
    print("{\"percent\":\"", end="")
    print(f"{battery.percent:.0f}\",\"text\":\"", end="")
    if status == "Charging":
        match battery.percent:
            case _ if battery.percent < 20:
                print("󰢜", end="")
            case _ if battery.percent < 30 and battery.percent >= 20:
                print("󰂆", end="")
            case _ if battery.percent < 40 and battery.percent >= 30:
                print("󰂇", end="")
            case _ if battery.percent < 50 and battery.percent >= 40:
                print("󰂈", end="")
            case _ if battery.percent < 60 and battery.percent >= 50:
                print("󰢝", end="")
            case _ if battery.percent < 70 and battery.percent >= 60:
                print("󰂉", end="")
            case _ if battery.percent < 80 and battery.percent >= 70:
                print("󰢞", end="")
            case _ if battery.percent < 90 and battery.percent >= 80:
                print("󰂊", end="")
            case _ if battery.percent < 100 and battery.percent >= 90:
                print("󰂋", end="")
            case _ if battery.percent == 100:
                print("󰂅", end="")
    else:
        match battery.percent:
            case _ if battery.percent < 20:
                print("󰁺", end="")
            case _ if battery.percent < 30 and battery.percent >= 20:
                print("󰁻", end="")
            case _ if battery.percent < 40 and battery.percent >= 30:
                print("󰁼", end="")
            case _ if battery.percent < 50 and battery.percent >= 40:
                print("󰁽", end="")
            case _ if battery.percent < 60 and battery.percent >= 50:
                print("󰁾", end="")
            case _ if battery.percent < 70 and battery.percent >= 60:
                print("󰁿", end="")
            case _ if battery.percent < 80 and battery.percent >= 70:
                print("󰂀", end="")
            case _ if battery.percent < 90 and battery.percent >= 80:
                print("󰂁", end="")
            case _ if battery.percent < 100 and battery.percent >= 90:
                print("󰂂", end="")
            case _ if battery.percent == 100:
                print("󰁹", end="")
    print(f" {battery.percent:.0f}\"", end="")
    print("}", flush=True)
    time.sleep(1)
