-----------------------------------------------------------------------------------------
--
-- sobre.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

local background
local text1
local menuButton
local restartButton

local liberarToutch = false




local function gotoMenu()
  
  if(liberarToutch)then
    composer.gotoScene( "menu", { time=1200, effect="slideUp" } )
  end

end

local function backToGame()
  
  if(liberarToutch)then
    composer.gotoScene( "gameScene", { time=800, effect="crossFade" } )
  end

end

composer.recycleOnSceneChange = true;

function scene:create( event )

  local sceneGroup = self.view

background = display.newImageRect( "Sprites/backgroundBlue.png", 360, 570 ) -- carrega a imagem de fundo da tela
background.x = display.contentCenterX
background.y = display.contentCenterY

text1 = display.newImageRect( "Sprites/gameOver.png", 340, 570 ) -- carrega a imagem de fundo da tela
text1.x = display.contentCenterX
text1.y = display.contentCenterY 

menuButton = display.newImageRect( "Sprites/Menu.png", 110, 50 ) -- carrega a imagem de fundo da tela
menuButton.x = display.contentCenterX + 80
menuButton.y = display.contentCenterY + 100  
menuButton.alpha = 0.2

restartButton = display.newImageRect( "Sprites/restart.png", 110, 50 ) -- carrega a imagem de fundo da tela
restartButton.x = display.contentCenterX - 80
restartButton.y = display.contentCenterY  + 100
restartButton.alpha = 0.2

  Score = composer.getVariable("score")
  print(Score)
 
  txTexto = display.newText( Score,display.contentCenterX,display.contentCenterY,"Linguagem/urae_nium", 72 )
  txTexto:setTextColor( 100, 100, 250 ) -- Cor do texto (RGB) 
  txTexto.text = string.format("%.2f", Score)

  sceneGroup:insert(background)
  sceneGroup:insert(text1)
  sceneGroup:insert(menuButton)
  sceneGroup:insert(restartButton)
  sceneGroup:insert(txTexto)

transition.to( restartButton, { transition = easing.inExpo, alpha=1, time=2000,
        onComplete = function()
            liberarToutch = true
        end
} ) 
transition.to( menuButton, { transition = easing.inExpo, alpha=1, time=2000,
        onComplete = function()
           
        end
} ) 


end

-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
  -- Code here runs when the scene is still off screen (but is about to come on screen)

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    -- Play music
  
  restartButton:addEventListener( "touch", backToGame )  
  menuButton:addEventListener( "touch", gotoMenu )

    --audio.play( musicMenu )
  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
   
    display.remove(sceneGroup)

  elseif ( phase == "did" ) then
    
    composer.removeScene("gameOver")
    composer.hideOverlay()
    Runtime:removeEventListener("touch", gotoMenu)
    Runtime:removeEventListener("touch", backToGame)
    
  end

end

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene





