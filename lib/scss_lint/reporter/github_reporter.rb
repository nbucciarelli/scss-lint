module SCSSLint
  class Reporter::GithubReporter < Reporter
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
  end
end
