local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- Async handler boilerplate
  s('asynchandler', {
    t('async '),
    i(1, 'handler'),
    t('('),
    i(2, 'request'),
    t(': '),
    i(3, 'FastifyRequest'),
    t(', '),
    i(4, 'reply'),
    t(': '),
    i(5, 'FastifyReply'),
    t({ '): Promise<void> {', '  try {', '    ' }),
    i(6),
    t({ '', '  } catch (error) {', '    ' }),
    i(7, 'reply.status(500).send({ error: "Internal server error" });'),
    t({ '', '  }', '}' }),
  }),

  -- Error handling try-catch
  s('trycatch', {
    t({ 'try {', '  ' }),
    i(1),
    t({ '', '} catch (error) {', '  ' }),
    i(2, 'console.error(error);'),
    t({ '', '  throw error;', '}' }),
  }),

  -- Describe/it test scaffold
  s('desc', {
    t("describe('"),
    i(1, 'module'),
    t({ "', () => {", "  it('should " }),
    i(2, 'do something'),
    t({ "', async () => {", '    ' }),
    i(3),
    t({ '', '  });', '});' }),
  }),

  -- Single it block
  s('it', {
    t("it('should "),
    i(1, 'do something'),
    t({ "', async () => {", '  ' }),
    i(2),
    t({ '', '});' }),
  }),

  -- Fastify route plugin
  s('froute', {
    t({ "import { FastifyInstance } from 'fastify';", '', 'export default async function (fastify: FastifyInstance) {', "  fastify." }),
    i(1, 'get'),
    t("('"),
    i(2, '/'),
    t({ "', async (request, reply) => {", '    ' }),
    i(3),
    t({ '', '  });', '}' }),
  }),

  -- Fastify plugin
  s('fplugin', {
    t({ "import fp from 'fastify-plugin';", "import { FastifyInstance } from 'fastify';", '', 'export default fp(async function (fastify: FastifyInstance) {', '  ' }),
    i(1),
    t({ '', '});' }),
  }),

  -- NestJS controller method
  s('nestmethod', {
    t('@'),
    i(1, 'Get'),
    t("('"),
    i(2),
    t({ "')", 'async ' }),
    i(3, 'methodName'),
    t('('),
    i(4),
    t('): Promise<'),
    i(5, 'void'),
    t({ '> {', '  ' }),
    i(6),
    t({ '', '}' }),
  }),
}

-- vim: ts=2 sts=2 sw=2 et
