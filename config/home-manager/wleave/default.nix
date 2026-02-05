{
	...
}: {
	programs.wleave = {
		enable = true;
		settings = {
			buttons = [
				{
					label = "lock";
					action = "swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000";
					text = "Lock";
					keybind = "l";
					icon = "${./icons/lock.svg}";
				}
				{
					label = "hibernate";
					action = "systemctl hibernate";
					text = "Hibernate";
					keybind = "h";
					icon = "${./icons/hibernate.svg}";
				}
				{
					label = "logout";
					action = "loginctl terminate-user $USER";
					text = "Logout";
					keybind = "e";
					icon = "${./icons/logout.svg}";
				}
				{
					label = "shutdown";
					action = "systemctl poweroff";
					text = "Shutdown";
					keybind = "s";
					icon = "${./icons/shutdown.svg}";
				}
				{
					label = "suspend";
					action = "systemctl suspend";
					text = "Suspend";
					keybind = "u";
					icon = "${./icons/suspend.svg}";
				}
				{
					label = "reboot";
					action = "systemctl reboot";
					text = "Reboot";
					keybind = "r";
					icon = "${./icons/reboot.svg}";
				}
			];
		};
		style = ''
			* {
        		background-image: none;
			}
			window {
			        background-color: rgba(12, 12, 12, 0);
			}
			button {
			    color: #FFFFFF;
			        background-color: #1E1E1E;
			        border-style: solid;
			        border-width: 2px;
			        background-repeat: no-repeat;
			        background-position: center;
			        background-size: 25%;
			
			        animation: gradient_f 20s ease-in infinite;
			}
			
			button:focus, button:active, button:hover {
			        background-color: #3700B3;
			        outline-style: none;
			}
			
			button:focus {
			        background-color: rgba(114, 211, 254, 0.8);
			}
			
			button:hover {
			        background-size: 35%;
			        background-color: rgba(176, 165, 255, 0.8);
			        border-radius: 20px;
			
			        transition: all 0.3s cubic-bezier(.55,0.0,0.28,1.682);
			}
			
			button:hover#lock {
			  border-radius: 20px;
			  margin: 0px 30px 30px 0px;
			}
			
			button:hover#logout {
			  margin: 0px 30px 30px 30px;
			}
			
			button:hover#suspend {
			  border-radius: 20px;
			  margin: 0px 0px 30px 30px;
			}
			
			button:hover#hibernate {
			  border-radius: 20px;
			  margin: 30px 30px 0px 0px;
			}
			
			button:hover#shutdown {
			  margin: 30px 30px 0px 30px;
			}
			
			button:hover#reboot {
			  border-radius: 20px;
			  margin: 30px 0px 0px 30px;
			}
		'';
	};
}