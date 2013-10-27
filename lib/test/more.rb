module Test
  module More
    def ok got, label
      if got
        pass label
      else
        failed label
      end
    end

    def use_ok library, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def require_ok library, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def is got, want, label
      if got.to_s == want.to_s
        pass label
      else
        failed label
        diag "\
      got: '#{got}'
 expected: '#{want}'"
      end
    end

    def isnt got, dont, label
      if got.to_s != want.to_s
        pass label
      else
        failed label
        diag "\
      got: '#{got}'
 expected: anything else"
      end
    end

    def like got, regex, label
      if got =~ regex
        pass label
      else
        failed label
        diag "Got: '#{got}'"
      end
    end

    def unlike got, regex, label
      if got !~ regex
        pass label
      else
        failed label
        diag "Got: '#{got}'"
      end
    end

    def is_deeply got, want, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def cmp_ok got, want, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def skip reason
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def todo label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def todo_skip got, want, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def pass label
      $test_more.run_incr
      if ! label.empty?
        puts "ok #{$test_more.run} - #{label}"
        $stderr.flush
      else
        puts "ok #{$test_more.run}"
      end
      $stdout.flush
    end

    def failed label
      $test_more.run_incr
      $test_more.failed_incr
      if ! label.empty?
        puts "not ok #{$test_more.run} - #{label}"
      else
        puts "not ok #{$test_more.run}"
      end
      $stdout.flush
    end

    def eq_array got, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def eq_hash got, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def eq_set got, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def plan cmd, arg
      fail 'Usage: plan tests <number>' unless cmd and arg
      if cmd == 'tests'
        fail 'Plan must be a number' unless arg.to_s =~ /^-?[0-9]+$/
        fail 'Plan must greater then 0' unless arg > 0
        $test_more.plan = arg
        puts "1..#{$test_more.plan}"
      elsif cmd == 'skip_all'
        puts "1..0 # SKIP #{arg}"
        exit 0
      else
        fail 'Usage: plan tests <number>'
      end
      $stdout.flush
    end

    def done_testing count=nil
      count ||= $test_more.run
      puts "1..#{count}"
      $stdout.flush
    end

    def can_ok method, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def isa_ok class_, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def new_ok class_, label
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def diag msg
      fail unless msg
      msg.gsub! /\n/, "\n# "
      $stderr.puts "# #{msg}"
      $stderr.flush
    end

    def note msg
      fail unless msg
      msg.gsub! /\n/, "\n# "
      puts "# #{msg}"
      $stdout.flush
    end

    def explain msg
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def subtest label, callback
      fail "Test::More##{__method__.to_s} not yet implemented"
    end

    def BAIL_OUT reason
      fail "Test::More##{__method__.to_s} not yet implemented"
    end
  end

  class Test::Tap
    attr_accessor :plan
    attr_accessor :run
    attr_accessor :failed

    def initialize
      @plan = 0
      @run = 0
      @failed = 0
    end

    def run_incr
      @run += 1
    end

    def failed_incr
      @failed += 1
    end
  end

end

$test_more = Test::Tap.new

def at_exit
  t = $test_more
  if t.plan == 0
    if t.run > 0
      $stderr.puts "# Tests were run but no plan was declared."
    end
  else
    if t.run == 0
      $stderr.puts "# No tests run!"
    elsif t.run != t.plan
      msg = "# Looks like you planned #{t.plan} tests but ran #{t.run}."
      msg.gsub! /tests/, 'test' if t.plan == 1
      $stderr.puts msg
    end
  end
  exit_code = 0
  if t.failed > 0
    exit_code = t.failed
    exit_code = 254 if exit_code > 254
    local msg = "# Looks like you failed #{t.failed tests} of #{t.run} run."
    msg.gsub! /tests/, 'test' if t.failed == 1
    $stderr.puts msg
  end
  $stderr.flush
  exit exit_code
end
