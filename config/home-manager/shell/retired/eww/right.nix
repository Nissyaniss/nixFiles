{ ... }:
let
  arrows = import ./arrows.nix;

  rightEndingArrow = arrows.rightEndingArrow;
  rightStartingArrow = arrows.rightStartingArrow;

  network = ''
    ${rightEndingArrow}
    (label
      :class "network"
      :text " ''${network.upload} /  ''${network.download}"
    )
    ${rightStartingArrow}'';

  memory = ''
    ${rightEndingArrow}
    (label
      :text "Mem ''${memory.memory}"
      :class "memory"
    )
    ${rightStartingArrow}'';

  cpu = ''
    ${rightEndingArrow}
    (label
      :text "Cpu ''${cpu.cpu}"
      :class "cpu"
    )
    ${rightStartingArrow}'';

  systray = ''
    ${rightEndingArrow}
    (systray
      :class "systray"
      :icon-size 18
    )'';

  right = ''
    (box
      :space-evenly false
      :halign "end"
      ${network}
      ${memory}
      ${cpu}
      ${systray} 
    )
  '';
in
{ inherit right; }
