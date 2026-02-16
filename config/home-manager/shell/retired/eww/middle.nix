{ ... }:
let
  arrows = import ./arrows.nix;

  rightEndingArrow = arrows.rightEndingArrow;
  rightStartingArrow = arrows.rightStartingArrow;
  leftEndingArrow = arrows.leftEndingArrow;
  leftStartingArrow = arrows.leftStartingArrow;

  dateName = ''
    ${rightEndingArrow}
    (label
      :text {dateName}
      :class "dateName"
    )
    ${rightStartingArrow}'';

  dateHour = ''
    ${rightEndingArrow}
    (label
      :text {dateHour}
      :class "dateHour"
    )
    ${leftEndingArrow}
  '';

  dateDate = ''
    ${leftStartingArrow}
    (label
      :text {dateDate}
      :class "dateDate"
    )
    ${leftEndingArrow}
  '';
  middle = ''
    (box
      :space-evenly false
      ${dateName}
      ${dateHour}
      ${dateDate}
    )
  '';
in
{ inherit middle; }
