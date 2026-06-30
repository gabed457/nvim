-- 🎓 Interactive tutorial for THIS Neovim config.
--   :Tutorial   or   <leader>?
--
-- A fun, colorful, self-contained tour. No external dependencies — just floating
-- windows, extmark highlights, and the actual keybinds from this config.

local M = {}

local ns = vim.api.nvim_create_namespace('tutorial')

-- Persisted-for-session progress: which lessons you've opened.
local visited = {}

local state = {
  buf = nil,
  win = nil,
  view = 'menu', -- 'menu' | 'lesson'
  sel = 1, -- selected lesson in the menu
  idx = 1, -- current lesson when in lesson view
}

--------------------------------------------------------------------------------
-- Colors (tokyonight-night palette so it matches the theme, but always bright)
--------------------------------------------------------------------------------

local function set_hl()
  local hl = vim.api.nvim_set_hl
  hl(0, 'TutBanner', { fg = '#bb9af7', bold = true })
  hl(0, 'TutBannerB', { fg = '#7aa2f7', bold = true })
  hl(0, 'TutTitle', { fg = '#7dcfff', bold = true })
  hl(0, 'TutKey', { fg = '#1a1b26', bg = '#7dcfff', bold = true })
  hl(0, 'TutKey2', { fg = '#1a1b26', bg = '#9ece6a', bold = true })
  hl(0, 'TutDesc', { fg = '#c0caf5' })
  hl(0, 'TutDim', { fg = '#565f89' })
  hl(0, 'TutSection', { fg = '#e0af68', bold = true })
  hl(0, 'TutTip', { fg = '#9ece6a' })
  hl(0, 'TutWarn', { fg = '#f7768e' })
  hl(0, 'TutSel', { fg = '#1a1b26', bg = '#7aa2f7', bold = true })
  hl(0, 'TutCheck', { fg = '#9ece6a', bold = true })
  hl(0, 'TutNum', { fg = '#f7768e', bold = true })
  hl(0, 'TutFoot', { fg = '#565f89', italic = true })
end

--------------------------------------------------------------------------------
-- Lessons — sourced directly from this config's keymaps
--------------------------------------------------------------------------------

-- row helpers
local function key(k, d, hl)
  return { t = 'key', key = k, desc = d, hl = hl }
end
local function sec(s)
  return { t = 'sec', text = s }
end
local function txt(s, hl)
  return { t = 'txt', text = s, hl = hl }
end
local function tip(s)
  return { t = 'tip', text = '󰌶 ' .. s }
end
local function warn(s)
  return { t = 'warn', text = ' ' .. s }
end
local blank = { t = 'blank' }

local lessons = {
  {
    icon = '🚀',
    title = 'Welcome & The Basics',
    rows = {
      txt('Hi! This is a guided tour of YOUR Neovim config.'),
      txt('Everything here is real — these keys work right now.'),
      blank,
      sec('The one key to remember'),
      key('<Space>', 'The leader key — the start of almost every command'),
      blank,
      sec('Getting un-stuck'),
      key('<Esc>', 'Clear search highlight / cancel'),
      key('<leader>q', 'Open diagnostics in a quickfix list'),
      key(':Tutorial', 'Reopen this tutorial any time'),
      key('<leader>?', 'Same — open this tutorial'),
      blank,
      tip('Hold <Space> for ~0.3s anywhere and which-key pops up a menu'),
      tip('of what comes next. You never have to memorize — just peek.'),
    },
  },
  {
    icon = '🔭',
    title = 'Search & Find (Telescope)',
    rows = {
      txt('Fuzzy-find anything. All search keys live under <leader>s.'),
      blank,
      sec('Files & text'),
      key('<leader>sf', 'Search files in the project'),
      key('<leader>sg', 'Live grep — search file contents'),
      key('<leader>sw', 'Grep the word under your cursor'),
      key('<leader>/', 'Fuzzy search inside the current buffer'),
      blank,
      sec('Buffers & symbols'),
      key('<leader><leader>', 'Quick buffer picker (open files)'),
      key('<leader>sb', 'Search open buffers'),
      key('<leader>ss', 'Document symbols (functions, classes…)'),
      key('<leader>sS', 'Workspace-wide symbols'),
      blank,
      sec('Meta'),
      key('<leader>sd', 'Search diagnostics'),
      key('<leader>sk', 'Search all keymaps (great for discovery!)'),
      key('<leader>sh', 'Search help docs'),
      key('<leader>sr', 'Resume your last search'),
      blank,
      tip('In any Telescope window: <C-n>/<C-p> move, <CR> opens,'),
      tip('<C-v> opens in a vertical split. Forgot what <leader>s does?'),
      tip('Just press <leader>sk and search for it.'),
    },
  },
  {
    icon = '🗂️',
    title = 'Files & Buffers',
    rows = {
      txt('Two ways to move through files: a file explorer, and pins.'),
      blank,
      sec('Oil — edit your filesystem like a buffer'),
      key('<leader>e', 'Toggle the Oil file explorer'),
      key('-', 'Go up to the parent directory'),
      key('<CR>', 'Open the file/dir under the cursor'),
      key('g.', 'Toggle hidden (dotfiles) on/off'),
      key('g?', 'Show all Oil keybinds'),
      blank,
      sec('Harpoon — pin your 4 most-used files'),
      key('<leader>a', 'Add the current file to Harpoon'),
      key('<leader>h', 'Open the Harpoon menu'),
      key('<leader>1', 'Jump straight to pinned file 1'),
      key('<leader>2', 'Jump to pinned file 2'),
      key('<leader>3', 'Jump to pinned file 3'),
      key('<leader>4', 'Jump to pinned file 4'),
      blank,
      tip('Oil is magic: rename a file by editing its name, delete a'),
      tip('line to delete the file, then :w to apply. It is just text.'),
      tip('Harpoon is for the 3-4 files you bounce between all day.'),
    },
  },
  {
    icon = '🧭',
    title = 'Moving Around',
    rows = {
      txt('Windows, scrolling, and jumping by code structure.'),
      blank,
      sec('Window focus'),
      key('<C-h>', 'Focus the window to the left'),
      key('<C-l>', 'Focus the window to the right'),
      key('<C-j>', 'Focus the window below'),
      key('<C-k>', 'Focus the window above'),
      blank,
      sec('Stay centered'),
      key('<C-d>', 'Half-page down (cursor stays centered)'),
      key('<C-u>', 'Half-page up (cursor stays centered)'),
      key('n / N', 'Next/prev search match (centered)'),
      blank,
      sec('Jump by code (treesitter)'),
      key(']f / [f', 'Next / previous function'),
      key(']a / [a', 'Next / previous parameter'),
      blank,
      tip('<C-d>/<C-u> keep your eyes in the middle of the screen so'),
      tip('you never lose your place while scrolling.'),
    },
  },
  {
    icon = '🧠',
    title = 'Code Intelligence (LSP)',
    rows = {
      txt('Navigate and refactor code. These work in any LSP buffer.'),
      blank,
      sec('Go places'),
      key('gd', 'Go to definition'),
      key('gr', 'Find references'),
      key('gi', 'Go to implementation'),
      key('gD', 'Go to declaration'),
      key('<leader>D', 'Go to type definition'),
      blank,
      sec('Understand & change'),
      key('K', 'Hover docs for the symbol under cursor'),
      key('<leader>ca', 'Code action (quick fixes, imports…)'),
      key('<leader>rn', 'Rename a symbol everywhere'),
      key('<leader>th', 'Toggle inlay hints (inline types)'),
      blank,
      sec('Diagnostics (Trouble)'),
      key('<leader>xx', 'Toggle the diagnostics list'),
      key('<leader>xd', 'Diagnostics for this buffer only'),
      blank,
      tip('TypeScript errors are auto-translated into plain English'),
      tip('by ts-error-translator — no more decoding cryptic TS speak.'),
    },
  },
  {
    icon = '🌿',
    title = 'Git',
    rows = {
      txt('Stage, review, and dig through history without leaving Neovim.'),
      blank,
      sec('The big one'),
      key('<leader>gg', 'Open Lazygit in a floating window', 'TutKey2'),
      blank,
      sec('Hunks (gitsigns)'),
      key(']c / [c', 'Jump to next / previous changed hunk'),
      key('<leader>gp', 'Preview the hunk under the cursor'),
      key('<leader>gs', 'Stage hunk (works on a visual selection too)'),
      key('<leader>gr', 'Reset hunk'),
      key('<leader>gb', 'Blame the current line'),
      blank,
      sec('Side-by-side diffs (Diffview)'),
      key('<leader>gv', 'Diff your unstaged changes'),
      key('<leader>gc', 'Diff staged changes'),
      key('<leader>gf', 'File history for the current file'),
      key('<leader>gq', 'Close the diff view'),
      blank,
      tip('Inline blame is always on — the author of the current line'),
      tip('shows faintly at the end of it. <leader>gg (lazygit) is the'),
      tip('fastest way to do a full commit/push flow.'),
    },
  },
  {
    icon = '✏️',
    title = 'Editing Superpowers',
    rows = {
      txt('Small motions that save thousands of keystrokes.'),
      blank,
      sec('Surround (nvim-surround)'),
      key('ys{motion}{c}', 'Add surround, e.g. ysiw" wraps a word in "'),
      key('cs{old}{new}', "Change surround, e.g. cs\"' swaps \" for '"),
      key('ds{c}', 'Delete surround, e.g. ds( removes parens'),
      blank,
      sec('Comments'),
      key('gcc', 'Toggle comment on the current line'),
      key('gc', 'Toggle comment on a visual selection'),
      blank,
      sec('Move & tidy'),
      key('J', 'Move selected lines DOWN (visual mode)'),
      key('K', 'Move selected lines UP (visual mode)'),
      key('<leader>xp', 'Swap parameter with the next one'),
      key('<leader>xP', 'Swap parameter with the previous one'),
      key('<leader>u', 'Toggle the undo tree (visual undo history)'),
      blank,
      tip('Brackets and quotes auto-close as you type (autopairs).'),
      tip('Made a mess of undos? <leader>u shows every branch you can'),
      tip('travel back to — nothing is ever truly lost.'),
    },
  },
  {
    icon = '🎯',
    title = 'Text Objects',
    rows = {
      txt('Operate on code by meaning. Combine with d, c, y, v.'),
      txt('Example: "cif" = Change Inner Function. "vac" = select a class.'),
      blank,
      sec('Select around / inside'),
      key('af / if', 'A whole function / its body'),
      key('ac / ic', 'A whole class / its body'),
      key('aa / ia', 'A parameter / its inner part'),
      key('ai / ii', 'A conditional / its body'),
      key('al / il', 'A loop / its body'),
      blank,
      sec('Grow a selection'),
      key('<C-space>', 'Start, then keep pressing to grow the selection'),
      key('<BS>', 'Shrink the selection back down'),
      blank,
      tip('Pair an operator + a text object: dif (delete inside func),'),
      tip('yaf (yank a func), vic (select inside class). Once this clicks,'),
      tip('you edit by intent instead of by counting lines.'),
    },
  },
  {
    icon = '💧',
    title = 'Snippets',
    rows = {
      txt('Type a trigger word, then expand it into boilerplate.'),
      txt('Press <C-l> to jump to the next blank, <C-h> to jump back.'),
      blank,
      sec('TypeScript'),
      key('asynchandler', 'Async Fastify handler with try/catch', 'TutKey2'),
      key('trycatch', 'A try/catch block', 'TutKey2'),
      key('froute', 'Fastify route plugin', 'TutKey2'),
      key('fplugin', 'Fastify plugin (fastify-plugin)', 'TutKey2'),
      key('nestmethod', 'NestJS controller method', 'TutKey2'),
      key('desc / it', 'describe / it test scaffold', 'TutKey2'),
      blank,
      sec('SQL'),
      key('sel', 'SELECT … FROM … WHERE', 'TutKey2'),
      key('join', 'SELECT with an INNER JOIN', 'TutKey2'),
      key('cte', 'WITH … AS ( … ) common table expression', 'TutKey2'),
      key('top', 'SELECT TOP N (MSSQL)', 'TutKey2'),
      blank,
      tip('In a .ts file, type "froute" then <C-l> through each field.'),
      tip('Completion also pops up automatically — <CR> accepts it.'),
    },
  },
  {
    icon = '🎨',
    title = 'Format, Lint & Secrets',
    rows = {
      txt('Clean code on save, lint as you go, hide your secrets.'),
      blank,
      sec('Formatting (conform)'),
      key('<leader>f', 'Format the buffer now'),
      txt('  …also runs automatically every time you save.', 'TutDim'),
      txt('  prettier for TS/JSON/YAML · stylua for Lua · sql-formatter', 'TutDim'),
      blank,
      sec('Linting (nvim-lint)'),
      txt('  eslint_d runs automatically on save & insert-leave.', 'TutDim'),
      txt('  See problems via <leader>xx (Trouble) or <leader>sd.', 'TutDim'),
      blank,
      sec('Secrets (cloak)'),
      key('<leader>ct', 'Toggle hiding of values in .env files'),
      blank,
      tip('Open a .env file and the values show as ****. Toggle them'),
      tip('back with <leader>ct when you actually need to read them.'),
    },
  },
  {
    icon = '🛠️',
    title = 'Maintenance & Health',
    rows = {
      txt('Keep the config and its tools healthy. These are commands —'),
      txt('type them with ":" in normal mode.'),
      blank,
      sec('When something feels off'),
      key(':checkhealth', 'Full diagnostic of Neovim & plugins'),
      key(':Lazy', 'Plugin manager — press U to update all'),
      key(':Mason', 'Manage LSP servers & formatters'),
      key(':LspInfo', 'See which language servers are attached'),
      key(':ConformInfo', 'See which formatters apply here'),
      blank,
      sec('Update this config'),
      key('<leader>nu', 'Pull the latest config from your remote'),
      blank,
      tip('First stop for ANY weirdness is :checkhealth — it tells you'),
      tip('exactly what is missing or misconfigured.'),
    },
  },
  {
    icon = '🏁',
    title = 'Graduation — Top 10 to Memorize',
    rows = {
      txt('You made it! If you remember nothing else, remember these.'),
      blank,
      key('<leader>sf', 'Find a file', 'TutKey2'),
      key('<leader>sg', 'Search across the project', 'TutKey2'),
      key('<leader><leader>', 'Switch buffers', 'TutKey2'),
      key('<leader>e', 'File explorer (Oil)', 'TutKey2'),
      key('gd', 'Go to definition', 'TutKey2'),
      key('K', 'Hover docs', 'TutKey2'),
      key('<leader>ca', 'Code action / quick fix', 'TutKey2'),
      key('<leader>rn', 'Rename symbol', 'TutKey2'),
      key('<leader>gg', 'Lazygit', 'TutKey2'),
      key('<leader>sk', 'Search ALL keymaps when you forget one', 'TutKey2'),
      blank,
      tip('Lost? <leader>sk searches every keybind. Hold <Space> for the'),
      tip('which-key menu. And :Tutorial brings you right back here. 🎉'),
    },
  },
}

--------------------------------------------------------------------------------
-- Rendering
--------------------------------------------------------------------------------

local WIDTH = 74

local function add_hl(hls, line, col_start, col_end, group)
  hls[#hls + 1] = { line, col_start, col_end, group }
end

-- Convert a lesson's rows into display lines + highlight specs.
local function render_rows(rows)
  local lines, hls = {}, {}
  for _, r in ipairs(rows) do
    if r.t == 'blank' then
      lines[#lines + 1] = ''
    elseif r.t == 'sec' then
      lines[#lines + 1] = '  ' .. r.text
      add_hl(hls, #lines - 1, 0, -1, 'TutSection')
    elseif r.t == 'txt' then
      lines[#lines + 1] = '  ' .. r.text
      add_hl(hls, #lines - 1, 0, -1, r.hl or 'TutDesc')
    elseif r.t == 'tip' then
      lines[#lines + 1] = '   ' .. r.text
      add_hl(hls, #lines - 1, 0, -1, 'TutTip')
    elseif r.t == 'warn' then
      lines[#lines + 1] = '   ' .. r.text
      add_hl(hls, #lines - 1, 0, -1, 'TutWarn')
    elseif r.t == 'key' then
      local cap = ' ' .. r.key .. ' '
      local capw = vim.fn.strdisplaywidth(cap)
      local pad = string.rep(' ', math.max(1, 20 - capw))
      lines[#lines + 1] = '   ' .. cap .. pad .. r.desc
      local s = 3
      local e = s + #cap
      add_hl(hls, #lines - 1, s, e, r.hl or 'TutKey')
      add_hl(hls, #lines - 1, e, -1, 'TutDesc')
    end
  end
  return lines, hls
end

local function center(text)
  local w = vim.fn.strdisplaywidth(text)
  local left = math.max(0, math.floor((WIDTH - w) / 2))
  return string.rep(' ', left) .. text
end

local function banner_lines()
  return {
    center('╭───────────────────────────────────────╮'),
    center('│   N E O V I M   ·   T U T O R I A L   │'),
    center('╰───────────────────────────────────────╯'),
  }
end

local function build_menu()
  local lines, hls = {}, {}
  for _, b in ipairs(banner_lines()) do
    lines[#lines + 1] = b
    add_hl(hls, #lines - 1, 0, -1, 'TutBanner')
  end
  lines[#lines + 1] = ''
  lines[#lines + 1] = '  Pick a lesson — j/k to move, <CR> to open, q to quit'
  add_hl(hls, #lines - 1, 0, -1, 'TutFoot')
  lines[#lines + 1] = ''

  local first_lesson_line = #lines
  for i, lesson in ipairs(lessons) do
    local check = visited[i] and ' ✓' or '  '
    local num = string.format('%2d', i)
    local line = string.format('   %s.  %s  %s%s', num, lesson.icon, lesson.title, check)
    lines[#lines + 1] = line
    if i == state.sel then
      add_hl(hls, #lines - 1, 0, -1, 'TutSel')
    else
      add_hl(hls, #lines - 1, 3, 6, 'TutNum')
      -- Completed lessons glow green; unvisited ones stay cyan.
      add_hl(hls, #lines - 1, 6, -1, visited[i] and 'TutCheck' or 'TutTitle')
    end
  end

  lines[#lines + 1] = ''
  lines[#lines + 1] = '  ' .. string.rep('─', WIDTH - 4)
  add_hl(hls, #lines - 1, 0, -1, 'TutDim')
  lines[#lines + 1] = '  1-9 jump · <CR>/l open · q close'
  add_hl(hls, #lines - 1, 0, -1, 'TutFoot')

  return lines, hls, first_lesson_line
end

local function build_lesson(idx)
  local lesson = lessons[idx]
  local lines, hls = {}, {}

  local header = string.format('%s  %s', lesson.icon, lesson.title)
  lines[#lines + 1] = center(header)
  add_hl(hls, #lines - 1, 0, -1, 'TutBannerB')
  lines[#lines + 1] = '  ' .. string.format('Lesson %d of %d', idx, #lessons)
  add_hl(hls, #lines - 1, 0, -1, 'TutFoot')
  lines[#lines + 1] = '  ' .. string.rep('─', WIDTH - 4)
  add_hl(hls, #lines - 1, 0, -1, 'TutDim')
  lines[#lines + 1] = ''

  local body, bhls = render_rows(lesson.rows)
  local offset = #lines
  for _, l in ipairs(body) do
    lines[#lines + 1] = l
  end
  for _, h in ipairs(bhls) do
    add_hl(hls, h[1] + offset, h[2], h[3], h[4])
  end

  lines[#lines + 1] = ''
  lines[#lines + 1] = '  ' .. string.rep('─', WIDTH - 4)
  add_hl(hls, #lines - 1, 0, -1, 'TutDim')
  lines[#lines + 1] = '  n next · p prev · h back to menu · q close'
  add_hl(hls, #lines - 1, 0, -1, 'TutFoot')

  return lines, hls
end

--------------------------------------------------------------------------------
-- Window + paint
--------------------------------------------------------------------------------

local function paint(lines, hls, cursor_line)
  local buf = state.buf
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for _, h in ipairs(hls) do
    pcall(vim.api.nvim_buf_set_extmark, buf, ns, h[1], h[2], {
      end_col = h[3] == -1 and nil or h[3],
      end_row = h[3] == -1 and h[1] + 1 or nil,
      hl_group = h[4],
      hl_eol = h[3] == -1,
    })
  end
  if cursor_line and state.win and vim.api.nvim_win_is_valid(state.win) then
    pcall(vim.api.nvim_win_set_cursor, state.win, { cursor_line, 0 })
  end
end

local function render()
  if state.view == 'menu' then
    local lines, hls, first = build_menu()
    paint(lines, hls, first + state.sel - 1)
  else
    local lines, hls = build_lesson(state.idx)
    paint(lines, hls, 1)
  end
end

local function close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
  state.buf = nil
end

local function open_lesson(i)
  state.idx = math.max(1, math.min(#lessons, i))
  state.sel = state.idx
  visited[state.idx] = true
  state.view = 'lesson'
  render()
end

local function back_to_menu()
  state.view = 'menu'
  render()
end

--------------------------------------------------------------------------------
-- Keymaps inside the tutorial buffer
--------------------------------------------------------------------------------

local function set_keymaps()
  local buf = state.buf
  local function bmap(lhs, fn)
    vim.keymap.set('n', lhs, fn, { buffer = buf, nowait = true, silent = true })
  end

  bmap('q', close)
  bmap('<Esc>', close)

  bmap('j', function()
    if state.view == 'menu' then
      state.sel = state.sel % #lessons + 1
      render()
    else
      vim.cmd('normal! j')
    end
  end)
  bmap('k', function()
    if state.view == 'menu' then
      state.sel = (state.sel - 2) % #lessons + 1
      render()
    else
      vim.cmd('normal! k')
    end
  end)
  bmap('<Down>', function()
    vim.api.nvim_feedkeys('j', 'm', false)
  end)
  bmap('<Up>', function()
    vim.api.nvim_feedkeys('k', 'm', false)
  end)

  bmap('<CR>', function()
    if state.view == 'menu' then
      open_lesson(state.sel)
    end
  end)
  bmap('l', function()
    if state.view == 'menu' then
      open_lesson(state.sel)
    end
  end)
  bmap('h', function()
    if state.view == 'lesson' then
      back_to_menu()
    end
  end)
  bmap('<BS>', function()
    if state.view == 'lesson' then
      back_to_menu()
    end
  end)

  bmap('n', function()
    if state.view == 'lesson' then
      open_lesson(state.idx % #lessons + 1)
    end
  end)
  bmap('p', function()
    if state.view == 'lesson' then
      open_lesson((state.idx - 2) % #lessons + 1)
    end
  end)

  for i = 1, math.min(9, #lessons) do
    bmap(tostring(i), function()
      open_lesson(i)
    end)
  end
end

--------------------------------------------------------------------------------
-- Entry point
--------------------------------------------------------------------------------

function M.open()
  set_hl()

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_set_current_win(state.win)
    return
  end

  state.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[state.buf].bufhidden = 'wipe'
  vim.bo[state.buf].filetype = 'tutorial'

  local height = math.min(34, math.floor(vim.o.lines * 0.85))
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - WIDTH) / 2)

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = 'editor',
    width = WIDTH,
    height = height,
    row = math.max(0, row),
    col = math.max(0, col),
    style = 'minimal',
    border = 'rounded',
    title = ' 🎓 Tutorial ',
    title_pos = 'center',
  })

  vim.wo[state.win].wrap = false
  vim.wo[state.win].cursorline = false
  vim.wo[state.win].winhighlight = 'FloatBorder:TutBannerB,FloatTitle:TutBanner'

  state.view = 'menu'
  set_keymaps()
  render()
end

function M.setup()
  vim.api.nvim_create_user_command('Tutorial', M.open, { desc = 'Open the interactive config tutorial' })
  vim.keymap.set('n', '<leader>?', M.open, { desc = 'Open the interactive tutorial' })
end

return M

-- vim: ts=2 sts=2 sw=2 et
