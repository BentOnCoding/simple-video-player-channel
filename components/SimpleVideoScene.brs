'1st function that runs for the scene component on channel startup
sub init()
  'To see print statements/debug info, telnet on port 8089
  m.Image       = m.top.findNode("Image")
  m.ButtonGroup = m.top.findNode("ButtonGroup")
  m.Details     = m.top.findNode("Details")
  m.Title       = m.top.findNode("Title")
  m.Video       = m.top.findNode("Video")
  m.Warning     = m.top.findNode("WarningDialog")
  m.Exiter      = m.top.findNode("Exiter")
  setContent()
  m.ButtonGroup.setFocus(true)
  m.ButtonGroup.observeField("buttonSelected","onButtonSelected")
end sub

sub onButtonSelected()
  'Ok'
  if m.ButtonGroup.buttonSelected = 0
    m.Video.visible = "true"
    m.Video.control = "play"
    m.Video.setFocus(true)
  'Exit button pressed'
  else
    m.Exiter.control = "RUN"
  end if
end sub

'Set your information here
sub setContent()
  print "this is a test find me"
  derp()

  m.Image.uri="pkg:/images/Harry_James_Potter34.jpg"

  videoContent = CreateObject("roSGNode", "ContentNode")
  
  ' videoContent.url = "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8"
  ' videoContent.url = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
  ' videoContent.url = "http://10.146.16.24/Comedy_SD.m3u8"
  ' videoContent.url = "http://10.146.16.20/USA_HD.mpd"
  videoContent.url = "http://dash.edgesuite.net/dash264/TestCases/1a/netflix/exMPD_BIP_TC1.mpd"

  videoContent.streamFormat = "dash"
  videoContent.Title = "Test Stream"

  m.Video.content = videoContent

  'Change the buttons
  Buttons = ["Play","Exit"]
  m.ButtonGroup.buttons = Buttons

  m.Title.text = "Testing Roku Streaming"
  
  m.Details.text =  "Video streaming"

end sub

' Called when a key on the remote is pressed
function onKeyEvent(key as String, press as Boolean) as Boolean
  print "in SimpleVideoScene.xml onKeyEvent ";key;" "; press
  if press then
    if key = "back"
      print "------ [back pressed] ------"
      if m.Warning.visible
        m.Warning.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      else if m.Video.visible
        m.Video.control = "stop"
        m.Video.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      else
        return false
      end if
    else if key = "OK"
      print "------- [ok pressed] -------"
      if m.Warning.visible
        m.Warning.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      end if
    else
      return false
    end if
  end if
  return false
end function
