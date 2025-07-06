local module = {};
local parent = cloneref(UserSettings().GetService(game, 'CoreGui')).RobloxGui;

module.new = function(type)
	if (type == 'Line') then
		local drawer = Instance.new('WireframeHandleAdornment', parent);
		drawer.Adornee = workspace.Terrain;
		
		local update = function(tbl)
			drawer.Color3 = tbl.Color;
			drawer.Transparency = tbl.Transparency;
			drawer.AlwaysOnTop = tbl.AlwaysOnTop;
			drawer.ZIndex = tbl.ZIndex;
			drawer.Visible = tbl.Visible;
			drawer.AdornCullingMode = tbl.AdornCullingMode;
			drawer:Clear();
			drawer:AddLine(tbl.From, tbl.To);
			drawer:AddLines(tbl.Multi)
		end;
		
		local Line = setmetatable({__typeof = 'Line',
			__properties = {
				Color = Color3.new(0, 0, 0),
				From = Vector3.zero,
				To = Vector3.zero,
				Transparency = 0,
				ZIndex = 0,
				Visible = false,
				AdornCullingMode = Enum.AdornCullingMode.Automatic,
				AlwaysOnTop = false,
				Multi = {}
			}
		    },{__newindex = function(self, idx, val)
				if (idx == 'Color') then
					rawset(rawget(self, '__properties'), 'Color', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Visible') then
					rawset(rawget(self, '__properties'), 'Visible', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'From')  then
					rawset(rawget(self, '__properties'), 'From', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'To')  then
					rawset(rawget(self, '__properties'), 'To', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Transparency')  then
					rawset(rawget(self, '__properties'), 'Transparency', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'AdornCullingMode')  then
					rawset(rawget(self, '__properties'), 'AdornCullingMode', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'AlwaysOnTop')  then
					rawset(rawget(self, '__properties'), 'AlwaysOnTop', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'ZIndex')  then
					rawset(rawget(self, '__properties'), 'ZIndex', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Multi') then
					rawset(rawget(self, '__properties'), 'Multi', val);
					update(rawget(self, '__properties'));
				end;
			end,
			__index = function(self, idx)
				return rawget(rawget(self, '__properties'), idx) 
			end,
			__tostring = 'Line',
			__metatable = 'The metatable is locked'
		});
		return Line
		
	elseif (type == 'Text') then
		local drawer = Instance.new('WireframeHandleAdornment', parent);
		drawer.Adornee = workspace.Terrain;
		
		local update = function(tbl)
			drawer.Color3 = tbl.Color;
			drawer.Transparency = tbl.Transparency;
			drawer.AlwaysOnTop = tbl.AlwaysOnTop;
			drawer.ZIndex = tbl.ZIndex;
			drawer.Visible = tbl.Visible;
			drawer.AdornCullingMode = tbl.AdornCullingMode;
			drawer:Clear();
			drawer:AddText(tbl.Position, tbl.Text, tbl.TextSize)
		end;
		
		local Text = setmetatable(
				{__typeof = 'Text',
				__properties = {
					Color = Color3.new(0, 0, 0),
					Position = Vector3.zero,
					TextSize = 14,
					Text = '',
					Transparency = 0,
					ZIndex = 0,
					Visible = false,
					AdornCullingMode = Enum.AdornCullingMode.Automatic,
					AlwaysOnTop = false
				}
			},{__newindex = function(self, idx, val)
				if (idx == 'Color') then
					rawset(rawget(self, '__properties'), 'Color', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Visible') then
					rawset(rawget(self, '__properties'), 'Visible', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'TextSize') then
					rawset(rawget(self, '__properties'), 'TextSize', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Text') then
					rawset(rawget(self, '__properties'), 'Text', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Position') then
					rawset(rawget(self, '__properties'), 'Position', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'AdornCullingMode')  then
					rawset(rawget(self, '__properties'), 'AdornCullingMode', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'Transparency')  then
					rawset(rawget(self, '__properties'), 'Transparency', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'AlwaysOnTop')  then
					rawset(rawget(self, '__properties'), 'AlwaysOnTop', val);
					update(rawget(self, '__properties'));
				elseif (idx == 'ZIndex')  then
					rawset(rawget(self, '__properties'), 'ZIndex', val);
					update(rawget(self, '__properties'));
				end;
			end,
			__index = function(self, idx)
				return rawget(rawget(self, '__properties'), idx) 
			end,
			__tostring = 'Text',
			__metatable = 'The metatable is locked'
		});
		
		return Text
	elseif (type == 'Circle') then
		local drawer = Instance.new('WireframeHandleAdornment', parent);
		drawer.Adornee = workspace.Terrain;
		
	end;
end;

setreadonly(debug, false);
debug.new = module.new;
setreadonly(debug, true);
return module
