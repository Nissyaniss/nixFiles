import psutil
import time

while True:
	print(f"{{\"cpu\":\"{psutil.cpu_percent(interval=None, percpu=False):.0f}%\"}}", flush=True)
	time.sleep(1)
