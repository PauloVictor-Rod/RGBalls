-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

--print(contaCena)
local composer = require( "composer" )

local scene = composer.newScene()

 

local background
local redLight
local blueLight
local greenLight
local luzAtual = 3
local pausarLuzes = false

local logo
local startButton
local aboutButton
local tutorialButton

local liberarToutch = false



local function gotoPressToStart()
  if(liberarToutch)then
  contaCena = 0
  audio.stop()
  timer.cancel(gameLoopTimer)
  composer.gotoScene( "gameScene", { time=1200, effect="slideDown" } )
  end

end

local function gotoHowToPlay()
  if(liberarToutch)then
     contaCena = contaCena + 1
     composer.gotoScene( "tutorial", { time=1200, effect="slideLeft" } )
  end
end

local function gotoAboutTheGame()
  if(liberarToutch)then
   contaCena = contaCena + 1	
   composer.gotoScene( "sobre", { time=1200, effect="slideRight" } )
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



--
--COMPOSER --------------------------------------
--
composer.recycleOnSceneChange = true;


function scene:create( event )

  local sceneGroup = self.view


end

-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
  -- Code here runs when the scene is still off screen (but is about to come on screen)
background = display.newImageRect( "Sprites/background.png", 360, 570 ) -- carrega a imagem de fundo da tela
background.x = display.contentCenterX
background.y = display.contentCenterY

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

logo = display.newImageRect( "Sprites/logoGame.png", 340, 190 ) -- carrega a imagem de fundo da tela
logo.x = display.contentCenterX
logo.y = display.contentCenterY / 3


  startButton = display.newImageRect( "Sprites/startButton.png", 300, 80 ) -- carrega a imagem de fundo da tela
  startButton.x = display.contentCenterX
  startButton.y = display.contentCenterY 
  startButton.myName = "start"
  startButton.alpha = 0.2

  tutorialButton = display.newImageRect( "Sprites/tutorial.png", 300, 80 ) -- carrega a imagem de fundo da tela
  tutorialButton.x = display.contentCenterX
  tutorialButton.y = display.contentCenterY + 80
  tutorialButton.myName = "tutorial"
  tutorialButton.alpha = 0.2

  aboutButton = display.newImageRect( "Sprites/aboutButton.png", 300, 80 ) -- carrega a imagem de fundo da tela
  aboutButton.x = display.contentCenterX
  aboutButton.y = display.contentCenterY + 163
  aboutButton.myName = "about"
  aboutButton.alpha = 0.2

  startButton:removeEventListener( "touch", gotoPressToStart )
  tutorialButton:removeEventListener( "touch", gotoHowToPlay )
  aboutButton:removeEventListener( "touch", gotoAboutTheGame )

  startButton:addEventListener( "touch", gotoPressToStart )
  tutorialButton:addEventListener( "touch", gotoHowToPlay )
  aboutButton:addEventListener( "touch", gotoAboutTheGame )
    
  
  sceneGroup:insert(background)
  sceneGroup:insert(logo)
  sceneGroup:insert(startButton)
  sceneGroup:insert(tutorialButton)
  sceneGroup:insert(aboutButton)
  sceneGroup:insert(redLight)
  sceneGroup:insert(blueLight)
  sceneGroup:insert(greenLight)

   transition.to( startButton, { transition = easing.inExpo, alpha=1, time=2000,
        onComplete = function()
            liberarToutch = true
        end
    } )    
    transition.to( tutorialButton, { transition = easing.inExpo, alpha=1, time=2000,
        onComplete = function()
            
        end
    } )    
     transition.to( aboutButton, { transition = easing.inExpo, alpha=1, time=2000,
        onComplete = function()
            
        end
    } )      


  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    -- Play music
    
    if(contaCena == 0)then 
  audio.play( musicMenu )    
    end

  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
   
    display.remove(sceneGroup)

  elseif ( phase == "did" ) then
    
    composer.removeScene("menu")
    composer.hideOverlay()
    Runtime:removeEventListener("touch", gotoPressToStart)
    Runtime:removeEventListener("touch", gotoHowToPlay)
    Runtime:removeEventListener("touch", gotoAboutTheGame)
  

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





