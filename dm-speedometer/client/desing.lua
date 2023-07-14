loadstring(exports["MahLib"]:getFunctions("animations"))()
gui = {}



gui.day_background = {
    elm = guiCreateStaticImage(0.81,0.685,0.18,0.33,"imgs/daybackground.png",true),
    state = false,
}

gui.night_background = {
    elm = guiCreateStaticImage(0.81,0.685,0.18,0.33,"imgs/nightbackground.png",true),
    state = false,
}

guiSetVisible(gui.day_background.elm,false)
guiSetVisible(gui.night_background.elm,false)
guiSetEnabled(gui.day_background.elm,false)
guiSetEnabled(gui.night_background.elm,false)




