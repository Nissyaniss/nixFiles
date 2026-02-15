import psutil
import time
import json

network = psutil.net_io_counters(pernic=False, nowrap=True)
prevUpload = network.bytes_sent
prevDownload = network.bytes_recv

time.sleep(1)
network = psutil.net_io_counters(pernic=False, nowrap=True)
upload = network.bytes_sent - prevUpload
download = network.bytes_recv - prevDownload

upload = f"{(upload / 1000000):.1f}Mb/s"
download = f"{(download / 1000000):.1f}Mb/s"
output = f' {upload} /  {download}'

print(output, flush=True)
