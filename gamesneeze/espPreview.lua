        do
            window.VisualPreview = {
                Size = {X = 5, Y = 0},
                Color1 = Color3.fromRGB(0, 255, 0),
                Color2 = Color3.fromRGB(255, 0, 0),
                HealthBarFade = 0,
                Fading = false,
                State = false,
                Visible = true,
                Drawings = {},
                Components = {
                    Box = {
                        Outline = nil,
                        Box = nil,
                        Fill = nil
                    },
                    HealthBar = {
                        Outline = nil,
                        Box = nil,
                        Value = nil
                    },
                    Skeleton = {
                        Head = {},
                        Torso = {},
                        LeftArm = {},
                        RightArm = {},
                        Hips = {},
                        LeftLeg = {},
                        RightLeg = {},
                        HipsTorso = {}
                    },
                    Chams = {
                        Head = {},
                        Torso = {},
                        LeftArm = {},
                        RightArm = {},
                        LeftLeg = {},
                        RightLeg = {}
                    },
                    Title = {
                        Text = nil
                    },
                    Distance = {
                        Text = nil
                    },
                    Tool = {
                        Text = nil
                    },
                    Flags = {
                        Text = nil
                    }
                }
            }
            --
            local esppreview_frame = utility:Create("Frame", {Vector2.new(main_frame.Size.X + 5,0), main_frame}, {
                Size = utility:Size(0, 236, 0, 339),
                Position = utility:Position(1, 5, 0, 0, main_frame),
                Color = theme.outline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_frame] = {
                Color = "outline"
            }
            --
            local esppreview_inline = utility:Create("Frame", {Vector2.new(1,1), esppreview_frame}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_frame),
                Position = utility:Position(0, 1, 0, 1, esppreview_frame),
                Color = theme.accent
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inline] = {
                Color = "accent"
            }
            --
            local esppreview_inner = utility:Create("Frame", {Vector2.new(1,1), esppreview_inline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inline),
                Color = theme.lightcontrast
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner] = {
                Color = "lightcontrast"
            }
            --
            local esppreview_title = utility:Create("TextLabel", {Vector2.new(4,2), esppreview_inner}, {
                Text = "ESP Preview",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(0, 4, 0, 2, esppreview_inner)
            }, window.VisualPreview.Drawings)
            --
            local esppreview_visiblebutton = utility:Create("TextLabel", {Vector2.new(esppreview_inner.Size.X - (5 + 7),2), esppreview_inner}, {
                Text = "O",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Position = utility:Position(1, -(5 + 7), 0, 2, esppreview_inner)
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local esppreview_inner_inline = utility:Create("Frame", {Vector2.new(4,18), esppreview_inner}, {
                Size = utility:Size(1, -8, 1, -22, esppreview_inner),
                Position = utility:Position(0, 4, 0, 18, esppreview_inner),
                Color = theme.inline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_inline] = {
                Color = "inline"
            }
            --
            local esppreview_inner_outline = utility:Create("Frame", {Vector2.new(1,1), esppreview_inner_inline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inner_inline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inner_inline),
                Color = theme.outline
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_outline] = {
                Color = "outline"
            }
            --
            local esppreview_inner_frame = utility:Create("Frame", {Vector2.new(1,1), esppreview_inner_outline}, {
                Size = utility:Size(1, -2, 1, -2, esppreview_inner_outline),
                Position = utility:Position(0, 1, 0, 1, esppreview_inner_outline),
                Color = theme.darkcontrast
            }, window.VisualPreview.Drawings)
            --
            library.colors[esppreview_inner_frame] = {
                Color = "darkcontrast"
            }
            --
            local esppreview_frame_previewbox = utility:Create("Frame", {Vector2.new(10,10), esppreview_inner_frame}, {
                Size = utility:Size(1, -20, 1, -20, esppreview_inner_frame),
                Position = utility:Position(0, 10, 0, 10, esppreview_inner_frame),
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            })
            --
            local BoxSize = utility:Size(1, -7, 1, -55, esppreview_frame_previewbox)
            local healthbaroutline
            local healthbar
            local healthvalue
            local boxoutline
            --
            function window.VisualPreview:UpdateHealthBar()
                window.VisualPreview.HealthBarFade = window.VisualPreview.HealthBarFade + 0.015
                local Smoothened = (math.acos(math.cos(window.VisualPreview.HealthBarFade * math.pi)) / math.pi)
                local Size = (healthbaroutline.Size.Y - 2) * Smoothened
                local Color = ColorLerp(Smoothened, window.VisualPreview.Color1, window.VisualPreview.Color2)
                --
                healthvalue.Text = "<- " .. math.round(Smoothened * 100)
                healthvalue.Color = Color
                healthbar.Color = Color
                healthbar.Size = utility:Size(1, -2, 0, Size, healthbaroutline)
                healthbar.Position = utility:Position(0, 1, 1, -Size - 1, healthbaroutline)
                utility:UpdateOffset(healthbar, {Vector2.new(1, healthbaroutline.Size.Y - Size - 1), healthbaroutline})
            end
            --
            function window.VisualPreview:UpdateHealthValue(Size)
                local New = Vector2.new(healthbar.Position.X + (5 - Size), math.clamp(healthbar.Position.Y + 5, 0, (healthbar.Position.Y) + (healthbar.Size.Y) - 18))
                --
                healthvalue.Position = New
                utility:UpdateOffset(healthvalue, {Vector2.new(5 - Size, New.Y - healthbar.Position.Y), healthbar})
            end
            --
            function window.VisualPreview:ValidateSize(Side, Size)
                if not (window.VisualPreview.Size[Side] == Size) then
                    window.VisualPreview.Size[Side] = Size
                    --
                    esppreview_frame.Size = utility:Size(0, 231 + window.VisualPreview.Size[Side], 0, 339)
                    esppreview_inline.Size = utility:Size(1, -2, 1, -2, esppreview_frame)
                    esppreview_inner.Size = utility:Size(1, -2, 1, -2, esppreview_inline)
                    esppreview_inner_inline.Size = utility:Size(1, -8, 1, -22, esppreview_inner)
                    esppreview_inner_outline.Size = utility:Size(1, -2, 1, -2, esppreview_inner_inline)
                    esppreview_inner_frame.Size = utility:Size(1, -2, 1, -2, esppreview_inner_outline)
                    esppreview_frame_previewbox.Size = utility:Size(1, -20, 1, -20, esppreview_inner_frame)
                    --
                    esppreview_visiblebutton.Position = utility:Position(1, -(5 + 7), 0, 2, esppreview_inner)
                    esppreview_frame_previewbox.Position = utility:Position(0, 10, 0, 10, esppreview_inner_frame)
                    --
                    utility:UpdateOffset(esppreview_visiblebutton, {Vector2.new(esppreview_inner.Size.X - (5 + 7),2), esppreview_inner})
                    utility:UpdateOffset(esppreview_frame_previewbox, {Vector2.new(10,10), esppreview_inner_frame})
                    utility:UpdateOffset(boxoutline, {Vector2.new(esppreview_frame_previewbox.Size.X - BoxSize.X - 1, 20), esppreview_frame_previewbox})
                    --
                    window:Move(main_frame.Position + Vector2.new(0, 0))
                end
            end
            --
            function window.VisualPreview:SetPreviewState(State)
                window.VisualPreview.Fading = true
                window.VisualPreview.State = State
                --
                task.spawn(function()
                    for Index, Value in pairs(window.VisualPreview.Drawings) do
                        utility:Lerp(Index, {Transparency = window.VisualPreview.State and Value or 0}, 0.2)
                        utility:UpdateTransparency(Index, window.VisualPreview.State and Value or 0)
                    end
                end)
                --
                window.VisualPreview.Fading = false
            end
            --
            function window.VisualPreview:SetComponentProperty(Component, Property, State, Index)
                for Index2, Value in pairs(window.VisualPreview.Components[Component]) do
                    if Index then
                        Value[Index][Property] = State
                        --
                        if Property == "Transparency" then
                            utility:UpdateTransparency(Value[Index], State)
                            if window.VisualPreview.Drawings[Value[Index]] then
                                window.VisualPreview.Drawings[Value[Index]] = State
                            end
                        end
                    else
                        Value[Property] = State
                        --
                        if Property == "Transparency" then
                            utility:UpdateTransparency(Value, State)
                            if window.VisualPreview.Drawings[Value] then
                                window.VisualPreview.Drawings[Value] = State
                            end
                        end
                    end 
                end
            end
            --
            function window.VisualPreview:SetComponentSelfProperty(Component, Self, Property, State, Index)
                if Index then
                    window.VisualPreview.Components[Component][Self][Index][Property] = State
                    --
                    if Property == "Transparency" then
                        utility:UpdateTransparency(window.VisualPreview.Components[Component][Self][Index], State)
                        if window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self][Index]] then
                            window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self][Index]] = State
                        end
                    end
                else
                    window.VisualPreview.Components[Component][Self][Property] = State
                    --
                    if Property == "Transparency" then
                        utility:UpdateTransparency(window.VisualPreview.Components[Component][Self], State)
                        if window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self]] then
                            window.VisualPreview.Drawings[window.VisualPreview.Components[Component][Self]] = State
                        end
                    end
                end 
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and esppreview_visiblebutton.Visible and window.isVisible and utility:MouseOverDrawing({esppreview_visiblebutton.Position.X, esppreview_visiblebutton.Position.Y, esppreview_visiblebutton.Position.X + esppreview_visiblebutton.TextBounds.X, esppreview_visiblebutton.Position.Y + esppreview_visiblebutton.TextBounds.Y}) and not window:IsOverContent() then
                    window.VisualPreview.Visible = not window.VisualPreview.Visible
                    esppreview_visiblebutton.Text = window.VisualPreview.Visible and "O" or "0"
                end
            end
            --
            do -- Preview Stuff
                local preview_boxoutline = utility:Create("Frame", {Vector2.new(esppreview_frame_previewbox.Size.X - BoxSize.X - 1, 20), esppreview_frame_previewbox}, {
                    Size = BoxSize,
                    Position = utility:Position(1, -(BoxSize.X - 1), 0, 20, esppreview_frame_previewbox),
                    Color = Color3.fromRGB(0, 0, 0),
                    Filled = false,
                    Thickness = 2.5
                }, window.VisualPreview.Drawings);boxoutline = preview_boxoutline
                --
                local preview_box = utility:Create("Frame", {Vector2.new(0, 0), preview_boxoutline}, {
                    Size = utility:Size(1, 0, 1, 0, preview_boxoutline),
                    Position = utility:Position(0, 0, 0, 0, preview_boxoutline),
                    Color = Color3.fromRGB(255, 255, 255),
                    Filled = false,
                    Thickness = 0.6
                }, window.VisualPreview.Drawings)
                --
                local preview_heatlhbaroutline = utility:Create("Frame", {Vector2.new(-6, -1), preview_boxoutline}, {
                    Size = utility:Size(0, 4, 1, 2, preview_boxoutline),
                    Position = utility:Position(0, -6, 0, -1, preview_boxoutline),
                    Color = Color3.fromRGB(0, 0, 0),
                    Filled = true
                }, window.VisualPreview.Drawings);healthbaroutline = preview_heatlhbaroutline
                --
                local preview_heatlhbar = utility:Create("Frame", {Vector2.new(1, 1), preview_heatlhbaroutline}, {
                    Size = utility:Size(1, -2, 1, -2, preview_heatlhbaroutline),
                    Position = utility:Position(0, 1, 0, 1, preview_heatlhbaroutline),
                    Color = Color3.fromRGB(255, 0, 0),
                    Filled = true
                }, window.VisualPreview.Drawings);healthbar = preview_heatlhbar
                --
                local preview_title = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, -20), preview_box}, {
                    Text = "Username",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 0, -20, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_distance = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, preview_box.Size.Y + 5), preview_box}, {
                    Text = "25m",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 1, 5, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_tool = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X / 2, preview_box.Size.Y + 20), preview_box}, {
                    Text = "Weapon",
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Position = utility:Position(0.5, 0, 1, 20, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_character = utility:Create("Frame", {Vector2.new(46/2, 40/2), preview_box}, {
                    Size = utility:Size(1, -46, 1, -40, preview_box),
                    Position = utility:Position(0, (46/2), 0, (40/2), preview_box),
                    Color = Color3.fromRGB(255, 255, 255),
                    Transparency = 0
                }, window.VisualPreview.Drawings)
                --
                do -- Chams
                    for Index = 1, 2 do
                        local transparency = Index == 1 and 0.75 or 0.5
                        local color = Index == 1 and Color3.fromRGB(93, 62, 152) or Color3.fromRGB(255, 255, 255)
                        --
                        local extrasize = Index == 1 and 4 or 0
                        local extraoffset = Index == 1 and -2 or 0
                        --
                        local preview_character_head = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.35) + (extraoffset), extraoffset), preview_character}, {
                            Size = utility:Size(0.3, extrasize, 0.2, 0, preview_character),
                            Position = utility:Position(0.35, extraoffset, 0, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_torso = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.25) + (extraoffset), (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.5, extrasize, 0.4, extrasize, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_leftarm = utility:Create("Frame", {Vector2.new(extraoffset, (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.25, 0, 0.4, extrasize, preview_character),
                            Position = utility:Position(0, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_rightarm = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.75) + (extraoffset + extrasize), (preview_character.Size.Y * 0.2) + (extraoffset)), preview_character}, {
                            Size = utility:Size(0.25, 0, 0.4, extrasize, preview_character),
                            Position = utility:Position(0.75, extraoffset, 0.2, extraoffset, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_leftleg = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.25) + (extraoffset), (preview_character.Size.Y * 0.6) + (extraoffset + extrasize)), preview_character}, {
                            Size = utility:Size(0.25, extrasize / 2, 0.4, 0, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.6, extraoffset + extrasize, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_character_rightleg = utility:Create("Frame", {Vector2.new((preview_character.Size.X * 0.5) + (extraoffset + (extrasize / 2)), (preview_character.Size.Y * 0.6) + (extraoffset + extrasize)), preview_character}, {
                            Size = utility:Size(0.25, extrasize / 2, 0.4, 0, preview_character),
                            Position = utility:Position(0.25, extraoffset, 0.6, extraoffset + extrasize, preview_character),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        window.VisualPreview.Components.Chams["Head"][Index] = preview_character_head
                        window.VisualPreview.Components.Chams["Torso"][Index] = preview_character_torso
                        window.VisualPreview.Components.Chams["LeftArm"][Index] = preview_character_leftarm
                        window.VisualPreview.Components.Chams["RightArm"][Index] = preview_character_rightarm
                        window.VisualPreview.Components.Chams["LeftLeg"][Index] = preview_character_leftleg
                        window.VisualPreview.Components.Chams["RightLeg"][Index] = preview_character_rightleg
                    end
                end
                --
                do -- Skeleton
                    for Index = 1, 2 do
                        local skeletonsize = Vector2.new(Index == 1 and 3 or 1, Index == 1 and -10 or -12)
                        local skeletonoffset = Vector2.new(Index == 1 and -1 or 0, Index == 1 and 5 or 6)
                        local transparency = 0.5
                        local color = Index == 1 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
                        --
                        local preview_skeleton_head = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Head"][2].Size.X * 0.5) + skeletonoffset.X, (window.VisualPreview.Components.Chams["Head"][2].Size.Y * 0.5) + skeletonoffset.Y), window.VisualPreview.Components.Chams["Head"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 0.5, 0, window.VisualPreview.Components.Chams["Head"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0.5, skeletonoffset.Y, window.VisualPreview.Components.Chams["Head"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_torso = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Torso"][2].Size.X * 0) + skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftArm"][2].Size.X / 2) + (Index == 1 and 3 or 1), skeletonoffset.Y), window.VisualPreview.Components.Chams["Torso"][2]}, {
                            Size = utility:Size(1, skeletonsize.X + window.VisualPreview.Components.Chams["LeftArm"][2].Size.X - (Index == 1 and 6 or 2), 0, skeletonsize.X, window.VisualPreview.Components.Chams["Torso"][2]),
                            Position = utility:Position(0, skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftArm"][2].Size.X / 2) + (Index == 1 and 3 or 1), 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["Torso"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_leftarm = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftArm"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftArm"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["LeftArm"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftArm"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_rightarm = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["RightArm"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["RightArm"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["RightArm"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["RightArm"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_hips = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X * 1) + skeletonoffset.X - (window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X / 2) + (Index == 1 and 3 or 1), skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftLeg"][2]}, {
                            Size = utility:Size(1, skeletonsize.X - (Index == 1 and 6 or 2), 0, skeletonsize.X, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X + (Index == 1 and 3 or 1), 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_leftleg = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["LeftLeg"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["LeftLeg"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["LeftLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_rightleg = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["RightLeg"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y), window.VisualPreview.Components.Chams["RightLeg"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, skeletonsize.Y, window.VisualPreview.Components.Chams["RightLeg"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y, window.VisualPreview.Components.Chams["RightLeg"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        local preview_skeleton_hipstorso = utility:Create("Frame", {Vector2.new((window.VisualPreview.Components.Chams["Torso"][2].Size.X * 0.5) + skeletonoffset.X, skeletonoffset.Y + (Index == 1 and 3 or 1)), window.VisualPreview.Components.Chams["Torso"][2]}, {
                            Size = utility:Size(0, skeletonsize.X, 1, Index == 1 and -3 or -1, window.VisualPreview.Components.Chams["Torso"][2]),
                            Position = utility:Position(0.5, skeletonoffset.X, 0, skeletonoffset.Y + (Index == 1 and 3 or 1), window.VisualPreview.Components.Chams["Torso"][2]),
                            Color = color,
                            Transparency = transparency
                        }, window.VisualPreview.Drawings)
                        --
                        window.VisualPreview.Components.Skeleton["Head"][Index] = preview_skeleton_head
                        window.VisualPreview.Components.Skeleton["Torso"][Index] = preview_skeleton_torso
                        window.VisualPreview.Components.Skeleton["LeftArm"][Index] = preview_skeleton_leftarm
                        window.VisualPreview.Components.Skeleton["RightArm"][Index] = preview_skeleton_rightarm
                        window.VisualPreview.Components.Skeleton["Hips"][Index] = preview_skeleton_hips
                        window.VisualPreview.Components.Skeleton["LeftLeg"][Index] = preview_skeleton_leftleg
                        window.VisualPreview.Components.Skeleton["RightLeg"][Index] = preview_skeleton_rightleg
                        window.VisualPreview.Components.Skeleton["HipsTorso"][Index] = preview_skeleton_hipstorso
                    end
                end
                --
                local preview_boxfill = utility:Create("Frame", {Vector2.new(1, 1), preview_boxoutline}, {
                    Size = utility:Size(1, -2, 1, -2, preview_boxoutline),
                    Position = utility:Position(0, 1, 0, 1, preview_boxoutline),
                    Color = Color3.fromRGB(255, 255, 255),
                    Filled = true,
                    Transparency = 0.9
                }, window.VisualPreview.Drawings)
                --
                local preview_flags = utility:Create("TextLabel", {Vector2.new(preview_box.Size.X -56, 5), preview_box}, {
                    Text = "Flags ->", --Display\nMoving\nJumping\nDesynced"
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = Color3.fromRGB(255, 255, 255),
                    OutlineColor = theme.textborder,
                    Center = false,
                    Position = utility:Position(1, -56, 0, 5, preview_box)
                }, window.VisualPreview.Drawings)
                --
                local preview_healthbarvalue = utility:Create("TextLabel", {Vector2.new(0, 5), preview_heatlhbar}, {
                    Text = "<- Number", --Display\nMoving\nJumping\nDesynced"
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = Color3.fromRGB(0, 255, 0),
                    OutlineColor = theme.textborder,
                    Center = false,
                    Position = utility:Position(0, 0, 0, 5, preview_heatlhbar)
                }, window.VisualPreview.Drawings);healthvalue = preview_healthbarvalue
                --
                window.VisualPreview.Components.Title["Text"] = preview_title
                window.VisualPreview.Components.Distance["Text"] = preview_distance
                window.VisualPreview.Components.Tool["Text"] = preview_tool
                window.VisualPreview.Components.Flags["Text"] = preview_flags
                window.VisualPreview.Components.Box["Outline"] = preview_boxoutline
                window.VisualPreview.Components.Box["Box"] = preview_box
                window.VisualPreview.Components.Box["Fill"] = preview_boxfill
                window.VisualPreview.Components.HealthBar["Outline"] = preview_heatlhbaroutline
                window.VisualPreview.Components.HealthBar["Box"] = preview_heatlhbar
                window.VisualPreview.Components.HealthBar["Value"] = preview_healthbarvalue
            end
            --
            do -- New Drawings
                local NewDrawings = {}
                --
                for Index, Value in pairs(library.drawings) do
                    if Value[1] and table.find(window.VisualPreview.Drawings, Value[1]) then
                        NewDrawings[Value[1]] = Value[3]
                    end
                end
                --
                window.VisualPreview.Drawings = NewDrawings
            end
        end
