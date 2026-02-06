import psutil
import time
while True:
	print(f"{{\"memory\":\"{psutil.virtual_memory().percent:.0f}%\"}}", flush=True)
	time.sleep(1)
