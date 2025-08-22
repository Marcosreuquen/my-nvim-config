return {
    window = {
    layout = 'vertical',
    width = 0.4,
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
    title = '🤖Github Copilot',
    zindex = 100, -- Ensure window stays on top
    footer ='<C-s> Send | <C-c> Close | <C-c> Open',
    padding = { top =1, bottom = 1, left = 2, right = 2 },
  },

  headers = {
    user = '👤 You: ',
    assistant = '🤖 Copilot: ',
    tool = '🔧 Tool: ',
  },
  separator = '━━',
  show_folds = false, -- Disable folding for cleaner look

  auto_scroll = true,
  show_typing_indicator = true
}
