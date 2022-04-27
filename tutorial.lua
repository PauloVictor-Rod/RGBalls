-----------------------------------------------------------------------------------------
--
-- tutorial1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

local background
local text1
local nextButton
local redLight
local blueLight
local greenLight
local luzAtual = 3
local pausarLuzes = false

local liberarToutch = false

local function gotoTutorial2()
  
  if(liberarToutch)then
    composer.gotoScene( "tutorial2", { time=1200, effect="slideLeft" } )
  end

end

local function lightsCollors()

    luzAtual = math.random(3)

    if( luzAtual == 1 ) then
       
        transition.to( blueLight, { transition = easing.inExpo, alpha=0.5, time=1000,
        onComplete = function()
            
        end
    } ) 

        transition.to( redLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } )
        
        transition.to( greenLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } )

    elseif( luzAtual == 2 ) then
       
        transition.to( blueLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } ) 
        
        transition.to( redLight, { transition = easing.inExpo, alpha=0.5, time=1000,
        onComplete = function()
            
        end
    } )
        
        transition.to( greenLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } )    

    elseif( luzAtual == 3 ) then
       
        transition.to( blueLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } ) 
        
        transition.to( redLight, { transition = easing.inExpo, alpha=0, time=1000,
        onComplete = function()
            
        end
    } )
        
        transition.to( greenLight, { transition = easing.inExpo, alpha=0.5, time=1000,
        onComplete = function()
            
        end
    } )    


   end     
end

local function menuLoop()

    lightsCollors()  

end

gameLoopTimer = timer.performWithDelay( 1000, menuLoop, 0 )

-- COMPOSER ------------------------------------------------------------------------------------------------------------------------------------


composer.recycleOnSceneChange = true;

function scene:create( event )

  local sceneGroup = self.view

background = display.newImageRect( "Sprites/backgroundGreen.png", 360, 570 ) -- carrega a imagem de fundo da tela
background.x = display.contentCenterX
background.y = display.contentCenterY

text1 = display.newImageRect( "Sprites/Tutorial_Text.png", 340, 570 ) -- carrega a imagem de fundo da tela
text1.x = display.contentCenterX
text1.y = display.contentCenterY 

nextButton = display.newImageRect( "Sprites/Next.png", 110, 50 ) -- carrega a imagem de fundo da tela
nextButton.x = display.contentCenterX + 100
nextButton.y = display.contentCenterY + 260 
nextButton.alpha = 0.2 

redLight = display.newImageRect( "Luzes/redLight.png", 360, 570 ) -- carrega a imagem de fundo da tela
redLight.x = display.contentCenterX
redLight.y = display.contentCenterY
redLight.alpha = 0

blueLight = display.newImageRect( "Luzes/blueLight.png", 360, 570 ) -- carrega a imagem de fundo da tela
blueLight.x = display.contentCenterX
blueLight.y = display.contentCenterY
blueLight.alpha = 0

greenLight = display.newImageRect( "Luzes/greenLight.png", 360, 570 ) -- carrega a imagem de fundo da tela
greenLight.x = display.contentCenterX
greenLight.y = display.contentCenterY
greenLight.alpha = 0

  sceneGroup:insert(background)
  sceneGroup:insert(text1)
  sceneGroup:insert(nextButton)
  sceneGroup:insert(redLight)
  sceneGroup:insert(greenLight)
  sceneGroup:insert(blueLight)

transition.to( nextButton, { transition = easing.inExpo, alpha=1, time=4000,
        onComplete = function()
            liberarToutch = true
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
    
  nextButton:addEventListener( "touch", gotoTutorial2 )

    --audio.play( musicMenu )
  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)
    --audio.stop()
    display.remove(sceneGroup)
    
  elseif ( phase == "did" ) then
 
    composer.removeScene("tutorial")
    composer.hideOverlay()
    Runtime:removeEventListener("touch", gotoTutorial2)

  end
end

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
 


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





