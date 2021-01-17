local VOLUME_LAYER_RESULT = "|Volume| Vertices"

if not app.isUIAvailable then
  -- Return when the UI is not available.
  return nil
end

local sprite = app.activeSprite
if sprite == nil then
  app.alert{
    title="Volume: Warning",
    text={
      "No active sprite!",
      "Open a sprite before using this script.",
    },    
  };
  return nil
end

-- Check whether the vertices layer exists.
-- Create it otherwise.
local layer = nil
for _, l in ipairs(sprite.layers) do
  if l.name == VOLUME_LAYER_RESULT then
    layer = l
  end
end

if layer == nil then
  layer = sprite:newLayer()
  layer.name = VOLUME_LAYER_RESULT
end

local dialog = Dialog{
  title="Volume: Cube",
}

dialog:label{
  label="INFO",
  text="X",
}
dialog:newrow()
dialog:label{
  text="Y",
}

dialog:separator()

dialog:number{
  id="size",
  label="Size",
  text="32",
  decimals=0,
}
dialog:number{
  id="angle",
  label="Angle (º)",
  text="90",
  decimals=0,
}
dialog:button{ id="ok", text="OK" }
dialog:button{ id="cancel", text="Cancel" }

dialog:show()

