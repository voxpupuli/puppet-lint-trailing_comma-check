PuppetLint.new_check(:trailing_comma) do
  def array_indexes
    results = []
    tokens.each_with_index do |token, token_idx|
      if token.type == :LBRACK
        real_idx = 0
        tokens[token_idx+1..-1].each_with_index do |cur_token, cur_token_idx|
          real_idx = token_idx + 1 + cur_token_idx
          break if cur_token.type == :RBRACK
        end

        results << {
          :start  => token_idx,
          :end    => real_idx,
          :tokens => tokens[token_idx..real_idx],
        }
      end
    end
    results
  end

  def defaults_indexes
    results = []
    tokens.each_with_index do |token, token_idx|
      if token.type == :CLASSREF && token.next_code_token && \
         token.next_code_token.type == :LBRACE
        real_idx = 0

        tokens[token_idx+1..-1].each_with_index do |cur_token, cur_token_idx|
          real_idx = token_idx + 1 + cur_token_idx
          break if cur_token.type == :RBRACE
        end

        results << {
          :start  => token_idx,
          :end    => real_idx,
          :tokens => tokens[token_idx..real_idx],
        }
      end
    end
    results
  end

  def check_elem(elem, except_type)
    lbo_token = elem[:tokens][-1].prev_code_token
    if lbo_token && lbo_token.type != except_type && \
                    elem[:tokens][-1].type != :SEMIC && \
                    lbo_token.type != :COMMA && \
                    lbo_token.next_token.type == :NEWLINE
      notify :warning, {
        :message => 'missing trailing comma after last element',
        :line    => lbo_token.next_token.line,
        :column  => lbo_token.next_token.column,
        :token   => lbo_token.next_token,
      }
    end
  end

  def check
    # Resource and class declarations
    resource_indexes.each do |resource|
      check_elem(resource, :COLON)
    end

    # Arrays
    array_indexes.each do |array|
      check_elem(array, :LBRACK)
    end

    # Defaults
    defaults_indexes.each do |defaults|
      check_elem(defaults, :LBRACE)
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
