local doom = {
      [[=================     ===============     ===============   ========  ========]],
      [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
      [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
      [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
      [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
      [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
      [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
      [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
      [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
      [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
      [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
      [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
      [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
      [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
      [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
      [[||.=='    _-'                                                     `' |  /==.||]],
      [[=='    _-'                        N E O V I M                         \/   `==]],
      [[\   _-'                                                                `-_   /]],
      [[ `''                                                                      ``' ]],
}

local cacoademon = {
    '            :h-                                  Nhy`               ',
'           -mh.                           h.    `Ndho               ',
'           hmh+                          oNm.   oNdhh               ',
'          `Nmhd`                        /NNmd  /NNhhd               ',
'          -NNhhy                      `hMNmmm`+NNdhhh               ',
'          .NNmhhs              ```....`..-:/./mNdhhh+               ',
'           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ',
'           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ',
'      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ',
' .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ',
' h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ',
' hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ',
' /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ',
'  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ',
'   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ',
'     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ',
'       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ',
'       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ',
'       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ',
'       //+++//++++++////+++///::--                 .::::-------::   ',
'       :/++++///////////++++//////.                -:/:----::../-   ',
'       -/++++//++///+//////////////               .::::---:::-.+`   ',
'       `////////////////////////////:.            --::-----...-/    ',
'        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ',
'         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ',
'           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ',
'            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``',
'           s-`::--:::------:////----:---.-:::...-.....`./:          ',
'          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ',
'         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ',
'        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ',
'                        .-:mNdhh:.......--::::-`                    ',
'                           yNh/..------..`                          ',
'                                                                    ',

}


return { 'goolord/alpha-nvim',  dependencies = { 'nvim-tree/nvim-web-devicons' } , config = function()
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = cacoademon

dashboard.section.buttons.val = {
   dashboard.button('spc s f', '󰈞  Find file'),
   dashboard.button('spc s s', '󰈬  Find word'),
   dashboard.button('spc h s','⇁ Harpoon Menu'),
   dashboard.button('spc t','⍁ Toggle Trouble'),
}

alpha.setup(dashboard.opts)
end}
