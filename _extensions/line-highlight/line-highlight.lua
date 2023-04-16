local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
  name = "line-highlight",
  version = "1.0.0",
  scripts = {
    { path = "resources/js/line-highlight.js", attribs = {defer = "true"} }
  },
  stylesheets = {"resources/css/line-highlight.css"}
})
end


local function highlight_source(line_number)
  -- adding line-number attrs for executable code blocks
  local source_highlighter = {
    CodeBlock = function(block)
      block.attributes["data-code-line-numbers"] = line_number
      return block
    end
    }
  return source_highlighter
end


local function highlight_output(line_number)
  -- adding line-number attrs for output blocks
  local output_highlighter = {
    CodeBlock = function(block)
      if block.classes:includes('highlight') then
        block.attributes["data-code-line-numbers"] = line_number
        return block
      end
    end
  }
  return output_highlighter
end


if FORMAT == "html" then
  -- ensuring dependencies for line-highlighting
  ensureHtmlDeps()
  
  -- line-highlighting for executable code blocks and output block
  function Div(el)
    if el.classes:includes('cell') then
      source_line_number = tostring(el.attributes["source-line-numbers"])
      output_line_number = tostring(el.attributes["output-line-numbers"])
      local div = el:walk(highlight_source(source_line_number))
      div = div:walk(highlight_output(output_line_number))
      return div
    end
  end
  
  -- line-highlighting for syntactically formatted markdown code blocks
  -- (i.e. for non-executable code blocks)
  function CodeBlock(cb)
    if cb.attributes["source-line-numbers"] then
      cb.attributes["data-code-line-numbers"] = cb.attributes["source-line-numbers"]
      return cb
    end
  end

end





