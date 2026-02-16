{ lib
, machine-name
, ...
}:
let
  arrows = import ./arrows.nix;

  leftEndingArrow = arrows.leftEndingArrow;
  leftStartingArrow = arrows.leftStartingArrow;

  logout = ''
    (button
      :onclick "wlogout -p layer-shell&"
      :hexpand false
      :class "powermenu"
      (label
        :text "⏻")
    )
    ${leftEndingArrow}'';

  battery = ''
    ${leftStartingArrow}
    (label
      :text {battery.text}
      :class {battery.percent > 75 ? "battery-perfect" : battery.percent > 50 ? "battery-good" : battery.percent > 25 ? "battery-mid" : "battery-bad"}
    )
    ${leftEndingArrow}
  '';

  workspaces = ''
    ${leftStartingArrow}
    (box
      :space-evenly false
      (for workspace in {workspace}
        (button
          :class "workspace"
          :onclick "hyprctl dispatch workspace {workspace.id}"
          (label
            :text {workspace.active == true ? "" : "" }
            :class {workspace.active == true ? "workspace-active" : "workspace" }
          )
        )
      )
    )
    ${leftEndingArrow}
  '';

  mpris = ''
    (label
      :visible {mpris-status != ""}
      :text ""
      :class "left-starting-arrow"
    )
    (box
      :space-evenly false
      :class "mpris"
      :visible {mpris-status != ""}
      (eventbox
        :visible {mpris-status != ""}
        :onclick "playerctl play-pause"
        :onhover "eww update mpris-hidden=false"
        :onhoverlost "eww update mpris-hidden=true"
        (box
          :space-evenly false
          (revealer
            :reveal { ! mpris-hidden }
            :transition "slideleft"
            :duration "500ms"
            (button
              :class "mpris-previous"
              :onclick "playerctl previous"
              (label
                :text "󰒫"
              )
            )
          )
          (label
            :class "mpris"
            :text "''${mpris-title}"
          )
          (revealer
            :reveal { ! mpris-hidden }
            :transition "slideright"
            :duration "500ms"
            (button
              :class "mpris-next"
              :onclick "playerctl next"
              (label
                :text "󰒬"
              )
            )
          )
          (label
            :text "''${mpris-status == "Playing" ? " 󰏤" : " 󰐊"}"
          )
        )
      )
    )
    (label
      :visible {mpris-status != ""}
      :text ""
      :class "left-ending-arrow"
    )
  '';

  left = ''
    (box
      :space-evenly false
      ${logout}
      ${lib.optionalString (machine-name == "laptop") battery}
      ${workspaces}
      ${mpris}
    )
  '';

in
{ inherit left; }
