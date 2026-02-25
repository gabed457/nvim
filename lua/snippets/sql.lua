local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- SELECT query
  s('sel', {
    t('SELECT '),
    i(1, '*'),
    t({ '', 'FROM ' }),
    i(2, 'table_name'),
    t({ '', 'WHERE ' }),
    i(3, '1=1'),
    t(';'),
  }),

  -- INSERT statement
  s('ins', {
    t('INSERT INTO '),
    i(1, 'table_name'),
    t(' ('),
    i(2, 'columns'),
    t({ ')', 'VALUES (', '  ' }),
    i(3, 'values'),
    t({ '', ');' }),
  }),

  -- UPDATE statement
  s('upd', {
    t('UPDATE '),
    i(1, 'table_name'),
    t({ '', 'SET ' }),
    i(2, 'column = value'),
    t({ '', 'WHERE ' }),
    i(3, 'condition'),
    t(';'),
  }),

  -- Common CTE pattern
  s('cte', {
    t('WITH '),
    i(1, 'cte_name'),
    t({ ' AS (', '  SELECT ' }),
    i(2, '*'),
    t({ '', '  FROM ' }),
    i(3, 'table_name'),
    t({ '', '  WHERE ' }),
    i(4, '1=1'),
    t({ '', ')', 'SELECT * FROM ' }),
    i(5, 'cte_name'),
    t(';'),
  }),

  -- JOIN pattern
  s('join', {
    t('SELECT '),
    i(1, 'a.*'),
    t({ '', 'FROM ' }),
    i(2, 'table1'),
    t(' a'),
    t({ '', 'INNER JOIN ' }),
    i(3, 'table2'),
    t(' b ON a.'),
    i(4, 'id'),
    t(' = b.'),
    i(5, 'table1_id'),
    t({ '', 'WHERE ' }),
    i(6, '1=1'),
    t(';'),
  }),

  -- MSSQL top N
  s('top', {
    t('SELECT TOP '),
    i(1, '100'),
    t(' '),
    i(2, '*'),
    t({ '', 'FROM ' }),
    i(3, 'table_name'),
    t({ '', 'ORDER BY ' }),
    i(4, '1'),
    t(';'),
  }),
}

-- vim: ts=2 sts=2 sw=2 et
