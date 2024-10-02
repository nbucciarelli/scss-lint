module SCSSLint
  # Reports a single line per lint.
  class Reporter::GithubReporter < Reporter
    def report_lints
      return unless lints.any?

      # "#{lints.map { |lint| "#{location(lint)} #{type(lint)} #{message(lint)}" }.join("\n")}\n"
      # ::#{severity} file=#{lint.filename},line=#{lint.line}::#{github_escape(lint.message)}"
      "#{lints.map { |lint| "::#{type(lint)} file=#{location(lint)},line=#{123}::#{message(lint)}" }.join("\n")}\n"
    end

  private

    def location(lint)
      [
        log.cyan(lint.filename),
        log.magenta(lint.location.line.to_s),
        log.magenta(lint.location.column.to_s),
      ].join(':')
    end

    def type(lint)
      lint.error? ? log.red('::error') : log.yellow('::warning')
    end

    def message(lint)
      linter_name = log.green("#{lint.linter.name}: ")
      "#{linter_name}#{lint.description}"
    end
  end
end
