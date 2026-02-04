import psutil
import time
import json

while True:
	network = psutil.net_io_counters(pernic=False, nowrap=True)
	prevUpload = network.bytes_sent
	prevDownload = network.bytes_recv

	time.sleep(1)
	network = psutil.net_io_counters(pernic=False, nowrap=True)
	upload = network.bytes_sent - prevUpload
	download = network.bytes_recv - prevDownload

	if int(upload) >= 1000000:
		upload = f"{(upload / 1000000):.1f}Mb/s"
	elif int(upload) >= 1000:
		upload = f"{(upload / 1000):.1f}Kb/s"
	elif int(upload) < 1000:
		upload = f"{upload}B/s"
	if int(download) >= 1000000:
		download = f"{(download / 1000000):.1f}Mb/s"
	elif int(download) >= 1000:
		download = f"{(download / 1000):.1f}Kb/s"
	elif int(download) < 1000:
		download = f"{download}B/s"
	output = f'{{"upload": "{upload}","download": "{download}"}}'

	print(output, flush=True)
