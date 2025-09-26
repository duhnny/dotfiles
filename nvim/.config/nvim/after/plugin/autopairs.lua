local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("$$","$$",{"tex", "latex"}))

npairs.add_rule(Rule("$", "$",{"tex", "latex"}))
