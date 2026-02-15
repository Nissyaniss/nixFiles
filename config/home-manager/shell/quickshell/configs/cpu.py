import psutil

print(f"{psutil.cpu_percent(
    interval=1, percpu=False):.0f}", flush=True, end="")
