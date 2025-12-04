require('CopilotChat').setup({
	keymap = {
		-- chat = '<leader>cc',
		-- close = '<leader>cC',
		-- toggle = '<leader>ai',
		-- scroll_up = '<C-u>',
		-- scroll_down = '<C-d>',
	},
	window = {
		layout = 'vertical',
		relative = 'cursor',
		width = 0.5,
	},
	-- answer_header = function()
	-- 	local model = require("CopilotChat.config").options.model or "Copilot"
	-- 	return "## " .. model .. " "
	-- end,
	-- The default model is 'gpt-4o'
	model = 'gpt-4o',
	provider = 'openai',                         -- or 'anthropic' for Claude
	openai_api_key = os.getenv('OPENAI_API_KEY'), -- Set your OpenAI API key here
	-- The default max tokens is 1000
})

local prompts = {
	Explain          = 'Please explain how this code works in detail.',
	Explain_function = 'What does this function do?',
	Improve          = 'How can I improve this code?',
	Issues           = 'What are the potential issues with this code?',
}

-- require('CopilotChat').setup_prompts(prompts)
