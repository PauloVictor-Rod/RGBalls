-----------------------------------------------------------------------------------------
--
-- gameScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()


-- Fisica iniciada --
local physics = require("physics")
physics.start()
physics.setGravity(0, 0)
-- Física iniciada --
--conferir a física --
--physics.setDrawMode( "hybrid" )  -- Overlays collision outlines on normal display objects
--conferir a física --


W = display.contentWidth  -- Pega a largura da tela
H = display.contentHeight -- Pega a altura da tela

local bgGreen
local bgBlue
local bgRed

local ball
local redball
local blueball
local greenball
local corAtual = 3

local level = 1

local levelAtual = 1
local fatorLevel = level*0.5
local contador = 0
local pegaLevelAtual = levelAtual
--print(pegaLevelAtual)

local vida = 6
local score
local Lives 

local timer1
local died = false

local barraGeradora 


local alert
local levelAlert = 1
local contadorAlert = 0
local levelAtualAlert = 0

local obstaculosTable = {}

-- clicar e arrastar a bola --
local function dragBall( event )
 
    local target = event.target
    local phase = event.phase

    if ( "began" == phase ) then
        -- Ajuste do foco na bola
        display.currentStage:setFocus( ball )
         -- Posição de deslocamento inicial 
        ball.touchOffsetX = event.x - ball.x
        ball.touchOffsetY = event.y - ball.y
       
    elseif ( "moved" == phase ) then
        -- Mova a bola para a nova posição de toque
        
 if(event.x - target.touchOffsetX < display.contentWidth - 25 and event.x - target.touchOffsetX > 25)then
        ball.x = event.x - target.touchOffsetX 
 end
 
 if(event.y - target.touchOffsetY < display.contentHeight   and event.y - target.touchOffsetY > target.contentHeight / 1.5)then
        ball.y = event.y - target.touchOffsetY 
 end

        redball.x = ball.x
        redball.y = ball.y

        blueball.x = ball.x
        blueball.y = ball.y

        greenball.x = ball.x
        greenball.y = ball.y

        if( corAtual == 1 ) then

        blueball.alpha = 1
        redball.alpha = 0
        greenball.alpha = 0   

    elseif( corAtual == 2 ) then

        blueball.alpha = 0
        redball.alpha = 0
        greenball.alpha = 1 
     
        
    elseif( corAtual == 3 ) then
        
        blueball.alpha = 0
        redball.alpha = 1
        greenball.alpha = 0 
       
    end

    elseif ( "ended" == phase or "cancelled" == phase ) then
        -- Liberte o foco do toque na bola
        display.currentStage:setFocus( nil )
        
    return true  -- Previne a propagação do toque para objetos subjacentes        
    
    end
end
-- clicar e arrastar a bola --


local function collorBackground()

    corAtual = math.random(3)

 if( corAtual == 1 ) then

        bgBlue.alpha = 1
        bgRed.alpha = 0
        bgGreen.alpha = 0      

        blueball.alpha = 1
        redball.alpha = 0
        greenball.alpha = 0   

    elseif( corAtual == 2 ) then

        bgBlue.alpha = 0
        bgRed.alpha = 0
        bgGreen.alpha = 1  

        blueball.alpha = 0
        redball.alpha = 0
        greenball.alpha = 1 
     
        
    elseif( corAtual == 3 ) then
            
        bgBlue.alpha = 0
        bgRed.alpha = 1
        bgGreen.alpha = 0  

        blueball.alpha = 0
        redball.alpha = 1
        greenball.alpha = 0 
       
    end


end

-- Criando os obstaculos --
local function criarObstaculo()


    local whereFrom = math.random( 3 )

    if( whereFrom == 1 ) then
        local novoObstaculo = display.newImageRect("Sprites/obstaculoRetAzul.png", 100, 40)
         table.insert( obstaculosTable, novoObstaculo )
         physics.addBody( novoObstaculo, "dynamic", { bounce=0 } )
         novoObstaculo.myName = 1
        
        -- Para o topo e Azul
        novoObstaculo.x = math.random( display.contentWidth )
        novoObstaculo.y = barraGeradora.y
        novoObstaculo:setLinearVelocity( 0, 200*fatorLevel )
        sceneGroup:insert(novoObstaculo)

         
    elseif( whereFrom == 2 ) then

    local novoObstaculoV = display.newImageRect("Sprites/obstaculoRetVerde.png", 100, 40)
    table.insert( obstaculosTable, novoObstaculoV )
    physics.addBody( novoObstaculoV, "dynamic", { bounce=0 } )
    novoObstaculoV.myName = 2
    
        -- Para o topo e Verde
        novoObstaculoV.x = math.random( display.contentWidth )
        novoObstaculoV.y = barraGeradora.y
        novoObstaculoV:setLinearVelocity( 0, 200*fatorLevel )
        sceneGroup:insert(novoObstaculoV)

    elseif( whereFrom == 3 ) then

    local novoObstaculoR = display.newImageRect("Sprites/obstaculoRetVermelho.png", 100, 40)
    table.insert( obstaculosTable, novoObstaculoR )
    physics.addBody( novoObstaculoR, "dynamic", { bounce=0 } )
    novoObstaculoR.myName = 3
    

        -- Para o topo e Verde
        novoObstaculoR.x = math.random( display.contentWidth )
        novoObstaculoR.y = barraGeradora.y
        novoObstaculoR:setLinearVelocity( 0, 200*fatorLevel )
        sceneGroup:insert(novoObstaculoR) 

    end
end 
-- Criando os obstaculos --

local life3
local life2
local life1
local life0


local xDoLife 
local yDoLife 


local function Life()
    
    if(vida == 5)then

        life3.alpha = 0
        life2.alpha = 1
        life1.alpha = 0
        life0.alpha = 0
    end
    if(vida == 3)then

        life3.alpha = 0
        life2.alpha = 0
        life1.alpha = 1
        life0.alpha = 0

    end
    if(vida == 1)then

        life3.alpha = 0
        life2.alpha = 0
        life1.alpha = 0
        life0.alpha = 1

    end    

end

local pausarObstaculo = false

local function startGameLoop()
   -- print("startGameLoop")
    pausarObstaculo = false
   
end

local function gameLoop()

if(not pausarObstaculo)then

    criarObstaculo()
end

    levelAtual = math.floor(contador/15+1)
    print("levelAtual: "  .. levelAtual)

    if(level ~= levelAtual)then
       
       level = levelAtual
       timer.cancel(gameLoopTimer)
       fatorLevel = level*0.5

       delayLevelTimer = timer.performWithDelay( 2000, startGameLoop, 1)
       pausarObstaculo = true
       gameLoopTimer = timer.performWithDelay( 1000/fatorLevel, gameLoop, 0 )
       collorBackground()
    
    end    

    levelAtualAlert = math.floor(contadorAlert/15+1)
    print("levelAlert: " .. levelAlert)

    if(levelAlert ~= levelAtualAlert)then
        
        levelAlert = levelAtualAlert

        transition.to(alert,{time = 1000, xScale = 1, yScale = 1,
         onComplete = function ()
                transition.to(alert,{time = 1000, xScale = 0.5, yScale = 0.5, 
                    onComplete = function()
                        transition.to(alert,{time = 1000, xScale = 1, yScale = 1,
                         onComplete = function ()
                                transition.to(alert,{time = 1500, xScale = 0, yScale = 0})
                            end})
                    end})
            end})
    end
    
 
    -- Remova os obstaculos que escaparam da tela
    for i = #obstaculosTable, 1, -1 do

        local thisObstaculo = obstaculosTable[i]
 
        if ( thisObstaculo.x < -100 or
             thisObstaculo.x > display.contentWidth + 100 or
             thisObstaculo.y < -100 or
             thisObstaculo.y > display.contentHeight + 100 )
        then
            display.remove( thisObstaculo )
            table.remove( obstaculosTable, i )
        end
 
    end

end

gameLoopTimer = timer.performWithDelay( 1000/fatorLevel, gameLoop, 0 )


-- Função de colisão --
local function onCollision( event )

    local obj1 = event.object1
    local obj2 = event.object2

        if ((obj1.myName ~= corAtual) and (obj2.myName == 0)) then 
            
                obj1.alpha = 0
                obj1:setLinearVelocity(100000, 0) 
                vida = vida - 1              
                
                Life()

                if (vida == 0)then
                        timer.cancel(gameLoopTimer)
                        timer.cancel(timer1)

                        ball:removeEventListener( "touch", dragBall )

                        life0.alpha = 0
                        audio.stop()
                        composer.setVariable("score", contador)
                        composer.gotoScene( "gameOver", { time=1200, effect="crossFade" } )

                end   

               -- print(vida)
        end

end

-- função de colisão --

Runtime:addEventListener( "collision", onCollision )




-- pontuação por tempo -- 


local function timerPoint()
    contador = contador + 0.01 -- Incrementa o contador
    contadorAlert = contador + 3
    txTexto.text = string.format("%.2f", contador) -- Mostra o contador no Texto
end

-- pontuação por tempo --
timer1 = timer.performWithDelay( 10, timerPoint, -1 )



--COMPOSER
-----------------------------------------------------------------------------------------------
--COMPOSER

composer.recycleOnSceneChange = true;
function scene:create( event )

    sceneGroup = self.view



end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase



  if ( phase == "will" ) then

  -- Code here runs when the scene is still off screen (but is about to come on screen)
bgGreen = display.newImageRect( "Sprites/backgroundGreen.png", 360, 570 ) -- carrega a imagem de fundo da tela
bgGreen.x = display.contentCenterX
bgGreen.y = display.contentCenterY
bgGreen.alpha = 0

bgBlue = display.newImageRect( "Sprites/backgroundBlue.png", 360, 570 ) -- carrega a imagem de fundo da tela
bgBlue.x = display.contentCenterX
bgBlue.y = display.contentCenterY  
bgBlue.alpha = 0

bgRed = display.newImageRect( "Sprites/background.png", 360, 570 ) -- carrega a imagem de fundo da tela
bgRed.x = display.contentCenterX
bgRed.y = display.contentCenterY
bgRed.alpha = 1

blueball = display.newImageRect("Sprites/blueball.png", 150, 150)
        blueball.x = display.contentCenterX 
        blueball.y = display.contentHeight 
        physics.addBody( blueball, "static", {radius=25, isSensor=true } )
        blueball.isBullet = true
        blueball.alpha = 0
        blueball.myName = 1

greenball = display.newImageRect("Sprites/greenball.png", 150, 150)
        greenball.x = display.contentCenterX 
        greenball.y = display.contentHeight      
        physics.addBody( greenball, "static", {radius=25, isSensor=true } )
        greenball.isBullet = true
        greenball.alpha = 0
        greenball.myName = 2

redball = display.newImageRect("Sprites/redball.png", 150, 150)
        redball.x = display.contentCenterX
        redball.y = display.contentHeight 
        physics.addBody( redball, "static", {radius=25, isSensor=true } )
        redball.isBullet = true
        redball.alpha = 1
        redball.myName = 3

ball = display.newImageRect("Sprites/redball.png", 150, 150)
        ball.x = display.contentCenterX
        ball.y = display.contentHeight 
        physics.addBody( ball, "static", {radius=25, isSensor=true } )
        ball.isBullet = true
        ball.alpha = 0.01        
        ball.myName = 0

score = display.newImageRect ("Sprites/Timer.png", 110, 50)
        score.x = display.contentCenterX + 100
        score.y = display.contentCenterY - 260

txTexto = display.newText( contador, W-60, H/20  , "Linguagem/urae_nium", 40 )
        txTexto:setTextColor( 100, 100, 250 ) -- Cor do texto (RGB)        

Lives = display.newImageRect ("Sprites/Lives.png", 110, 50)
        Lives.x = display.contentCenterX - 100
        Lives.y = display.contentCenterY - 260        

        ball:addEventListener( "touch", dragBall )

life3 = display.newImageRect("Sprites/Vida/Vida=3.png", 200, 40)
life3.x = display.contentCenterX - 60
life3.y = display.contentCenterY /11
xDoLife = life3.x
yDoLife = life3.y

life2 = display.newImageRect("Sprites/Vida/Vida=2.png", 200, 40)
life2.x = xDoLife
life2.y = yDoLife

life1 = display.newImageRect("Sprites/Vida/Vida=1.png", 200, 40)
life1.x = xDoLife
life1.y = yDoLife

life0 = display.newImageRect("Sprites/Vida/Vida=0.png", 200, 40)
life0.x = xDoLife
life0.y = yDoLife

life3.alpha = 1
life2.alpha = 0
life1.alpha = 0
life0.alpha = 0

barraGeradora = display.newImageRect("Sprites/BarraGeradora.png", 500, 60)
barraGeradora.x = display.contentCenterX 
barraGeradora.y = display.contentCenterY /4
barraGeradora.alpha = 0
transition.to( barraGeradora, { transition = easing.inExpo, alpha=0.5, time=2000,
        onComplete = function()
            
        end
    } )

alert = display.newImage("Sprites/alert.png",0,0)
alert.x = display.contentCenterX 
alert.y = display.contentCenterY - 260
alert.width = 100
alert.height = 40
alert.xScale = 0.001
alert.yScale = 0.001

    sceneGroup:insert(bgGreen)    
    sceneGroup:insert(bgBlue)
    sceneGroup:insert(bgRed)
    sceneGroup:insert(greenball)
    sceneGroup:insert(blueball)
    sceneGroup:insert(redball)
    sceneGroup:insert(ball)
    sceneGroup:insert(score)
    sceneGroup:insert(Lives)
    sceneGroup:insert(life3)
    sceneGroup:insert(life2)
    sceneGroup:insert(life1)
    sceneGroup:insert(life0)
    sceneGroup:insert(barraGeradora)

    sceneGroup:insert(alert)

    sceneGroup:insert(txTexto)


  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    audio.play( musicGame )
    
    
  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
   
    display.remove(sceneGroup)

  elseif ( phase == "did" ) then
    
    composer.removeScene("gameScene")
    composer.hideOverlay()
    Runtime:removeEventListener("colision", onCollision)
    Runtime:removeEventListener("touch", dragBall)

    
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


