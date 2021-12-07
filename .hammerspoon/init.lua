-- set up your instance(s)
hs.hints.style="vimperator"
--expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
expose = hs.expose.new(nil,{showThumbnails=true}) -- default windowfilter, w/ thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Safari','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
--hs.hotkey.bind('ctrl-cmd','e','Expose',function()expose:toggleShow()end)
--hs.hotkey.bind('ctrl-cmd-shift','e','App Expose',function()expose_app:toggleShow()end)
--hs.hotkey.bind('ctrl-alt','up','Expose',function()expose:toggleShow()end)
hs.hotkey.bind('ctrl','up','Expose',function()expose:toggleShow()end)
hs.hotkey.bind('ctrl-shift','up','App Expose',function()expose_app:toggleShow()end)

