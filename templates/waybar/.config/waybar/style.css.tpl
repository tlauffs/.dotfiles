* {
  border: none;
  border-radius: 0;
  min-height: 0;
  font-family: "${FONT_FAMILY}"; 
  font-weight: 500;
  font-size: 12px;
  padding: 0;
}

window#waybar {
  background: ${THEME_BASE00}; 
  border: 2px solid ${THEME_BASE02}; 
}

tooltip {
  background-color: ${THEME_BASE00};
  border: 5px solid ${THEME_BASE03};
}

#disk,
#memory,
#battery,
#network,
#pulseaudio,
#clock,
#tray {
  margin: 6px;
  padding: 2px 4px;
  background-color: ${THEME_BASE01}; 
  border: 2px solid ${THEME_BASE02};
  color: ${THEME_BASE04}; 
  border-radius: 2px;
}

#window {
  background: transparent;
  border: none;
  color: ${THEME_BASE05}; 
  font-size: 14px;
  padding: 0 8px;
}

#workspaces {
  background-color: ${THEME_BASE01};
  padding: 0 5px;
  margin: 6px 0px 6px 6px;
  border: 2px solid ${THEME_BASE02}; 
}

#workspaces button {
  all: initial;
  min-width: 20px;
  box-shadow: inset 0 -3px transparent;
  padding: 2px 4px;
  color: ${THEME_BASE04}; 
}

#workspaces button.focused {
  color: ${THEME_BASE05}; 
}

#workspaces button.urgent {
  background-color: ${THEME_BASE08};
}

#battery.warning {
  color: ${THEME_BASE00}; 
}

#battery.critical {
  color: ${THEME_BASE08}; 
}
