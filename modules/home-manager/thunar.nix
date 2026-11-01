{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.local.thunar;

  mkAction = name: action: ''
    <action>
      <icon>${action.icon}</icon>
      <name>${lib.escapeXML name}</name>
      <unique-id>${action.id}</unique-id>
      <command>${lib.escapeXML action.command}</command>
      <description>${lib.escapeXML action.description}</description>
      <patterns>${action.patterns}</patterns>
      <directories/>
    </action>
  '';

  actionOptions = lib.types.submodule (_: {
    options = {
      icon = lib.mkOption {
        type = lib.types.str;
        default = "utilities-terminal";
      };

      submenu = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      id = lib.mkOption {
        type = lib.types.str;
      };

      command = lib.mkOption {
        type = lib.types.str;
      };

      description = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      range = lib.mkOption {
        type = lib.types.str;
        default = "*";
      };

      patterns = lib.mkOption {
        type = lib.types.str;
        default = "*";
      };
    };
  });
in
{
  options.local.thunar = {
    enable = lib.mkEnableOption "Thunar";
    package = lib.mkPackageOption pkgs "thunar" { };
    customActions = lib.mkOption {
      type = lib.types.attrsOf actionOptions;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = {
      "Thunar/uca.xml".text =
        "
    	<?xml version=\"1.0\" encoding=\"UTF-8\"?>
   		<actions>
    	${lib.concatStrings (lib.mapAttrsToList mkAction cfg.customActions)}
    	</actions>
  	";
    };
    xdg.mimeApps = {
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };

}

