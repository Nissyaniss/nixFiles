from __future__ import annotations

import html
import json
import os
import re
import socket as sockmod
import subprocess
import sys
from typing import Any, Generator


def call(command: str) -> Any:
    return json.loads(subprocess.run(["hyprctl", "-j", command], capture_output=True, check=True).stdout)


def events() -> Generator[tuple[str, str], None, None]:
    sock = sockmod.socket(sockmod.AF_UNIX, sockmod.SOCK_STREAM)
    sock.connect(f"{os.environ['XDG_RUNTIME_DIR']}/hypr/{
                 os.environ['HYPRLAND_INSTANCE_SIGNATURE']}/.socket2.sock")
    socket = sock.makefile()

    while True:
        event = socket.readline().strip()
        name, value = event.split(">>")
        yield name, value

    socket.close()
    sock.close()


def print_data(workspaces: list[str], active_workspace: str) -> None:
    print(
        json.dumps(
            [
                {"id": workspace, "active": workspace == active_workspace}
                for workspace in workspaces
            ],
        ),
        flush=True,
    )


result = call("workspaces")
workspaces = [
    workspace["name"] for workspace in result if workspace["name"] != "special"
]
result = call("activeworkspace")
active_workspace = result["name"]

workspaces.sort(key=int)
print_data(workspaces, active_workspace)

for name, value in events():
    updated = True
    if name == "workspace":
        active_workspace = value
    elif name == "createworkspace":
        workspaces.append(value)
    elif name == "destroyworkspace":
        workspaces.remove(value)
    else:
        updated = False

    if updated:
        workspaces.sort(key=int)
        print_data(workspaces, active_workspace)
