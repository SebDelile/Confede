godImages = {
	"http://cloud-3.steamusercontent.com/ugc/1021699036692979265/384EA6A985E51AE4FDDAB271F29FAA21E4A677F6/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692979884/4553C6AFBB057533EB25804D6D02F066089B9BD4/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692979589/F52399A1DDED9ACA98573381D9146A84811E386D/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692978746/B2CAEFB91D7E82863EB03F6B6729E6B6314045DB/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036689845560/23D0108E09BF4539244F262661CC10DEDE4DC903/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692980105/A393E3A39FF1601EB6E3F410C0930E8BDBD32BD8/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692980725/6AF8AE6E81E8E5E13DE09CF7BA5FD926421040CC/",
	"http://cloud-3.steamusercontent.com/ugc/1021699036692980442/6F065C202CD6B9FC3EBA9A2A75188E32F1A1907F/",
}

panicTest = false

diceImages = {
    ["Confede"]="http://cloud-3.steamusercontent.com/ugc/1663478958357947166/D6DBA8AA1E2530C3FC05B2179C5E6A4F728CC5BE/",
    ["Baratheon"]="http://cloud-3.steamusercontent.com/ugc/784121429276807317/0A2555822CDDB1BC3EA84AB1E16BD528FD82A8B7/",
    ["FF"]="http://cloud-3.steamusercontent.com/ugc/784121429276808551/8B23C70F43F565DE3CB338469183DB1728C7BCAF/",
    ["Lannister"]="http://cloud-3.steamusercontent.com/ugc/965346181997314000/ECF69000D8F84FCFB63EA81F01A8E649984FE481/",
    ["Neutral"]="http://cloud-3.steamusercontent.com/ugc/1016066563310188652/342A41C2A788E0B7FFC0D5C8F373F05DCB430082/",
	    ["NW"]="http://cloud-3.steamusercontent.com/ugc/790863026330013489/5C7416D22B4AFF268C50B23E905A6434768B228B/",
    ["Stark"]="http://cloud-3.steamusercontent.com/ugc/998053477505919587/3EE68D70440A5D5515AE8C92607E539F82F8BA8E/",
    ["Targaryen"]="http://cloud-3.steamusercontent.com/ugc/788633557745588790/0D7C7589BDFF314FF1C8FF35579FDBA5F57047F8/",
    ["d3"]="https://i.imgur.com/IuskI86.png",
}

diceImagesIndex = {
    "Confede", "Baratheon", "FF", "Lannister", "Neutral", "NW", "Stark", "Targaryen",
}

diff = 3

buttonsIndex = {
	["SwitchImg"]=0,
	["SwitchDice"]=1,
	["D6"]=2,
	["ClearDice"]=3,
	["Roll"]=4,
	["Diff"]=5,
	["RerollS"]=6,
	["RerollM"]=7,
	["PanicTest"]=8,
}

buttonParams = {
		function_owner = self,
        rotation       = {0, 0, 0},
        width          = 300,
        height         = 100,
        color          = {0.4, 0.4, 0.4},
        font_color     = {1, 1, 1},
}


function onLoad()
	index = 0
    CreateButton_SwitchImg()
	buttonsIndex["SwitchImg"]=index
	index = index+1
	CreateButton_SwitchDice()
	buttonsIndex["SwitchDice"]=index
	index = index+1
    CreateButton_D6()
	buttonsIndex["D6"]=index
	index = index+1
    CreateButton_ClearDice()
	buttonsIndex["ClearDice"]=index
	index = index+1
    CreateButton_Roll()
	buttonsIndex["Roll"]=index
	index = index+1
    CreateButton_Diff()
	buttonsIndex["Diff"]=index
	index = index+1
    CreateButton_RerollS()
	buttonsIndex["RerollS"]=index
	index = index+1
    CreateButton_RerollM()
	buttonsIndex["RerollM"]=index
	index = index+1
    CreateButton_PanicTest()
	buttonsIndex["PanicTest"]=index
	index = index+1
	ClearDice()
end



--[[ Buttons creation ]]--
function CreateButton_PanicTest()
   local params = buttonParams
	params["click_function"] = "click_RollPanicTest"
	params["label"]= "Panic test"
	params["position"] = {-1.3, 0.2, -0.6}
	params["tooltip"] = ""
	params["font_size"] = 64

    self.createButton(params)
end


function click_RollPanicTest(obj, color, alt_click)

ClearDice()
SpawnPanicTest()
panicTest = true
Wait.time(|| Roll(color), 1.5)
end

function CreateButton_SwitchDice()
	local params = buttonParams
	params["click_function"] = "click_SwitchDice"
	params["label"]= "Change Dice"
	params["position"] = {0.75, 0.2, -1.2}
	params["tooltip"] = ""
	params["font_size"] = 32

    self.createButton(params)
end

diceImage = 0

function click_SwitchDice(obj, color, alt_click)

    ClearDice()
    diceImage = diceImage + 1
    if diceImage == 8 then diceImage = 1 end
     s = ""
    local tmp = 1
    for i, v in pairs(diceImages) do
        if tmp == diceImage then
            s = s..i
        end
        tmp = tmp + 1
    end
    s = s.." dice"
    self.editButton({index=buttonsIndex["SwitchDice"], label=s})
end

function CreateButton_SwitchImg()

	local params = buttonParams
	params["click_function"] = "click_SwitchImg"
	params["label"]= "Change God"
	params["position"] = {-0.75, 0.2, -1.2}
    params["tooltip"] = ""
	params["font_size"] = 32

    self.createButton(params)
end

function click_SwitchImg(obj, color, alt_click)

    ClearDice()
    local tmp = 0
    for i, v in pairs(godImages) do
        if v == self.getCustomObject()["image"] then
            tmp = i
        end
    end
    if tmp == 8 then tmp = 0 end
    tmp = tmp + 1
    self.setCustomObject({image=godImages[tmp]})
    self.reload()
end

function CreateButton_Diff()
    local params = buttonParams
	params["click_function"] = "click_diff"
	params["label"]= "3+"
	params["position"] ={-1.3, 0.2, 0.8}
	params["tooltip"] = "Right click to decrease difficulty"
	params["font_size"] = 80

    self.createButton(params)
end

function click_diff(obj, color, alt_click)

    if alt_click==false then
       if diff < 6 then diff = diff + 1 end
    else
       if diff > 2 then diff = diff - 1 end
    end

    s = diff .. "+"
    self.editButton({index=buttonsIndex["Diff"], label=s})
end





function CreateButton_D6()
    local params = buttonParams
	params["click_function"] = "click_D6"
	params["label"]= "d6"
	params["position"] = {-1.3, 0.2, 0.55}
	params["tooltip"] = "Right click to remove 1d6"
	params["font_size"] = 80

    self.createButton(params)
end

function click_D6(obj, color, alt_click)
    if panicTest == true then
        ClearDice()
        panicTest = false
    end
   if alt_click==false then
        SpawnDie()
    else
        DeleteDie()
    end
end


function CreateButton_ClearDice()
    local params = buttonParams
	params["click_function"] = "click_Clear"
	params["label"]= "Clear dice"
	params["position"] = {1.3, 0.2, 0.8}
	params["font_size"] = 64
	params["tooltip"] = ""

    self.createButton(params)
end

function click_Clear(obj, color, alt_click)
    panicTest = false
    ClearDice()
end



function CreateButton_Roll()
    local params = buttonParams
	params["click_function"] = "click_Roll"
	params["label"]= "Roll !"
	params["position"] = {-0.8, 0.2, 1.2}
	params["font_size"] = 64
	params["tooltip"] = ""

    self.createButton(params)
end

function click_Roll(obj, color, alt_click)
     if panicTest == true then return end
    Roll(color)
end


function CreateButton_RerollS()

    local params = buttonParams
	params["click_function"] = "click_RerollS"
	params["label"]= "Reroll successes"
	params["position"] = {0.65, 0.2, 1.2}
	params["font_size"] = 40
	params["tooltip"] = ""

    self.createButton(params)
end

function click_RerollS(obj, color, alt_click)
    if panicTest == true then return end
    RerollSuccess(color)
end


function CreateButton_RerollM()
    local params = buttonParams
	params["click_function"] = "click_RerollM"
	params["label"]= "Reroll misses"
	params["position"] = {0.05, 0.2, 1.2}
	params["font_size"] = 40
	params["tooltip"] = ""

    self.createButton(params)
end

function click_RerollM(obj, color, alt_click)
     if panicTest == true then return end
    RerollMiss(color)
end
--[[ END Buttons creation ]]--


------- SPAWN D6 ------------

nDice = 0
diceTable = {}

--[[ Get the position of a die from the index (1-16) ]]--
function GetDicePos(index)
    local i = math.floor(index / 4)
    local j =  index % 4
    if j == 0 then
        j = 3
        i=i-1
    else j = j-1 end

    local pos = {}

    pos["x"] = self.getPosition()["x"] - 2.5 + (1.7 * i)
    pos["y"] = 3
    pos["z"] = self.getPosition()["z"] + 2.5 - (1.7 * j)
    return pos
end


--[[ Create and spawn a d6 ]]--
function SpawnDie()
    if nDice == 16 then return false end
    nDice = nDice + 1
     pos = GetDicePos(nDice)

    if diceImage == 0 then

    local spawnParams = {
        type = "Die_6",
         position          = pos,
        rotation          = {x=0, y=0, z=0},
        scale             = {x=1.5, y=1.5, z=1.5},
        sound             = false,
		imageURL = "http://cloud-3.steamusercontent.com/ugc/784121429276807317/0A2555822CDDB1BC3EA84AB1E16BD528FD82A8B7/",
    }

    diceTable[nDice] = spawnObject(spawnParams)

    else -- Load button from JSON with the right image
        dJson = "{\"Name\": \"Custom_Dice\",\"Transform\": {\"posX\": -14.2611418,\"posY\": 1.50483,\"posZ\": 6.14364624,\"rotX\": -3.41509462E-06,\"rotY\": 84.1450653,\"rotZ\": 270.0,\"scaleX\": 1.6499995,\"scaleY\": 1.6499995,\"scaleZ\": 1.6499995},\"Nickname\": \"\",\"Description\": \"\",\"GMNotes\": \"\",\"ColorDiffuse\": {\"r\": 1.0,\"g\": 1.0,\"b\": 1.0},\"Locked\": false,\"Grid\": true,\"Snap\": true,\"IgnoreFoW\": false,\"Autoraise\": true,\"Sticky\": true,\"Tooltip\": true,\"GridProjection\": false,\"HideWhenFaceDown\": false,\"Hands\": false,\"CustomImage\": {\"ImageURL\": \""..diceImages[diceImagesIndex[diceImage]].."\",\"ImageSecondaryURL\": \"\",\"ImageScalar\": 1.0,\"WidthScale\": 0.0,\"CustomDice\": {  \"Type\": 1}},\"XmlUI\": \"\",\"LuaScript\": \"\",\"LuaScriptState\": \"\",\"PhysicsMaterial\": {\"StaticFriction\": 0.6,\"DynamicFriction\": 0.6,\"Bounciness\": 0.0,\"FrictionCombine\": 0,\"BounceCombine\": 0},\"Rigidbody\": {\"Mass\": 1.0,\"Drag\": 0.1,\"AngularDrag\": 0.1,\"UseGravity\": true},\"GUID\": \"4fbe10\",\"RotationValues\": [{  \"Value\": 1,  \"Rotation\": {    \"x\": -90.0,    \"y\": 0.0,    \"z\": 0.0  }},{  \"Value\": 2,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": 0.0  }},{  \"Value\": 3,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": -90.0  }},{  \"Value\": 4,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": 90.0  }},{  \"Value\": 5,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": -180.0  }},{  \"Value\": 6,  \"Rotation\": {    \"x\": 90.0,    \"y\": 0.0,    \"z\": 0.0  }}]}"
        param = {json = dJson, position = pos }
        diceTable[nDice] =  spawnObjectJSON(param)
    end


    s = nDice .. "d6"
    self.editButton({index=buttonsIndex["D6"], label=s})

end


function SpawnPanicTest()
    local pos1 = GetDicePos(1)
    local pos2 = GetDicePos(2)
    local pos3 = GetDicePos(3)
nDice = 3

    local spawnParams1 = {
        type = "Die_6",
         position          = pos1,
        rotation          = {x=0, y=0, z=0},
        scale             = {x=1.5, y=1.5, z=1.5},
        sound             = false,
    }
    local spawnParams2 = {
        type = "Die_6",
         position          = pos2,
        rotation          = {x=0, y=0, z=0},
        scale             = {x=1.5, y=1.5, z=1.5},
        sound             = false,
    }

    diceTable[1] = spawnObject(spawnParams1)
 diceTable[2] = spawnObject(spawnParams2)

  dJson = "{\"Name\": \"Custom_Dice\",\"Transform\": {\"posX\": -14.2611418,\"posY\": 1.50483,\"posZ\": 6.14364624,\"rotX\": -3.41509462E-06,\"rotY\": 84.1450653,\"rotZ\": 270.0,\"scaleX\": 1.6499995,\"scaleY\": 1.6499995,\"scaleZ\": 1.6499995},\"Nickname\": \"\",\"Description\": \"\",\"GMNotes\": \"\",\"ColorDiffuse\": {\"r\": 1.0,\"g\": 1.0,\"b\": 1.0},\"Locked\": false,\"Grid\": true,\"Snap\": true,\"IgnoreFoW\": false,\"Autoraise\": true,\"Sticky\": true,\"Tooltip\": true,\"GridProjection\": false,\"HideWhenFaceDown\": false,\"Hands\": false,\"CustomImage\": {\"ImageURL\": \""..diceImages["d3"].."\",\"ImageSecondaryURL\": \"\",\"ImageScalar\": 1.0,\"WidthScale\": 0.0,\"CustomDice\": {  \"Type\": 1}},\"XmlUI\": \"\",\"LuaScript\": \"\",\"LuaScriptState\": \"\",\"PhysicsMaterial\": {\"StaticFriction\": 0.6,\"DynamicFriction\": 0.6,\"Bounciness\": 0.0,\"FrictionCombine\": 0,\"BounceCombine\": 0},\"Rigidbody\": {\"Mass\": 1.0,\"Drag\": 0.1,\"AngularDrag\": 0.1,\"UseGravity\": true},\"GUID\": \"4fbe10\",\"RotationValues\": [{  \"Value\": 1,  \"Rotation\": {    \"x\": -90.0,    \"y\": 0.0,    \"z\": 0.0  }},{  \"Value\": 2,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": 0.0  }},{  \"Value\": 3,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": -90.0  }},{  \"Value\": 4,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": 90.0  }},{  \"Value\": 5,  \"Rotation\": {    \"x\": 0.0,    \"y\": 0.0,    \"z\": -180.0  }},{  \"Value\": 6,  \"Rotation\": {    \"x\": 90.0,    \"y\": 0.0,    \"z\": 0.0  }}]}"
  param = {json = dJson, position = pos3 }
        diceTable[3] =  spawnObjectJSON(param)




end

rolling = false

function Roll(color)
     for i, v in pairs(diceTable) do
        if v ~= nil and v~= null then
            v.roll()
        end
    end
    if rolling == false then
        if panicTest == true then
			Wait.time(|| ShowPanicTest(color), 2)
		else
			Wait.time(|| ShowResult(color), 3)
		end
    end
    rolling = true
end


function ShowResult(color)
    rolling = false
    nbS = 0

    s = "Player "..color.." rolled "..nDice.." dice :\n"

    for i, v in pairs(diceTable) do
        if v ~= nil and v~= null then
            s = s .. " - ".. v.getValue()
            if v.getValue() >= diff then
                nbS = nbS + 1
            end
        end
    end
    s = s.. " ("..nbS.."/"..nDice..")"
    broadcastToAll(s)
end

function ShowPanicTest(color)
    rolling = false
    s = "Player "..color.." rolled a Panic Test\n"
    d1 = diceTable[1].getValue()
	d2 = diceTable[2].getValue()
	d3 = math.ceil(diceTable[3].getValue() / 2)


    s = s..d1+d2.. " ("..(d3+1).." wounds)"
    broadcastToAll(s)
end

function DeleteDie()
    panicTest = false
    if nDice > 0 then
        diceTable[nDice].destroy()
        nDice = nDice - 1
    end
    s = nDice .. "d6"
    self.editButton({index=buttonsIndex["D6"], label=s})
end

function ClearDice()
    panicTest = false
    for i, v in pairs(diceTable) do
        if v ~= nil and v~= null then
            v.destroy()
        end
    end
    diceTable = {}
    nDice = 0
    self.editButton({index=buttonsIndex["D6"], label="d6"})
    rolling = false
end


function RerollMiss(color)
     for i, v in pairs(diceTable) do
        if v ~= nil and v~= null then
            if v.getValue() < diff then v.roll() end
        end
    end
    if rolling == false then
        Wait.time(|| ShowResult(color), 3)
    end
    rolling = true
end

function RerollSuccess(color)
     for i, v in pairs(diceTable) do
        if v ~= nil and v~= null then
            if v.getValue() >= diff then v.roll() end
        end
    end
    if rolling == false then
        Wait.time(|| ShowResult(color), 3)
    end
    rolling = true
end
