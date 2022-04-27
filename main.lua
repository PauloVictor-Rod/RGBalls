-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

musicMenu = audio.loadSound("Audio/NoControl.mp3")
musicGame = audio.loadSound("Audio/Chiefs.mp3")

contaCena = 0
-- hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

function splashScreen()

	logo = display.newImage("Logo/origames.png")

	logo.alpha = 1
	logo.x = display.contentCenterX
	logo.y = display.contentCenterY
	

	transition.to(logo, {transition = easing.outSine, time = 500, delay = 5000, alpha = 0})

	-- Go to the menu screen
	composer.gotoScene( "menu" )
end

-- VAI PARA O MENU
splashScreen()

