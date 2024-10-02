module SCSSLint
  class Reporter::GithubReporter < Reporter

    ESCAPE_MAP = { '%' => '%25', "\n" => '%0A', "\r" => '%0D' }.freeze

    def report_lints
      return unless lints.any?

      "#{lints.map { |lint| "::#{lint.severity} #{location(lint)}::#{message(lint)}" }.join("\n")}"
    end

  private

    def location(lint)
      [
        "file=#{lint.filename}",
        "line=#{lint.location.line.to_s}"
      ].join(',')
    end

    def message(lint)
      "#{lint.linter.name}:#{lint.description}"
    end

    def github_escape(string)
      string.gsub(Regexp.union(ESCAPE_MAP.keys), ESCAPE_MAP)
    end
  end
end
