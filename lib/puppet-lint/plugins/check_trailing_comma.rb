PuppetLint.new_check(:trailing_comma) do
  def check
    # Resource and class declarations
    resource_indexes.each do |resource|
      lbo_token = resource[:tokens][-1].prev_code_token
      if lbo_token && lbo_token.type != :COLON && \
                      resource[:tokens][-1].type != :SEMIC && \
                      lbo_token.type != :COMMA && \
                      lbo_token.next_token.type == :NEWLINE
        notify :warning, {
          :message => 'missing trailing comma after last parameter',
          :line    => lbo_token.next_token.line,
          :column  => lbo_token.next_token.column,
          :token   => lbo_token.next_token,
        }
      end
    end
  end

  def fix(problem)
    comma = PuppetLint::Lexer::Token.new(
      :COMMA,
      ',',
      problem[:token].line,
      problem[:token].column
    )

    idx = tokens.index(problem[:token])
    tokens.insert(idx, comma)
  end
end
