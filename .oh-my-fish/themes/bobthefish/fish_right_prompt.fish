function fish_right_prompt -d 'bobthefish is all about the right prompt'
  printf "[%s] " $vi_mode
  set_color $fish_color_autosuggestion[1]
  date
  set_color normal
end
