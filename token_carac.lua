function generateButtonParamiters()
    tokenValue = {
        index = 0, click_function = 'changeValue', function_owner = self, label = '+1', color = {0.2, 0.2, 0.2}, font_color = {1, 1, 1},
        position = {0,0.1,0.4}, width = 1000, height = 600, font_size = 700, tooltip = 'left: increase // right: decrease'
    }
end

function onLoad()
    generateButtonParamiters()

    count = 1

    tokenValue.label = '+' .. tostring(count)

    self.setColorTint({1, 1, 1})
    self.createButton(tokenValue)
end


function changeValue(obj, color, alt_click)
    if alt_click==false then
        	count = count + 1
    	    if count == 0 then
    		        count = 1
            self.setColorTint({1, 1, 1})
            self.editButton({tokenValue, font_color={1, 1, 1}})
            self.editButton({tokenValue, color = {0.2, 0.2, 0.2}})
        end
    else
        	count = count - 1
    	    if count == 0 then
            count = -1
            self.setColorTint({0.6, 0, 0})
            self.editButton({tokenValue, font_color={0.6, 0, 0}})
            self.editButton({tokenValue, color = {0, 0, 0}})
        end
    end


    s = ''
    if count > 0 then
        	s = s .. '+' .. tostring(count)
	    else
		        s = s .. '−' .. tostring(count*-1)
    end
    self.editButton({tokenValue, label=s})

end
